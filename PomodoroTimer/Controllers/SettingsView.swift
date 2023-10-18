//
//  SettingsController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 10.03.2023.
//  01.10.2023

import UIKit

class SettingsView: UIView {
    
    var focusDuration = UserDefaults.standard.integer(forKey: K.focusDurationKey)
    var amountOfPomodoros = UserDefaults.standard.integer(forKey: K.pomodorosNumberKey)
    var shortBreakDuration = UserDefaults.standard.integer(forKey: K.shortBreakDurationKey)
    var longBreakDuration = UserDefaults.standard.integer(forKey: K.longBreakDurationKey)
    var isSwitchOn = UserDefaults.standard.bool(forKey: K.isSwitchOnKey)
    
    var settingsLabel, focusTimeMinutesLabel, focusTimePomodorosLabel, shortBreakTimeMinutesLabel, enableLongBreakLabel, longBreakTimeMinutesLabel: UILabel!
    let longBreakSwitch = UISwitch()
    let focusTimeTextField = UITextField()
    let shortBreakTextField = UITextField()
    let longBreakTextField = UITextField()
    let pomodorosNumberTextField = UITextField()
    
    var pickerView = UIPickerView()
    let numbers = [5,10,15,20,25,30,35]
    var currentEditingTextField: UITextField?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        backgroundColor = .white
        
        let viewStack = createStackView() // a stack View for all the settings
        viewStack.axis = .vertical
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let focusTimeMinutesStack = createStackView() // + value
        focusTimeMinutesLabel = createLabel("Focus duration")
        setTextField(focusDuration, focusTimeTextField)
        focusTimeTextField.delegate = self // we need this for UIPickerView
        focusTimeMinutesStack.addArrangedSubview(focusTimeMinutesLabel)
        focusTimeMinutesStack.addArrangedSubview(focusTimeTextField)
        addSubview(focusTimeMinutesStack)
        
        let focusTimePomodorosStack = createStackView() // + stepper
        focusTimePomodorosLabel = createLabel("Pomodoros")
        setTextField(amountOfPomodoros, pomodorosNumberTextField)
        pomodorosNumberTextField.keyboardType = .numberPad          // оставил тут .numberPad чисто по приколу и ради разнообразия
        focusTimePomodorosStack.addArrangedSubview(focusTimePomodorosLabel)
        focusTimePomodorosStack.addArrangedSubview(pomodorosNumberTextField)
        addSubview(focusTimePomodorosStack)
        
        let shortBreakTimeMinutesStack = createStackView() // + value
        shortBreakTimeMinutesLabel = createLabel("Short Break Duration")
        setTextField(shortBreakDuration, shortBreakTextField)
        shortBreakTextField.delegate = self
        shortBreakTimeMinutesStack.addArrangedSubview(shortBreakTimeMinutesLabel)
        shortBreakTimeMinutesStack.addArrangedSubview(shortBreakTextField)
        addSubview(shortBreakTimeMinutesStack)
        
        let enableLongBreakStack = createStackView() // + toggle
        enableLongBreakLabel = createLabel("Enable Long Break")
        
        if isSwitchOn {
            longBreakSwitch.setOn(true, animated: true)
        } else {
            longBreakSwitch.setOn(false, animated: true)
        }
        
        enableLongBreakStack.addArrangedSubview(enableLongBreakLabel)
        enableLongBreakStack.addArrangedSubview(longBreakSwitch)
        addSubview(enableLongBreakStack)
        
        let longBreakTimeMinutesStack = createStackView() // + value
        longBreakTimeMinutesLabel = createLabel("Long Break Duration")
        setTextField(longBreakDuration, longBreakTextField)
        longBreakTextField.delegate = self
        longBreakTimeMinutesStack.addArrangedSubview(longBreakTimeMinutesLabel)
        longBreakTimeMinutesStack.addArrangedSubview(longBreakTextField)
        addSubview(longBreakTimeMinutesStack)
        
        // main viewStack is below:
        viewStack.addArrangedSubview(focusTimeMinutesStack)
        viewStack.addArrangedSubview(focusTimePomodorosStack)
        viewStack.addArrangedSubview(shortBreakTimeMinutesStack)
        viewStack.addArrangedSubview(enableLongBreakStack)
        viewStack.addArrangedSubview(longBreakTimeMinutesStack)
        
        addSubview(viewStack)
        viewStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4).isActive = true
        viewStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        viewStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
    }
}

extension SettingsView: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(numbers[row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = pickerView.delegate?.pickerView?(pickerView, titleForRow: row, forComponent: component)
        if let textField = currentEditingTextField {
            textField.text = selectedValue
        }
    }
}

extension SettingsView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentEditingTextField = textField
//      показываем UIPickerView или делаем другие действия, чтобы отобразить его
        pickerView.isHidden = false
        textField.inputView = pickerView
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        currentEditingTextField = nil
    }

}

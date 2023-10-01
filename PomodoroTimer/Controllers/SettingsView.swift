//
//  SettingsController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 10.03.2023.
//  01.10.2023

import UIKit

class SettingsView: UIView {
   
//    Rows:
//    Focus Time
//    Focus Streaks
//    Short Break Time
//    Enable long break
//    Long Break Time
    
    var focusDuration = 25
    var amountOfPomodoros = 4
    var shortBreakDuration = 5
    var longBreakDuration = 20
    
    var settingsLabel, focusTimeMinutesLabel, focusTimePomodorosLabel, shortBreakTimeMinutesLabel, enableLongBreakLabel, longBreakTimeMinutesLabel: UILabel!
    
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
        
        
        
        let focusTimeMinutesStack = createStackView() // + value
        focusTimeMinutesLabel = createLabel("Focus duration")
        let focusTimeTextField = UITextField()
        focusTimeTextField.placeholder = "\(focusDuration)"
        focusTimeTextField.keyboardType = .numberPad
        focusTimeTextField.text = String(focusDuration)
        focusTimeTextField.font = .robotoFlex(size: 30)
        
        focusTimeMinutesStack.addArrangedSubview(focusTimeMinutesLabel)
        focusTimeMinutesStack.addArrangedSubview(focusTimeTextField)
        addSubview(focusTimeMinutesStack)
        
        focusTimeMinutesStack.distribution = .fill
        focusTimeMinutesStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        focusTimeMinutesStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        
        let focusTimePomodorosStack = createStackView() // + stepper
        focusTimePomodorosLabel = createLabel("Pomodoros, \(amountOfPomodoros)")
        let focusTimePomodorosStepper = UIStepper()
        
        focusTimePomodorosStack.addArrangedSubview(focusTimePomodorosLabel)
        focusTimePomodorosStack.addArrangedSubview(focusTimePomodorosStepper)
        addSubview(focusTimePomodorosStack)
        
        focusTimePomodorosStack.distribution = .fill
        focusTimePomodorosStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        focusTimePomodorosStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        
        let shortBreakTimeMinutesStack = createStackView() // + value
        shortBreakTimeMinutesLabel = createLabel("Short Break Duration   ")
        let shortBreakTextField = UITextField()
        shortBreakTextField.placeholder = "\(shortBreakDuration)"
        shortBreakTextField.keyboardType = .numberPad
        shortBreakTextField.text = String(shortBreakDuration)
        shortBreakTextField.font = .robotoFlex(size: 30)
        
        shortBreakTimeMinutesStack.addArrangedSubview(shortBreakTimeMinutesLabel)
        shortBreakTimeMinutesStack.addArrangedSubview(shortBreakTextField)
        addSubview(shortBreakTimeMinutesStack)
        
        shortBreakTimeMinutesStack.distribution = .fill
        shortBreakTimeMinutesStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        shortBreakTimeMinutesStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        
        let enableLongBreakStack = createStackView() // + toggle
        enableLongBreakLabel = createLabel("Enable Long Break")
        let enableLongBreakSwitch = UISwitch()
        enableLongBreakSwitch.isOn = true
        
        enableLongBreakStack.addArrangedSubview(enableLongBreakLabel)
        enableLongBreakStack.addArrangedSubview(enableLongBreakSwitch)
        addSubview(enableLongBreakStack)
        
        enableLongBreakStack.distribution = .fill
        enableLongBreakStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        enableLongBreakStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        
        let longBreakTimeMinutesStack = createStackView() // + value
        longBreakTimeMinutesLabel = createLabel("Long Break Duration   ")
        let longBreakTextField = UITextField()
        longBreakTextField.placeholder = "\(longBreakDuration)"
        longBreakTextField.keyboardType = .numberPad
        longBreakTextField.text = String(longBreakDuration)
        longBreakTextField.font = .robotoFlex(size: 30)
        
        longBreakTimeMinutesStack.addArrangedSubview(longBreakTimeMinutesLabel)
        longBreakTimeMinutesStack.addArrangedSubview(longBreakTextField)
        addSubview(longBreakTimeMinutesStack)
        
        longBreakTimeMinutesStack.distribution = .fill
        longBreakTimeMinutesStack.alignment = .trailing
        longBreakTimeMinutesStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        longBreakTimeMinutesStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        
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

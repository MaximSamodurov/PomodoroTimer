//
//  Settings .swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 10.03.2023.
//  01.10.2023

import UIKit

class SettingsController: UIViewController {
    
    let settingsView: SettingsView
    
    init() {
        settingsView = SettingsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.robotoFlex(size: 50),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        view.addSubview(settingsView)
        settingsView.fillSuperview()
        
        settingsView.longBreakSwitch.addTarget(self, action: #selector(self.switchValueChanged(_:)), for: .valueChanged)
        settingsView.focusTimeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        settingsView.shortBreakTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        settingsView.longBreakTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
          // функция для выполнения действий при изменении положения UISwitch. строка ниже сохраняет уведомления, которые мы потом будем использовать в FocusController
        NotificationCenter.default.post(name: Notification.Name("SwitchValueChanged"), object: nil, userInfo: ["isOn": sender.isOn])

        UserDefaults.standard.set(sender.isOn, forKey: K.isSwitchOnKey)
//        print("userDefaults SwitchIsOn",UserDefaults.standard.bool(forKey: K.isSwitchOnKey))
      }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        // код для обработки изменений в тексте
        
        switch textField {
        case settingsView.focusTimeTextField:
            if let updatedText = textField.text {
                NotificationCenter.default.post(name: Notification.Name("FocusDurationChanged"), object: nil, userInfo: ["focusDuration": updatedText])
            }
        case settingsView.shortBreakTextField:
            if let updatedText = textField.text {
                NotificationCenter.default.post(name: Notification.Name("ShortBreakDurationChanged"), object: nil, userInfo: ["shortBreakDuration": updatedText])
            }
        case settingsView.longBreakTextField:
            if let updatedText = textField.text {
                NotificationCenter.default.post(name: Notification.Name("LongBreakDurationChanged"), object: nil, userInfo: ["longBreakDuration": updatedText])
            }
            
        default: print ("well well well, something isn't right")
        }
    }
}

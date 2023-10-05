//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import UIKit

class FocusController: TimerController {
    
    let focusView = FocusView(frame: CGRect.zero)
    var isSwitchOn = UserDefaults.standard.bool(forKey: K.isSwitchOnKey)
    var duration = UserDefaults.standard.integer(forKey: K.focusDurationKey)
    var pomodorosNumber = UserDefaults.standard.integer(forKey: K.pomodorosNumberKey)
    let aDecoder = NSCoder()

    init() {
        super.init(totalTimeInSecondsIs: duration * 60, minutesOnClock: duration, currentTimerName: "focus")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var focusTimeCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(focusView)
        focusView.fillSuperview()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSwitchValueChanged(_:)), name: Notification.Name("SwitchValueChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(focusTimeDurationChanged(_:)), name: Notification.Name("FocusDurationChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pomodorosNumberChanged(_:)), name: Notification.Name("PomodorosNumberChanged"), object: nil)
        focusView.pausePlayButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        focusView.nextSectionButton.addTarget(self, action: #selector(nextSection), for: .touchUpInside)
        focusView.threeDotsButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        
        focusView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        focusView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
    }
    
    override func startTimer(){
        super.startTimer()
        focusView.pausePlayButton.setImage(UIImage(systemName: K.pauseButtonName, withConfiguration: config), for: .normal)
    }
    
    override func stopTimer() {
        super.stopTimer()
        focusView.pausePlayButton.setImage(UIImage(systemName: K.playButtonName, withConfiguration: config), for: .normal)
    }
    
    
    @objc override func resetTimer() {
        super.resetTimer()
        focusView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        focusView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
    }
    
    override func setTimeLabel(_ val: Int) {
        super.setTimeLabel(val)
        
        focusView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        focusView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
        if secondsLeft == 0 {
            nextSection()
        }
    }
    
    
    @objc override func nextSection() {
        super.nextSection()
        
        focusTimeCount += 1
//        print("current focusTimeCount is", focusTimeCount)
        if focusTimeCount >= pomodorosNumber { //if our goal is 4 Focus Times
            if isSwitchOn {
                let longBreakVC = LongBreakController()
                self.present(longBreakVC, animated: true)
                longBreakVC.resetTimer()
                longBreakVC.playPause()
                focusTimeCount = 0
            } else {
                focusTimeCount = 0
            }
        } else {
             let shortBreakVC = ShortBreakController()
                shortBreakVC.shortBreakCompletion = {
                    //                 код, который должен быть запущен после завершения ShortBreak
                    self.playPause()
                }
                // Показываем ShortBreakTimeViewController
                self.present(shortBreakVC, animated: true, completion: nil)
                shortBreakVC.resetTimer()
                shortBreakVC.playPause()
            }
        
    }
    
    @objc func handleSwitchValueChanged(_ notification: Notification) {
        if let isOn = notification.userInfo?["isOn"] as? Bool {
            // нужно обновить значение isSwitchOn, а то иначе он будет использовать только, которое существовало при инициализации FocusController
            isSwitchOn = isOn

            if isOn {
//                print("is switch on? \(isSwitchOn)")
                //  действия при включенном UISwitch
            } else {
//                print("is switch on? \(isSwitchOn)")
                //  действия при выключенном UISwitch
            }
        }
    }
    
    @objc func focusTimeDurationChanged(_ notification: Notification) {
        if let time = notification.userInfo?["focusDuration"] as? Int {
            duration = time
            totalTimeInSecondsIs = time * 60
            minutesOnClock = time
            resetTimer()
        }
    }
    
    @objc func pomodorosNumberChanged(_ notification: Notification) {
        if let number = notification.userInfo?["pomodorosNumber"] as? Int {
            pomodorosNumber = number
        }
    }
}

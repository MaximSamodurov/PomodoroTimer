//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import UIKit

class LongBreakController: TimerController {
    
    let longBreakView = LongBreakView(frame: CGRect.zero)
    var duration = UserDefaults.standard.integer(forKey: K.longBreakDurationKey)
    let aDecoder = NSCoder()
    
    init() {
        super.init(totalTimeInSecondsIs: duration * 60, minutesOnClock: duration, currentTimerName: "longBreak")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(longBreakView)
        longBreakView.fillSuperview()
        
        NotificationCenter.default.addObserver(self, selector: #selector(longBreakDurationChanged(_:)), name: Notification.Name("LongBreakDurationChanged"), object: nil)
        
        longBreakView.pausePlayButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        longBreakView.nextSectionButton.addTarget(self, action: #selector(nextSection), for: .touchUpInside)
        longBreakView.threeDotsButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        
        longBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        longBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
    }
    
    override func startTimer(){
        super.startTimer()
        longBreakView.pausePlayButton.setImage(UIImage(systemName: K.pauseButtonName, withConfiguration: config), for: .normal)
    }

    override func stopTimer() {
        super.stopTimer()
        longBreakView.pausePlayButton.setImage(UIImage(systemName: K.playButtonName, withConfiguration: config), for: .normal)
    }

    @objc override func resetTimer() {
        super.resetTimer()
        
        longBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        longBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
    }

    override func setTimeLabel(_ val: Int) {
        super.setTimeLabel(val)

        longBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        longBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)

        if secondsLeft == 0 {
            nextSection()
        }
    }
    
    @objc override func nextSection() {
        super.nextSection()
        stopTimer()
        // Перейти к корневому UIViewController (который в UINavigationController).
        dismiss(animated: true)
    }
    
    @objc func longBreakDurationChanged(_ notification: Notification) {
        if let time = notification.userInfo?["shortBreakDuration"] as? Int {
            duration = time
        }
    }
}


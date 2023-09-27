//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import UIKit

class LongBreakViewController: TimerController {
    
    let longBreakView = LongBreakView(frame: CGRect.zero)
    let aDecoder = NSCoder()
    
    init() {
        super.init(totalTimeInSeconds: 20 * 60, minutesOnClock: 20, secondsOnClock: 00, secondsLeft: 0, currentTimerName: "longBreak")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(longBreakView)
        longBreakView.fillSuperview()
        
        longBreakView.pausePlayButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        longBreakView.nextSectionButton.addTarget(self, action: #selector(nextSection), for: .touchUpInside)
        
        longBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        longBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
        
        startTime = userDefaults.object(forKey: K.longBreakStartTimeKey) as? Date
        stopTime = userDefaults.object(forKey: K.longBreakStopTimeKey) as? Date
        isCounting = userDefaults.bool(forKey: K.longBreakCountingKey)
    }
    
    override func startTimer(){
        super.startTimer()
        longBreakView.pausePlayButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: config), for: .normal)
    }

    override func stopTimer() {
        super.stopTimer()
        longBreakView.pausePlayButton.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
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
        // Перейти к корневому UIViewController (находящемуся в UINavigationController).
        dismiss(animated: true)
    }
}


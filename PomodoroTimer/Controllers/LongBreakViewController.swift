//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import UIKit

class LongBreakViewController: UIViewController {
    
    let longBreakView = LongBreakView(frame: CGRect.zero)

    var timer = Timer()
    let totalTimeInSecondsIs = 20*60
    
    var minutesOnClock: Int = 0
    var secondsOnClock: Int = 0
    
    var secondsLeft: Int?
    var isCounting = false
    var startTime: Date?
    var stopTime: Date?
    
    let userDefaults = UserDefaults.standard
    let StartTimeKey = "longBreakStartTime"
    let StopTimeKey = "longBreakStopTime"
    let CountingKey = "longBreakCountingKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(longBreakView)
        longBreakView.fillSuperview()
        longBreakView.pausePlayButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        longBreakView.nextSectionButton.addTarget(self, action: #selector(nextSection), for: .touchUpInside)
    }
    
    @objc func playPause() {
    }
    
    @objc func nextSection() {
        // Перейти к корневому UIViewController (находящемуся в UINavigationController).
        dismiss(animated: true)
    }
}


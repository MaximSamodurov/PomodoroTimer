//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import UIKit

class ShortBreakController: TimerController {
    
    let shortBreakView = ShortBreakView(frame: CGRect.zero)
    var shortBreakCompletion: (() -> Void)?
    var duration = UserDefaults.standard.integer(forKey: K.shortBreakDurationKey)
    let aDecoder = NSCoder()
    
    init() {
        super.init(totalTimeInSecondsIs: duration * 60, minutesOnClock: duration, currentTimerName: "shortBreak")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(shortBreakView)
        shortBreakView.fillSuperview()
        
        NotificationCenter.default.addObserver(self, selector: #selector(shortBreakDurationChanged(_:)), name: Notification.Name("ShortBreakDurationChanged"), object: nil)

        shortBreakView.pausePlayButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        shortBreakView.nextSectionButton.addTarget(self, action: #selector(nextSection), for: .touchUpInside)
        shortBreakView.threeDotsButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        
        shortBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        shortBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
    }
    
    override func startTimer(){
        super.startTimer()
        shortBreakView.pausePlayButton.setImage(UIImage(systemName: K.pauseButtonName, withConfiguration: config), for: .normal)
    }
    
    override func stopTimer() {
        super.stopTimer()
        shortBreakView.pausePlayButton.setImage(UIImage(systemName: K.playButtonName, withConfiguration: config), for: .normal)
    }

    @objc override func resetTimer() {
        super.resetTimer()
        shortBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        shortBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
    }

    override func setTimeLabel(_ val: Int) {
        super.setTimeLabel(val)

        shortBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        shortBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
        if secondsLeft == 0 {
            nextSection()
        }
    }

    @objc override func nextSection() {
        super.nextSection()
        stopTimer()
//      В момент завершения Short Break
        self.dismiss(animated: true) { [weak self] in
//      Вызываем замыкание при завершении анимации
            self?.shortBreakCompletion?()
        }
    }
    
    @objc func shortBreakDurationChanged(_ notification: Notification) {
        if let time = notification.userInfo?["shortBreakDuration"] as? Int {
                duration = time
        }
    }
}

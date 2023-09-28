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

    let aDecoder = NSCoder()
    
    init() {
        super.init(totalTimeInSecondsIs: 5 * 60, minutesOnClock: 5, secondsOnClock: 00, secondsLeft: 0, currentTimerName: "shortBreak")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(shortBreakView)
        shortBreakView.fillSuperview()
        
        shortBreakView.pausePlayButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        shortBreakView.nextSectionButton.addTarget(self, action: #selector(nextSection), for: .touchUpInside)
        shortBreakView.threeDotsButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        
        shortBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        shortBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
        
        startTime = userDefaults.object(forKey: K.shortBreakStartTimeKey) as? Date
        stopTime = userDefaults.object(forKey: K.shortBreakStopTimeKey) as? Date
        isCounting = userDefaults.bool(forKey: K.shortBreakCountingKey)
    }
    
    override func startTimer(){
        super.startTimer()
        shortBreakView.pausePlayButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: config), for: .normal)
    }
    
    override func stopTimer() {
        super.stopTimer()
        shortBreakView.pausePlayButton.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
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
        // В момент завершения Short Break
        self.dismiss(animated: true) { [weak self] in
            // Вызываем замыкание при завершении анимации
            self?.shortBreakCompletion?()
        }
    }
}

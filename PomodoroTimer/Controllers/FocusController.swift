//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import UIKit

class FocusController: TimerController {
    
    let focusView = FocusView(frame: CGRect.zero)
    let aDecoder = NSCoder()

    init() {
        super.init(totalTimeInSeconds: 25 * 60, minutesOnClock: 25, secondsOnClock: 00, secondsLeft: 0, currentTimerName: "focus")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var focusTimeCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(focusView)
        focusView.fillSuperview()

        focusView.pausePlayButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        focusView.nextSectionButton.addTarget(self, action: #selector(nextSection), for: .touchUpInside)
        focusView.threeDotsButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        
        focusView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        focusView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
        
        startTime = userDefaults.object(forKey: K.focusStartTimeKey) as? Date
        stopTime = userDefaults.object(forKey: K.focusStopTimeKey) as? Date
        isCounting = userDefaults.bool(forKey: K.focusCountingKey)
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
        
        if focusTimeCount >= 4 { //if our goal is 4 Focus Times
//            let longBreakVC = LongBreakViewController()
//            self.present(longBreakVC, animated: true)
//            longBreakVC.resetTimer()
//            longBreakVC.playPause()
            focusTimeCount = 0
        } else {
//            let shortBreakVC = ShortBreakController()
//            shortBreakVC.shortBreakCompletion = {
                // код, который должен быть запущен после завершения ShortBreak
//                self.playPause()
//            }
//            // Показываем ShortBreakTimeViewController
//            self.present(shortBreakVC, animated: true, completion: nil)
//            shortBreakVC.resetTimer()
//            shortBreakVC.playPause()
        }
    }
    
    
    @objc func openPopupMenu() {
        print("openPopupMenu")
    }
}

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

//    let aDecoder = NSCoder()
//    
//    init() {
//        super.init(totalTimeInSeconds: 5 * 60, minutesOnClock: 5, secondsOnClock: 00, secondsLeft: 0)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(shortBreakView)
//        shortBreakView.fillSuperview()
//        shortBreakView.pausePlayButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
//        shortBreakView.nextSectionButton.addTarget(self, action: #selector(nextSection), for: .touchUpInside)
//        shortBreakView.threeDotsButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
//        
//        shortBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
//        shortBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
//        
////        startTime = userDefaults.object(forKey: StartTimeKey) as? Date
////        stopTime = userDefaults.object(forKey: StopTimeKey) as? Date
////        isCounting = userDefaults.bool(forKey: CountingKey)
////
//    }
    
//    func startTimer(){
//        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
//        shortBreakView.pausePlayButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: config), for: .normal)
//        setIsCounting(true, timer: "shortBreak")
//    }
//    
////    func stopTimer(){
////        shortBreakView.pausePlayButton.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
////        if let breakTimer = timer {
////            breakTimer.invalidate()
////        }
////        setIsCounting(false, timer: "shortBreak")
////    }
//    
//    func calcRestartTime(start: Date, stop: Date) -> Date {
//        let diff = start.timeIntervalSince(stop)
//        return Date().addingTimeInterval(diff)
//    }
//    
//    @objc func resetTimer() {
//        
//        setStopTime(date: nil, timer: "shortBreak")
//        setStartTime(date: nil, timer: "shortBreak")
//        stopTimer(name: "focus")
//        minutesOnClock = 5
//        secondsOnClock = 00
//        shortBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
//        shortBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
//    }
//    
//    @objc override func playPause() {
//        if isCounting {
//            setStopTime(date: Date(), timer: "shortBreak")
//            stopTimer(name: "focus")
//        } else {
//            if let stop = stopTime {
//                let restartTime = calcRestartTime(start: startTime!, stop: stop)
//                setStopTime(date: nil, timer: "shortBreak")
//                setStartTime(date: restartTime, timer: "shortBreak")
//            }  else {
//                setStartTime(date: Date(), timer: "shortBreak")
//            }
//            startTimer()
//        }
//    }
//
//    func setTimeLabel(_ val: Int) {
//        
//        secondsLeft = totalTimeInSecondsIs - val
//        minutesOnClock = secondsLeft! / 60
//        secondsOnClock = secondsLeft! % 60
//        
//        shortBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
//        shortBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
//        
//        if secondsLeft == 0 {
//            nextSection()
//        }
//    }
//    
//    //MARK: – @objc funcs
//    @objc func refreshValue() {
//        if let start = startTime {
//            let diff = Date().timeIntervalSince(start)
//            setTimeLabel(Int(diff))
//        } else {
//            stopTimer(name: "focus")
//            setTimeLabel(0)
//        }
//    }
//    
//    @objc func nextSection() {
//        stopTimer(name: "focus")
//        // В момент завершения Short Break
//        self.dismiss(animated: true) { [weak self] in
//            // Вызываем замыкание при завершении анимации
//            self?.shortBreakCompletion?()
//        }
//    }
//    
//    @objc func openPopupMenu() {
//        print("openPopupMenu")
//    }
//    
}


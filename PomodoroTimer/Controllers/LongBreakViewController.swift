//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import UIKit

class LongBreakViewController: TimerController {
    
    let longBreakView = LongBreakView(frame: CGRect.zero)

    var timer = Timer()
    let totalTimeInSecondsIs = 5
    
    var minutesOnClock: Int = 20
    var secondsOnClock: Int = 00
    
    var secondsLeft: Int?
//    var isCounting = false
//    var startTime: Date?
//    var stopTime: Date?
//
//    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(longBreakView)
        longBreakView.fillSuperview()
        longBreakView.pausePlayButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        longBreakView.nextSectionButton.addTarget(self, action: #selector(nextSection), for: .touchUpInside)
        
        longBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        longBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        longBreakView.pausePlayButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: config), for: .normal)
        setIsCounting(true, timer: "longBreak")
    }
    
    func stopTimer(){
        longBreakView.pausePlayButton.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
        if timer != nil {
            timer.invalidate()
        }
        setIsCounting(false, timer: "longBreak")
    }
    
    func calcRestartTime(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    
    @objc func resetTimer() {
        
        setStopTime(date: nil, timer: "longBreak")
        setStartTime(date: nil, timer: "longBreak")
        stopTimer()
        minutesOnClock = 20
        secondsOnClock = 00
        longBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        longBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
    }
    
    @objc func playPause() {
        if isCounting {
            setStopTime(date: Date(), timer: "longBreak")
            stopTimer()
        } else {
            if let stop = stopTime {
                let restartTime = calcRestartTime(start: startTime!, stop: stop)
                setStopTime(date: nil, timer: "longBreak")
                setStartTime(date: restartTime, timer: "longBreak")
            }  else {
                setStartTime(date: Date(), timer: "longBreak")
            }
            startTimer()
        }
    }

    func setTimeLabel(_ val: Int) {
        
        secondsLeft = totalTimeInSecondsIs - val
        minutesOnClock = secondsLeft! / 60
        secondsOnClock = secondsLeft! % 60
        
        longBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        longBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
        
        if secondsLeft == 0 {
            nextSection()
        }
    }
    
    //MARK: – @objc funcs
    @objc func refreshValue() {
        if let start = startTime {
            let diff = Date().timeIntervalSince(start)
            setTimeLabel(Int(diff))
        } else {
            stopTimer()
            setTimeLabel(0)
        }
    }
    
    @objc func nextSection() {
        stopTimer()
        // Перейти к корневому UIViewController (находящемуся в UINavigationController).
        dismiss(animated: true)
    }
    

    //MARK: – set user defaults Keys
//    func setStartTime(date: Date?){
//        startTime = date
//        userDefaults.set(startTime, forKey: K.longBreakStartTimeKey)
//    }
//
//    func setStopTime(date: Date?){
//        stopTime = date
//        userDefaults.set(stopTime, forKey: K.longBreakStopTimeKey)
//    }
//    func setIsCounting(_ val: Bool){
//        isCounting = val
//        userDefaults.set(isCounting, forKey: K.longBreakCountingKey)
//    }
}


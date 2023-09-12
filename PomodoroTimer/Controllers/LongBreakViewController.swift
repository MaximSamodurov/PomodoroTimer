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
    let totalTimeInSecondsIs = 5
    
    var minutesOnClock: Int = 20
    var secondsOnClock: Int = 00
    
    var secondsLeft: Int?
    var isCounting = false
    var startTime: Date?
    var stopTime: Date?
    
    let userDefaults = UserDefaults.standard
    let StartTimeKey = "longBreakStartTime"
    let StopTimeKey = "longBreakStopTime"
    let CountingKey = "longBreakCountingKey"
    
    let config = UIImage.SymbolConfiguration(pointSize: 23)
    
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
        setIsCounting(true)
    }
    
    func stopTimer(){
        longBreakView.pausePlayButton.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
        if timer != nil {
            timer.invalidate()
        }
        setIsCounting(false)
    }
    
    func calcRestartTime(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    
    @objc func resetTimer() {
        
        setStopTime(date: nil)
        setStartTime(date: nil)
        stopTimer()
        minutesOnClock = 20
        secondsOnClock = 00
        longBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        longBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
    }
    
    @objc func playPause() {
        if isCounting {
            setStopTime(date: Date())
            stopTimer()
        } else {
            if let stop = stopTime {
                let restartTime = calcRestartTime(start: startTime!, stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
            }  else {
                setStartTime(date: Date())
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
    func setStartTime(date: Date?){
        startTime = date
        userDefaults.set(startTime, forKey: StartTimeKey)
    }
    
    func setStopTime(date: Date?){
        stopTime = date
        userDefaults.set(stopTime, forKey: StopTimeKey)
    }
    func setIsCounting(_ val: Bool){
        isCounting = val
        userDefaults.set(isCounting, forKey: CountingKey)
    }
}


//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import UIKit

class ShortBreakController: UIViewController {
    
    let shortBreakView = ShortBreakView(frame: CGRect.zero)
    var shortBreakCompletion: (() -> Void)?

    var timer = Timer()
    let totalTimeInSecondsIs = 5
    
    var minutesOnClock: Int = 5
    var secondsOnClock: Int = 00
    
    var secondsLeft: Int?
    var isCounting = false
    var startTime: Date?
    var stopTime: Date?
    
    let userDefaults = UserDefaults.standard
    let StartTimeKey = "shortBreakStartTime"
    let StopTimeKey = "shortBreakStopTime"
    let CountingKey = "shortBreakCountingKey"

    let config = UIImage.SymbolConfiguration(pointSize: 23)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shortBreakView)
        shortBreakView.fillSuperview()
        shortBreakView.pausePlayButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        shortBreakView.nextSectionButton.addTarget(self, action: #selector(nextSection), for: .touchUpInside)
        shortBreakView.threeDotsButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        
        shortBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        shortBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
        
//        startTime = userDefaults.object(forKey: StartTimeKey) as? Date
//        stopTime = userDefaults.object(forKey: StopTimeKey) as? Date
//        isCounting = userDefaults.bool(forKey: CountingKey)
//
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        shortBreakView.pausePlayButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: config), for: .normal)
        setIsCounting(true)
    }
    
    func stopTimer(){
        shortBreakView.pausePlayButton.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
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
        minutesOnClock = 5
        secondsOnClock = 00
        shortBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        shortBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
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
        
        shortBreakView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        shortBreakView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
        
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
        // В момент завершения Short Break
        self.dismiss(animated: true) { [weak self] in
            // Вызываем замыкание при завершении анимации
            self?.shortBreakCompletion?()
        }
    }
    
    @objc func openPopupMenu() {
        print("openPopupMenu")
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


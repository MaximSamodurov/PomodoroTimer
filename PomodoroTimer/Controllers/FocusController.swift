//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import UIKit

class FocusController: UIViewController {
    
    let focusView = FocusView(frame: CGRect.zero)
    
    var timer: Timer!
    let totalTimeInSecondsIs = 5
    
    var minutesOnClock: Int = 25
    var secondsOnClock: Int = 00
    
    var secondsLeft: Int?
    var isCounting = false
    var startTime: Date?
    var stopTime: Date?
    
    let userDefaults = UserDefaults.standard
    
    let config = UIImage.SymbolConfiguration(pointSize: 23)
    
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
        
        if isCounting {
            startTimer()
        } else {
            stopTimer()
            if let start = startTime {
                print(start)
                if let stop = stopTime {
                    print(stop)
                    //указываем разницу во времени тут
                    let time = calcRestartTime(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setTimeLabel(Int(diff))
                }
            }
        }
    }
    
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        focusView.pausePlayButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: config), for: .normal)
        setIsCounting(true)
    }
    
    func stopTimer(){
        focusView.pausePlayButton.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
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
        minutesOnClock = 25
        secondsOnClock = 00
        focusView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        focusView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
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
        
        focusView.timeMinutesCounter.text = String(format: "%02d", minutesOnClock)
        focusView.timeSecondsCounter.text = String(format: "%02d", secondsOnClock)
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
        focusTimeCount += 1
        
        if focusTimeCount >= 4 { //if our goal is 4 Focus Times
            let longBreakVC = LongBreakViewController()
            self.present(longBreakVC, animated: true)
            longBreakVC.resetTimer()
            longBreakVC.playPause()
            focusTimeCount = 0
        } else {
            let shortBreakVC = ShortBreakController()
            shortBreakVC.shortBreakCompletion = {
                // код, который должен быть запущен после завершения ShortBreak
                self.playPause()
            }
            // Показываем ShortBreakTimeViewController
            self.present(shortBreakVC, animated: true, completion: nil)
            shortBreakVC.resetTimer()
            shortBreakVC.playPause()
        }
    }
    
    
    @objc func openPopupMenu() {
        print("openPopupMenu")
    }
    
    //MARK: – set user defaults Keys
    func setStartTime(date: Date?){
        startTime = date
        userDefaults.set(startTime, forKey: K.focusStartTimeKey)
    }
    
    func setStopTime(date: Date?){
        stopTime = date
        userDefaults.set(stopTime, forKey: K.focusStopTimeKey)
    }
    func setIsCounting(_ val: Bool){
        isCounting = val
        userDefaults.set(isCounting, forKey: K.focusCountingKey)
    }
}

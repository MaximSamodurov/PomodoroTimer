//
//  TimerViewController.swift
//  PomodoroTimer
//
//  Created by Renat Nazyrov on 13.09.2023.
//

import UIKit

class TimerController: UIViewController {
    var timer: Timer?
    
    var totalTimeInSecondsIs: Int
    var minutesOnClock: Int
    var secondsOnClock: Int = 00
    var secondsLeft: Int? = 0
    
    var currentTimerName: String
    
    var isCounting = false
    var startTime: Date?
    var stopTime: Date?
    
    let userDefaults = UserDefaults.standard
    let config = UIImage.SymbolConfiguration(pointSize: 23)


    init(totalTimeInSecondsIs: Int, minutesOnClock: Int, currentTimerName: String) {
        self.totalTimeInSecondsIs = totalTimeInSecondsIs
        self.minutesOnClock = minutesOnClock
        self.currentTimerName = currentTimerName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        determineStartStopAndIsCounting(timer: currentTimerName)
        
        if isCounting {
            startTimer()
        } else {
            stopTimer()
            if let start = startTime {
                if let stop = stopTime {
                    let time = calcRestartTime(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setTimeLabel(Int(diff))
                }
            }
        }
    }

    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
            setIsCounting(true, timer: currentTimerName)
    }
    
    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
        }
        setIsCounting(false, timer: currentTimerName)
    }
    
    func calcRestartTime(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }

    @objc func resetTimer() {
        setStopTime(date: nil, timer: currentTimerName)
        setStartTime(date: nil, timer: currentTimerName)
        stopTimer()
        minutesOnClock = totalTimeInSecondsIs / 60
        secondsOnClock = 00
    }

    @objc func playPause() {
        if isCounting {
            setStopTime(date: Date(), timer: currentTimerName)
            stopTimer()
        } else {
            if let stop = stopTime {
                let restartTime = calcRestartTime(start: startTime!, stop: stop)
                setStopTime(date: nil, timer: currentTimerName)
                setStartTime(date: restartTime, timer: currentTimerName)
            }  else {
                setStartTime(date: Date(), timer: currentTimerName)
            }
            startTimer()
        }
    }

    func setTimeLabel(_ val: Int) {
        secondsLeft = totalTimeInSecondsIs - val
        minutesOnClock = secondsLeft! / 60
        secondsOnClock = secondsLeft! % 60
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
        // код для перехода к следующему разделу здесь
    }
    
    //MARK: – set user defaults Keys
    func determineStartStopAndIsCounting(timer: String){
        switch timer {
        case "focus":
            startTime = userDefaults.object(forKey: K.focusStartTimeKey) as? Date
            stopTime = userDefaults.object(forKey: K.focusStopTimeKey) as? Date
            isCounting = userDefaults.bool(forKey: K.focusCountingKey)
//            print("focus", startTime)
        case "shortBreak":
            startTime = userDefaults.object(forKey: K.shortBreakStartTimeKey) as? Date
            stopTime = userDefaults.object(forKey: K.shortBreakStopTimeKey) as? Date
            isCounting = userDefaults.bool(forKey: K.shortBreakCountingKey)
//            print("shortBreak", startTime)
        case "longBreak":
            startTime = userDefaults.object(forKey: K.longBreakStartTimeKey) as? Date
            stopTime = userDefaults.object(forKey: K.longBreakStopTimeKey) as? Date
            isCounting = userDefaults.bool(forKey: K.longBreakCountingKey)
//            print("longBreak", startTime)
        default:
            return
        }
    }
    
    func setStartTime(date: Date?, timer: String){
        startTime = date
        switch timer {
        case "focus":
            userDefaults.set(startTime, forKey: K.focusStartTimeKey)
        case "shortBreak":
            userDefaults.set(startTime, forKey: K.shortBreakStartTimeKey)
        case "longBreak":
            userDefaults.set(startTime, forKey: K.longBreakStartTimeKey)
        default:
            return
        }
    }
    
    func setStopTime(date: Date?, timer: String){
        stopTime = date
        switch timer {
        case "focus":
            userDefaults.set(stopTime, forKey: K.focusStopTimeKey)
        case "shortBreak":
            userDefaults.set(stopTime, forKey: K.shortBreakStopTimeKey)
        case "longBreak":
            userDefaults.set(stopTime, forKey: K.longBreakStopTimeKey)
        default:
            return
        }
    }
    
    func setIsCounting(_ val: Bool, timer: String){
        isCounting = val
        switch timer {
        case "focus":
            userDefaults.set(isCounting, forKey: K.focusCountingKey)
        case "shortBreak":
            userDefaults.set(isCounting, forKey: K.shortBreakCountingKey)
        case "longBreak":
            userDefaults.set(isCounting, forKey: K.longBreakCountingKey)
        default:
            return
        }
    }
//    not used yet, need to think how to use it better
//    func setDurationTime(val: Int, timer: String){
//        switch timer {
//        case "focus":
//            userDefaults.set(val, forKey: K.focusDurationKey)
//        case "shortBreak":
//            userDefaults.set(val, forKey: K.shortBreakDurationKey)
//        case "longBreak":
//            userDefaults.set(val, forKey: K.longBreakDurationKey)
//        default:
//            return
//        }
//    }
    
    func createConfettiLayer() {
        let layer = CAEmitterLayer()
        layer.emitterPosition = CGPoint(
            x: view.center.x,
            y: view.center.y
        )
        
        let colors: [UIColor] = [
            .systemGreen, .systemPink, .systemBlue, .systemOrange, .systemYellow, .systemRed, .systemIndigo
        ]
        
        let shapes: [String] = [
            "heart.fill", "triangle.fill", "rhombus.fill"
        ]
        
        let cells: [CAEmitterCell] = colors.compactMap { color in
            let cell = CAEmitterCell()
            cell.scale = 0.5
            cell.emissionRange = .pi * 2
            cell.lifetime = 5
            cell.birthRate = 10
            cell.velocity = 500
//            cell.birthRate
            if let shape = shapes.randomElement() {
                if let coloredImage = createColoredImage(imageName: shape, color: color) {
                    cell.contents = coloredImage.cgImage
                }
            }
            cell.color = color.cgColor
            return cell
        }
        
        layer.emitterCells = cells
        view.layer.addSublayer(layer)
        
        // timer for animation, duration is = withTimeInterval
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                layer.birthRate = 0 // stop generating new elements of confetti
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    layer.removeFromSuperlayer() // aaand delete the layer in 2 seconds (value in line above: (deadline: .now() + 2))
                }
            }
    }

    private func createColoredImage(imageName: String, color: UIColor) -> UIImage? {
        if let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate) {
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
            color.set()
            image.draw(in: CGRect(origin: .zero, size: image.size))
            let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return coloredImage
        }
        return nil
    }

}

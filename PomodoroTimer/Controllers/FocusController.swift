//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import UIKit

class FocusController: UIViewController {
    
    let focusView = FocusView(frame: CGRect.zero)

    var timer = Timer()
    var timesOfTimer = ["work": 25, "breaktime": 5]
    var timer25 = ["minutes": 24, "seconds": 59]
    var totalTime = 24*60
    var secondsPassed = 0
    var isCounting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(focusView)
        focusView.fillSuperview()
        focusView.pausePlayButton.addTarget(self, action: #selector(playPause), for: UIControl.Event.touchUpInside)
    }
    
    func updateTimeLable() {
        if timer25["minutes"]! == 0 && timer25["seconds"]! == 0 {
            self.timer.invalidate()
            print("FINISH!")
            return
        }
        if timer25["seconds"]! == 0 {
            timer25["minutes"]! -= 1
            timer25["seconds"]! = 59
        } else {
            timer25["seconds"]! -= 1
        }
        
        focusView.timeMinutesCounter.text = "\(timer25["minutes"]!)"
        focusView.timeSecondsCounter.text = "\(timer25["seconds"]!)"
    }
    
    @objc func playPause() {
        //каждый раз как мы нажимаем на кнопку мы меняем global state isCounting
        isCounting = !isCounting
        
        //нажали на кнопку когда таймер не работал? тогда запускаем отсчет
        if isCounting == true {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                    //начинаем с защиты на дурака
                if self.secondsPassed < self.totalTime {
                    //дальше, что собственно делаем? отсчитываем secondsPassed для того чтобы таймер не считал в -
                    self.secondsPassed += 1
                    //запускаем функцию апдейта цифорок на экране
                    self.updateTimeLable()
                    //print("it's \(self.secondsPassed)")
                }
            }
        // а если не запускали, то таймер на ноль, просто как предохранитель поставил.
        } else {
            timer.invalidate()
        }
    }
}


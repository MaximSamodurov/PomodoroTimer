//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import UIKit

class FocusController: UIViewController {
    
    let focusView = FocusView(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(focusView)
        focusView.fillSuperview()
    }

}


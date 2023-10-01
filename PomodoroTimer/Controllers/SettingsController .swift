//
//  Settings .swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 10.03.2023.
//  01.10.2023

import UIKit

class SettingsController: UIViewController {
    
    let settingsView = SettingsView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.robotoFlex(size: 50),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        view.addSubview(settingsView)
        settingsView.fillSuperview()
    }
    
}

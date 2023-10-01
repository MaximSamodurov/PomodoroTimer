//
//  Settings .swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 10.03.2023.
//

import UIKit

class SettingsController: UIViewController {
    
    let settingsView = SettingsView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(settingsView)
        settingsView.fillSuperview()
    }
    
}

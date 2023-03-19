//
//  BaseTabController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 10.03.2023.
//

import UIKit

class BaseTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: FocusController(), title: "Timer", imageName: "timer"),
            createNavController(viewController: SettingsController(), title: "Settings", imageName: "gear")
        ]
        
        tabBar.backgroundColor = UIColor(white: 0.9, alpha: 1)
        tabBar.layer.opacity = 0.5
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(systemName: imageName)
//        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}

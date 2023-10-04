//
//  AppDelegate.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import UIKit
import CoreData

@main

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let focusController = FocusController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window?.rootViewController = BaseTabController()
        self.window?.makeKeyAndVisible()
        return true
    }
//    func applicationWillResignActive(_ application: UIApplication) {
//        //  этот метод запускается когда происходит ЧП - когда что-то прерывает его работу, i.e. звонок например
//        print("applicationWillResignActive")
//    }
//
//    func applicationDidEnterBackground(_ application: UIApplication) {
//        //происходит когда приложение в фоне, например открыли другое приложение
//        print("applicationDidEnterBackground")
//    }
//
//    func applicationWillEnterForeground(_ application: UIApplication) {
//        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//        print("applicationWillEnterForeground")
//
//    }
////
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        print("applicationDidBecomeActive")
//
//    }
//
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("applicationWillTerminate")
        
    }
    
    // для обновления экрана нужно будет использовать функцию sceneDidBecomeActive https://developer.apple.com/documentation/uikit/uiscenedelegate/3197915-scenedidbecomeactive
}


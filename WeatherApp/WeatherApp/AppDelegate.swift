//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let rootVC = MainViewController()
        let navController = UINavigationController(rootViewController: rootVC) // Integrate navigation controller programmatically if you want
        window?.rootViewController = navController
        return true
    }
}


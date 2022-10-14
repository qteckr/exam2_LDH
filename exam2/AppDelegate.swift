//
//  AppDelegate.swift
//  exam2
//
//  Created by Qtec on 2022/10/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let vc = ViewController()
        let root = UINavigationController(rootViewController: vc)
        window?.rootViewController = root
        
        return true
    }
}

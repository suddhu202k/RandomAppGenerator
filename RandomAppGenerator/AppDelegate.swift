//
//  AppDelegate.swift
//  RandomAppGenerator
//
//  Created by Sudhanshu Kadari on 1/14/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
    }
}


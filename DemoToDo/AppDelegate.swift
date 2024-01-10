//
//  AppDelegate.swift
//  DemoToDo
//
//  Created by Azizbek Abdulkhakimov on 10/01/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = MainBuilder()
        
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: vc.build())
        window?.makeKeyAndVisible()
        
        return true
    }

}


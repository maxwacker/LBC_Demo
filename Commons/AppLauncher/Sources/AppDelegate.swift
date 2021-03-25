//
//  AppDelegate.swift
//  
//
//  Created by maxime wacker on 25/03/2021.
//

import UIKit
import GenRouting

struct Global {
    static var initialRouter: GenRouting!
}


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window =  UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = Global.initialRouter.navigator as? UINavigationController
        Global.initialRouter.start()
        window?.makeKeyAndVisible()

        return true
    }

}


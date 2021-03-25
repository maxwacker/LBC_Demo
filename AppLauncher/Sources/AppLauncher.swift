//
//  AppLauncher.swift
//  
//
//  Created by maxime wacker on 25/03/2021.
//

import UIKit
import GenRouting

public class AppLauncher {
    public static func launchApp(rootRouter: GenRouting) {
      Global.initialRouter = rootRouter
        UIApplicationMain(CommandLine.argc,
                          CommandLine.unsafeArgv,
                          NSStringFromClass(UIApplication.self),
                          NSStringFromClass(AppDelegate.self)
        )
    }
}

//
//  AppDelegate.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/01/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appConfigurator: AppConfigurator?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.appConfigurator = AppConfigurator(window: self.window)
        
        return true
    }
}

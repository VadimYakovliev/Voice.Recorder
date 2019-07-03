//
//  AppConfigurator.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/01/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit

// MARK: - Configure starting state

final class AppConfigurator {
    var appCoordinator: AppCoordinator?
    
    init(window: UIWindow?) {
        let navigationController = AppNavigationController()
        window?.rootViewController = navigationController
        
        self.appCoordinator = AppCoordinator(navigationController: navigationController)
        self.appCoordinator?.start()
        
        window?.makeKeyAndVisible()
    }
}

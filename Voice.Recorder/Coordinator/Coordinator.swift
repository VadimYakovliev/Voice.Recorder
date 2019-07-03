//
//  Coordinator.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/01/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit

// MARK: - Basis for Coordinator -
protocol Coordinator: AnyObject {
    var navigationController: AppNavigationController { get }
    
    func start()
    
    func set(rootView: UIViewController)
    func present(view: UIViewController)
    func dismissView(animated: Bool)
}

extension Coordinator {
    func set(rootView: UIViewController) {
        onMainQueue {
            self.navigationController.setViewControllers([rootView], animated: true)
        }
    }
    
    func present(view: UIViewController) {
        onMainQueue {
            self.navigationController.present(view, animated: true)
        }
    }
    
    func dismissView(animated: Bool) {
        onMainQueue {
            self.navigationController.dismiss(animated: animated)
        }
    }
}

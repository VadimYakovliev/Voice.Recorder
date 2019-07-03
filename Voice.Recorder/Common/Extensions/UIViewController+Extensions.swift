//
//  UIViewController+Extensions.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit

// MARK: - Navigation & TabBar
extension UIViewController {
    var appNavigationController: AppNavigationController? {
        return self.navigationController as? AppNavigationController
    }
    
    @discardableResult
    func addRightBarButton(imageName: ImageNames,
                           target: Any? = nil,
                           action: Selector? = nil) -> UIBarButtonItem {
        
        let button = UIBarButtonItem(image: UIImage(named: imageName.rawValue)?.withRenderingMode(.alwaysOriginal),
                                     style: .plain, target: target, action: action)
        self.navigationItem.rightBarButtonItem = button
        
        return button
    }
}

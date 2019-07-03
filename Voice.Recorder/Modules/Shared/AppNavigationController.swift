//
//  AppNavigationController.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/01/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit

private let fontSize: CGFloat = 17.0

class AppNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureAppearance()
    }
}

private extension AppNavigationController {
    func configureAppearance() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = .clear
        appearance.tintColor = .white
        appearance.isTranslucent = true
        appearance.barStyle = .black
        
        let font = UIFont.systemFont(ofSize: fontSize)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                          .font: font]
        self.configureBarButtonItem(font: font, color: .lightGray)
    }
    
    func configureBarButtonItem(font: UIFont, color: UIColor) {
        let barButtonAppearance = UIBarButtonItem.appearance()
        barButtonAppearance.setTitleTextAttributes([.foregroundColor: color, .font: font], for: .normal)
    }
}

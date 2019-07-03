//
//  UIView+Extensions.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    func add(_ subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
    
    func equalSizeToSuperview() {
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func equalCenterToSuperview() {
        self.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

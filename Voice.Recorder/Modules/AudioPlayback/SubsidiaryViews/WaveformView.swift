//
//  WaveformView.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/03/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit

private let widthRatio: CGFloat = 0.9
private let heightRatio: CGFloat = 0.3

class WaveformView: UIView {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        let screenSize = UIScreen.main.bounds

        self.snp.makeConstraints { make in
            make.width.equalTo(screenSize.width * widthRatio)
            make.height.equalTo(screenSize.height * heightRatio)
        }
        
        self.backgroundColor = .lightText
    }
    
    deinit { print("\(self) will die") }
}

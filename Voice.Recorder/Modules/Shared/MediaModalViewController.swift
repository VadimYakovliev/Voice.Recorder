//
//  BaseViewController.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit

private let stackSpacing: CGFloat = 80.0

class MediaModalViewController: UIViewController {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = stackSpacing
        
        return stackView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: ImageNames.close.rawValue)
        button.setImage(image, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.configureScene()
    }
    
    func configureScene() {
        self.view.add(self.closeButton, self.stackView)
        self.configure(stackView: self.stackView)
        self.configure(closeButton: self.closeButton)
    }
    
    func configure(closeButton: UIButton) {
        let offset = stackSpacing / 2
        
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(offset)
            make.top.equalToSuperview().offset(offset)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func configure(stackView: UIStackView ) {
        stackView.equalCenterToSuperview()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            self.stackView.axis = .vertical
        case .landscapeLeft, .landscapeRight:
            self.stackView.axis = .horizontal
        default:
            break
        }
    }
    
    deinit { print("\(self) will die") }
}

//
//  AudioPlaybackView.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class AudioPlaybackView: MediaModalViewController {
    
    var viewModel: AudioPlaybackViewModelContract!
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNames.bigPlay.rawValue), for: .normal)
        button.setImage(UIImage(named: ImageNames.pause.rawValue), for: .selected)
        return button
    }()

    private lazy var recordNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .lightText
        label.font = UIFont.systemFont(ofSize: 24.0)
        return label
    }()
    
    private let waveformView = WaveformView()
    
    private let disposeBag = DisposeBag()
    
    override func configureScene() {
        super.configureScene()
        
        self.configureBindings()
    }
    
    override func configure(closeButton: UIButton) {
        super.configure(closeButton: closeButton)
        
        closeButton.rx.tap
            .subscribe(self.viewModel.input.onTapClose)
            .disposed(by: self.disposeBag)
    }
    
    override func configure(stackView: UIStackView) {
        super.configure(stackView: stackView)
        
        stackView.addArrangedSubview(self.waveformView)
        stackView.addArrangedSubview(self.playPauseButton)
        
        self.view.add(self.recordNameLabel)
        
        self.recordNameLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(stackView.snp.top).offset(-10)
        }
    }
}

extension AudioPlaybackView: ConfigurableView {
    func configure(viewModel: AudioPlaybackViewModelContract) {
        self.viewModel = viewModel
    }
}

private extension AudioPlaybackView {
    func configureBindings() {
        self.playPauseButton.rx.tap
            .subscribe(self.viewModel.input.onTapPlayback)
            .disposed(by: self.disposeBag)

        self.viewModel.output.isPlaying
            .subscribe(self.playPauseButton.rx.isSelected)
            .disposed(by: self.disposeBag)
    }
}

//
//  AudioRecordingView.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AudioRecordingView: MediaModalViewController {

    var viewModel: AudioRecordingViewModelContract!
    
    private let disposeBag = DisposeBag()
    
    private let progressView = ProgressView()
    
    private lazy var recordButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: ImageNames.mic.rawValue)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
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
        
        stackView.addArrangedSubview(self.progressView)
        stackView.addArrangedSubview(self.recordButton)
    }
}

extension AudioRecordingView: ConfigurableView {
    func configure(viewModel: AudioRecordingViewModelContract) {
        self.viewModel = viewModel
    }
}

private extension AudioRecordingView {
    func configureBindings() {
        self.recordButton.rx.tap
            .subscribe(self.viewModel.input.onTapRecord)
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.isRecording
            .subscribe(self.recordButton.rx.toggleTintColor)
            .disposed(by: self.disposeBag)

        self.progressView.set(timeObservable: self.viewModel.output.recordingTime)
    }
}

private extension Reactive where Base: UIButton {
    var toggleTintColor: Binder<Bool> {
        return Binder(self.base) { button, active in
            button.tintColor = active ? .red : .white
        }
    }
}

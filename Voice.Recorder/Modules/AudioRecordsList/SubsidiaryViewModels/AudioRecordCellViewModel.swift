//
//  AudioRecordCellViewModel.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import RxSwift

protocol Clickable {
    func onClick(handler: (() -> Void)?)
}

final class AudioRecordCellViewModel: Clickable {
    let input: Input
    let output: Output
    
    // MARK: - Tap events
    private var onClickButtonHandler: (() -> Void)?
    
    // MARK: - Input
    private let onPlayRecordSubject: PublishSubject<Void>

    private let disposeBag = DisposeBag()
    
    init(audioRecord: AudioRecord) {
        self.onPlayRecordSubject = PublishSubject<Void>()
        
        self.output = Output(recordName: audioRecord.name,
                             recordDuration: audioRecord.duration.formatToDateString(withPattern: .shortTime) + " sec")
        self.input = Input(onTapButton: self.onPlayRecordSubject.asObserver())
        
        self.configureBinding()
    }
    
    func onClick(handler: (() -> Void)?) {
        self.onClickButtonHandler = handler
    }
}

private extension AudioRecordCellViewModel {
    func configureBinding() {
        self.onPlayRecordSubject
            .subscribe(onNext: { [weak self] in
                self?.onClickButtonHandler?()
            })
            .disposed(by: self.disposeBag)
    }
}

extension AudioRecordCellViewModel: ViewModelContract {
    struct Input {
        let onTapButton: AnyObserver<Void>
    }
    
    struct Output {
        let recordName: String
        let recordDuration: String
    }
}

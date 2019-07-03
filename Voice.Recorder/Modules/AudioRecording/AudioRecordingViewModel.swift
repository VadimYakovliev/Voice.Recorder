//
//  AudioRecordingViewModel.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import RxSwift

protocol AudioRecordingViewModelContract {
    var input: AudioRecordingViewModel.Input { get }
    var output: AudioRecordingViewModel.Output { get }
}

final class AudioRecordingViewModel {
    
    // MARK: - Interaction with services
    private let interactor: AudioRecordingInteractorContract
    
    // MARK: - Tap events
    private var onTapCloseHandler: (() -> Void)?
    
    // MARK: - Dispose
    private let disposeBag = DisposeBag()
    
    // MARK: - Input
    private(set) var input: Input
    private let onTapClosedSubject: PublishSubject<Void>
    private let onTapRecordSubject: PublishSubject<Void>
    
    // MARK: - Output
    private(set) var output: Output
    private let isRecordingSubject: BehaviorSubject<Bool>
    private let recordingTimeSubject: PublishSubject<TimeInterval>
    
    init(interactor: AudioRecordingInteractorContract, onTapCloseHandler: (() -> Void)?) {
        self.interactor = interactor
        self.onTapCloseHandler = onTapCloseHandler
        
        self.onTapClosedSubject = PublishSubject<Void>()
        self.onTapRecordSubject = PublishSubject<Void>()
        
        self.isRecordingSubject = BehaviorSubject<Bool>(value: false)
        self.recordingTimeSubject = PublishSubject<TimeInterval>()
        
        self.input = Input(onTapClose: self.onTapClosedSubject.asObserver(),
                           onTapRecord: self.onTapRecordSubject.asObserver())
        self.output = Output(isRecording: self.isRecordingSubject.asObservable(),
                             recordingTime: self.recordingTimeSubject.asObservable())
        
        self.configureBinding()
    }
    
    deinit { print("\(self) will die") }
}

private extension AudioRecordingViewModel {
    func configureBinding() {
        self.onTapClosedSubject
            .subscribe(onNext: { [weak self] in
                self?.onTapCloseHandler?()
            })
            .disposed(by: self.disposeBag)
        
        self.onTapRecordSubject
            .subscribe(onNext: { [weak self] in
                print(#function, "RECORD START!")
            })
            .disposed(by: self.disposeBag)
    }
}

extension AudioRecordingViewModel: ViewModelContract, AudioRecordingViewModelContract {
    struct Input {
        let onTapClose: AnyObserver<Void>
        let onTapRecord: AnyObserver<Void>
    }
    
    struct Output {
        let isRecording: Observable<Bool>
        let recordingTime: Observable<TimeInterval>
    }
}

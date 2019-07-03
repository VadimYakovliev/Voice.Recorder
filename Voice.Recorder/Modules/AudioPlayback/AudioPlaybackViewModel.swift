//
//  AudioPlaybackViewModel.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import RxSwift

protocol AudioPlaybackViewModelContract {
    var input: AudioPlaybackViewModel.Input { get }
    var output: AudioPlaybackViewModel.Output { get }
}

final class AudioPlaybackViewModel {
    
    // MARK: - Interaction with services
    private let interactor: AudioPlaybackInteractorContract
    
    // MARK: - Tap events
    private var onTapCloseHandler: (() -> Void)?
    
    // MARK: - Dispose
    private let disposeBag = DisposeBag()
    
    // MARK: - Input
    private(set) var input: Input
    private let onTapClosedSubject: PublishSubject<Void>
    private let onTapPlaybackSubject: PublishSubject<Void>
    
    // MARK: - Output
    private(set) var output: Output
    private let isPlayingSubject: BehaviorSubject<Bool>
    private let playingTimeSubject: PublishSubject<TimeInterval>
    
    init(interactor: AudioPlaybackInteractorContract, onTapCloseHandler: (() -> Void)?) {
        self.interactor = interactor
        self.onTapCloseHandler = onTapCloseHandler
        
        self.onTapClosedSubject = PublishSubject<Void>()
        self.onTapPlaybackSubject = PublishSubject<Void>()
        
        self.isPlayingSubject = BehaviorSubject<Bool>(value: false)
        self.playingTimeSubject = PublishSubject<TimeInterval>()
        
        self.input = Input(onTapClose: self.onTapClosedSubject.asObserver(),
                           onTapPlayback: self.onTapPlaybackSubject.asObserver())
        self.output = Output(isPlaying: self.isPlayingSubject.asObservable(),
                             playingTime: self.playingTimeSubject.asObservable())
        
        self.configureBinding()
    }
    
    deinit { print("\(self) will die") }
}

private extension AudioPlaybackViewModel {
    func configureBinding() {
        self.onTapClosedSubject
            .subscribe(onNext: { [weak self] in
                self?.onTapCloseHandler?()
            })
            .disposed(by: self.disposeBag)
        
        self.onTapPlaybackSubject
            .subscribe(onNext: { [weak self] in
                print(#function, "START PLAYER")
            })
            .disposed(by: self.disposeBag)
    }
}

extension AudioPlaybackViewModel: ViewModelContract, AudioPlaybackViewModelContract {
    struct Input {
        let onTapClose: AnyObserver<Void>
        let onTapPlayback: AnyObserver<Void>
    }
    
    struct Output {
        let isPlaying: Observable<Bool>
        let playingTime: Observable<TimeInterval>
    }
}

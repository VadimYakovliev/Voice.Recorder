//
//  AudioPlaybackInteractor.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import RxSwift

protocol AudioPlaybackInteractorContract {
    
}

final class AudioPlaybackInteractor {
    private let audioPlayer: AudioPlayerContract
    
    init(audioPlayer: AudioPlayerContract = AudioPlayer()) {
        self.audioPlayer = audioPlayer
    }
    
    deinit { print("\(self) will die") }
}

extension AudioPlaybackInteractor: AudioPlaybackInteractorContract {
    
}

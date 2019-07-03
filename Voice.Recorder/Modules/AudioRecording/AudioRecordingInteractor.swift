//
//  AudioRecordingInteractor.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import RxSwift

protocol AudioRecordingInteractorContract {
    
}

final class AudioRecordingInteractor {
    let audioRecorder: AudioRecorderContract
    
    init(audioRecorder: AudioRecorderContract = AudioRecorder()) {
        self.audioRecorder = audioRecorder
    }
    
    deinit { print("\(self) will die") }
}

extension AudioRecordingInteractor: AudioRecordingInteractorContract {
    
}

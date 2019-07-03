//
//  AudioRecorder.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import AVFoundation

protocol AudioRecorderContract {
    // Recorder interface
}

final class AudioRecorder: NSObject {
    // Recorder functionality
}

extension AudioRecorder: AudioRecorderContract {
    // Recorder interface implementation
}

extension AudioRecorder: AVAudioRecorderDelegate {

}

//
//  Constants.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import Foundation

enum Titles {
    enum Button {
        static let addRecord = "Add record"
    }
    
    static let defaultTimerText = "00 : 00"
}

enum ImageNames: String {
    case addRecord = "add-record"
    case mic = "mic"
    case smallPlay = "small-play"
    case bigPlay = "big-play"
    case pause = "pause"
    case close = "close"
}

enum DateFormatPatterns: String {
    case fullDate = "yyyy-MMMM-dd/HH:mm:ss"
    case shortTime = "mm : ss"
}

//
//  AudioRecord.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import Foundation

struct AudioRecord: Codable, Equatable {
    let name: String
    let filePath: String
    let duration: TimeInterval
}

//
//  TimeInterval+Extensions.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import Foundation

extension TimeInterval {
    func formatToDateString(withPattern pattern: DateFormatPatterns) -> String {
        let date = Date(timeIntervalSince1970: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = pattern.rawValue
        
        return dateFormatter.string(from: date)
    }
}

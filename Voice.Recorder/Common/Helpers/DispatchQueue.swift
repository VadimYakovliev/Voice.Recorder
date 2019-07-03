//
//  DispatchQueue.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import Foundation

func onMainQueue(_ block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
}

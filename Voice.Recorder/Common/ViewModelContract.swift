//
//  ViewModelContract.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/03/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import Foundation

// MARK: - ViewModel Contract

typealias ViewModelContract = ViewModelInput & ViewModelOutput

protocol ViewModelInput {
    associatedtype Input
}

protocol ViewModelOutput {
    associatedtype Output
}

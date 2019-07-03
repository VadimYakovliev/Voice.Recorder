//
//  Configurable+Reusable.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import Foundation

// MARK: - Configurable View

protocol ConfigurableView: AnyObject {
    associatedtype ViewModel
    
    var viewModel: ViewModel! { get set }
    
    func configure(viewModel: ViewModel)
}

// MARK: Reusable View

protocol ReusableView {
    static var identifier: String { get }
}

extension ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

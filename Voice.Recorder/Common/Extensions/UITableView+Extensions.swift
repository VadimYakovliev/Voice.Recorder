//
//  UITableView+Extensions.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UITableView {
    func registerCellClass<T: ReusableView>(_: T.Type) where T: UITableViewCell {
        self.register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func configure<CellType: ConfigurableView & ReusableView, CellViewModel: Clickable>
        (cellType: CellType.Type,
         items: BehaviorRelay<[CellViewModel]>,
         onClickHandler: (() -> Void)? = nil)  -> Disposable
        where CellType.ViewModel == CellViewModel {
            
            return items
                .bind(to: self.rx.items(cellIdentifier: CellType.identifier)) { _, element, cell in
                    (cell as? CellType)?.configure(viewModel: element)
                    element.onClick(handler: onClickHandler)
            }
    }
}

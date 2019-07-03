//
//  AudioRecordsListView.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let cellEstimatedHeight: CGFloat = 40.0
private let horizontalInset: CGFloat = 16.0

class AudioRecordsListView: UIViewController {

    var viewModel: AudioRecordsListViewModelContract!

    private let disposeBag = DisposeBag()
    
    private let recordsListTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.configureScene()
        self.configureBinding()
    }
}

extension AudioRecordsListView: ConfigurableView {
    func configure(viewModel: AudioRecordsListViewModelContract) {
        self.viewModel = viewModel
    }
}

private extension AudioRecordsListView {
    func configureScene() {
        self.view.backgroundColor = .black
        
        self.configureTableView()
        self.configureNavBarItemWithBinding()
    }
    
    func configureTableView() {
        self.recordsListTableView.backgroundColor = .clear
        self.recordsListTableView.tableFooterView = UIView()
        
        self.recordsListTableView.registerCellClass(AudioRecordCell.self)
        
        self.recordsListTableView.separatorInset = UIEdgeInsets(top: .zero,
                                                                left: horizontalInset,
                                                                bottom: .zero,
                                                                right: horizontalInset)
        self.recordsListTableView.separatorColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.recordsListTableView.showsVerticalScrollIndicator = false
        self.recordsListTableView.alwaysBounceVertical = false
        self.recordsListTableView.delaysContentTouches = false
        
        self.recordsListTableView.estimatedRowHeight = cellEstimatedHeight
        self.recordsListTableView.rowHeight = UITableView.automaticDimension
        
        self.view.add(self.recordsListTableView)
        self.recordsListTableView.equalSizeToSuperview()
    }
    
    func configureNavBarItemWithBinding() {
        let barButtonItem = self.addRightBarButton(imageName: .addRecord)
        barButtonItem.rx.tap
            .subscribe(self.viewModel.input.onTapNewRecord)
            .disposed(by: self.disposeBag)
    }
    
    func configureBinding() {
        self.recordsListTableView
            .configure(cellType: AudioRecordCell.self,
                       items: self.viewModel.output.audioRecords,
                       onClickHandler: self.viewModel.input.onTapPlayRecordHandler)
            .disposed(by: self.disposeBag)
        
        self.recordsListTableView.rx.itemDeleted
            .subscribe(self.viewModel.input.onDeleteRecord)
            .disposed(by: self.disposeBag)
    }
}

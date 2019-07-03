//
//  AudioRecordsListViewModel.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import RxSwift
import RxCocoa

protocol AudioRecordsListViewModelContract {
    var input: AudioRecordsListViewModel.Input { get }
    var output: AudioRecordsListViewModel.Output { get }
}

final class AudioRecordsListViewModel {
    typealias TapListenersHolder = (onTapNewRecordHandler: (() -> Void)?, onTapPlayRecordHandler: (() -> Void)?)
    
    // MARK: - Interaction with services
    private let interactor: AudioRecordsListInteractorContract
    
    // MARK: - Tap events
    private var onTapNewRecordHandler: (() -> Void)?
    private var onTapPlayRecordHandler: (() -> Void)?

    // MARK: - Dispose
    private let disposeBag = DisposeBag()
    
    // MARK: - Input
    private(set) var input: Input
    private let onNewRecordSubject: PublishSubject<Void>
    private let onDeleteRecordSubject: PublishSubject<IndexPath>
    
    // MARK: - Output
    private(set) var output: Output
    private let audioRecordsSubject: BehaviorRelay<[AudioRecordCellViewModel]>
    
    init(interactor: AudioRecordsListInteractorContract, tapListenersHolder: TapListenersHolder) {
        self.interactor = interactor
        
        self.onTapNewRecordHandler = tapListenersHolder.onTapNewRecordHandler
        self.onTapPlayRecordHandler = tapListenersHolder.onTapPlayRecordHandler
        
        self.onNewRecordSubject = PublishSubject<Void>()
        self.onDeleteRecordSubject = PublishSubject<IndexPath>()
        self.audioRecordsSubject = BehaviorRelay<[AudioRecordCellViewModel]>(value: [])
        
        self.output = Output(audioRecords: self.audioRecordsSubject)
        self.input = Input(onDeleteRecord: self.onDeleteRecordSubject.asObserver(),
                           onTapNewRecord: self.onNewRecordSubject.asObserver(),
                           onTapPlayRecordHandler: self.onTapPlayRecordHandler)
        
        self.configureBinding()
    }
    
    deinit { print("\(self) will die") }
}

private extension AudioRecordsListViewModel {
    func configureBinding() {
        self.interactor.dataRepositorySubject
            .subscribe(onNext: { [weak self] records in
                let cellViewModels = records.map(AudioRecordCellViewModel.init)
                self?.audioRecordsSubject.accept(cellViewModels)
            })
            .disposed(by: self.disposeBag)
        
        self.onNewRecordSubject
            .subscribe(onNext: { [weak self] in
                self?.onTapNewRecordHandler?()
            })
            .disposed(by: self.disposeBag)
        
        self.onDeleteRecordSubject
            .subscribe(onNext: { [weak self] indexPath in
                self?.interactor.onDelete(at: indexPath)
            })
            .disposed(by: self.disposeBag)
    }
}

extension AudioRecordsListViewModel: ViewModelContract, AudioRecordsListViewModelContract {
    struct Input {
        let onDeleteRecord: AnyObserver<IndexPath>
        let onTapNewRecord: AnyObserver<Void>
        let onTapPlayRecordHandler: (() -> Void)?
    }
    
    struct Output {
        let audioRecords: BehaviorRelay<[AudioRecordCellViewModel]>
    }
}

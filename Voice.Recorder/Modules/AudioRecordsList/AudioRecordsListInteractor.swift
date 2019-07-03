//
//  AudioRecordsListInteractor.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import RxSwift
import RxCocoa

protocol AudioRecordsListInteractorContract {
    // Temporary data provider
    var dataRepositorySubject: BehaviorRelay<[AudioRecord]> { get }
    
    func onDelete(at indexPath: IndexPath)
}

final class AudioRecordsListInteractor {
    
    // Temporary data provider
    let dataRepositorySubject = BehaviorRelay<[AudioRecord]>(value: [])
    
    init() {
        let items = [AudioRecord(name: Date().timeIntervalSince1970.formatToDateString(withPattern: .fullDate),
                                 filePath: "/asas/", duration: 30.0),
                     AudioRecord(name: Date().timeIntervalSince1970.formatToDateString(withPattern: .fullDate),
                                 filePath: "/asas/", duration: 14.0),
                     AudioRecord(name: Date().timeIntervalSince1970.formatToDateString(withPattern: .fullDate),
                                 filePath: "/asas/", duration: 24.0)]
        self.dataRepositorySubject.accept(items)
    }
    
    deinit { print("\(self) will die") }
}

extension AudioRecordsListInteractor: AudioRecordsListInteractorContract {
    func onDelete(at indexPath: IndexPath) {
        print(#function, indexPath)
    }
}

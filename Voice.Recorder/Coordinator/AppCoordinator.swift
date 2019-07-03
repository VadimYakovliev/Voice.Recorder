//
//  AppCoordinator.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/01/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import Foundation

final class AppCoordinator {
    let navigationController: AppNavigationController
    
    init(navigationController: AppNavigationController) {
        self.navigationController = navigationController
    }
}

extension AppCoordinator: Coordinator {
    func start() {
        self.showAudioRecordsListScene()
    }
}

private extension AppCoordinator {
    func showAudioRecordsListScene() {
        let onTapNewRecordListener: (() -> Void)? = { [weak self] in
            self?.showAudioRecordingScene()
        }
        
        let onTapPlayRecordListener: (() -> Void)? = { [weak self] in
            self?.showAudioPlaybackScene()
        }
        
        let listenersHolder = (onTapNewRecordListener, onTapPlayRecordListener)
        
        let interactor = AudioRecordsListInteractor()
        let viewModel = AudioRecordsListViewModel(interactor: interactor,
                                                  tapListenersHolder: listenersHolder)
        
        let view = AudioRecordsListView()
        view.configure(viewModel: viewModel)
        
        self.set(rootView: view)
    }
    
    func showAudioRecordingScene() {
        let interactor = AudioRecordingInteractor()
        let viewModel = AudioRecordingViewModel(interactor: interactor,
                                                onTapCloseHandler: self.dismissScene())
        
        let view = AudioRecordingView()
        view.configure(viewModel: viewModel)
        
        view.modalPresentationStyle = .overFullScreen
        self.present(view: view)
    }
    
    func showAudioPlaybackScene() {
        let interactor = AudioPlaybackInteractor()
        let viewModel = AudioPlaybackViewModel(interactor: interactor,
                                               onTapCloseHandler: self.dismissScene())
        
        let view = AudioPlaybackView()
        view.configure(viewModel: viewModel)
        
        view.modalPresentationStyle = .overFullScreen
        self.present(view: view)
    }
    
    func dismissScene() -> (() -> Void)? {
        let onTapCloseHandler: (() -> Void)? = { [weak self] in
            self?.dismissView(animated: true)
        }
        
        return onTapCloseHandler
    }
}

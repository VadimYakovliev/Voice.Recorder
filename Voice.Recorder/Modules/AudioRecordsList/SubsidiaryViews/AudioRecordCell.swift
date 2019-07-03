//
//  AudioRecordCell.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit
import RxSwift

private let titleFontSize: CGFloat = 14.0
private let descriptFontSize: CGFloat = 12.0

private let buttonSizeValue: CGFloat = 30.0

private let containerVerticalInset: CGFloat = 10
private let containerHorizontalInset: CGFloat = 16.0
private let contentContainerInset = UIEdgeInsets(top: containerVerticalInset,
                                                 left: containerHorizontalInset,
                                                 bottom: containerVerticalInset,
                                                 right: containerHorizontalInset)

final class AudioRecordCell: UITableViewCell {
    private let containerView = UIView()
    private let playButton = UIButton()
    private var nameLabel = UILabel()
    private var durationLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    var viewModel: AudioRecordCellViewModel!
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        self.configureCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.nameLabel.text = self.viewModel.output.recordName
        self.durationLabel.text = self.viewModel.output.recordDuration
    }
}

extension AudioRecordCell: ConfigurableView, ReusableView {
    func configure(viewModel: AudioRecordCellViewModel) {
        self.viewModel = viewModel
    }
}

private extension AudioRecordCell {
    func configureCell() {
        guard
            self.contentView.subviews.isEmpty
            else { return }
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.configureComponents()
        self.configureBinding()
    }
    
    func configureComponents() {
        self.configureContainerView()
        self.configureButton()
        self.configureLabelsWithStack()
    }
    
    func configureContainerView() {
        self.containerView.backgroundColor = .clear
        self.contentView.add(self.self.containerView)
        
        self.containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(contentContainerInset)
        }
    }
    
    func configureButton() {
        self.playButton.setImage(UIImage(named: ImageNames.smallPlay.rawValue),
                                 for: .normal)
        self.containerView.add(self.playButton)
        
        self.playButton.snp.makeConstraints { make in
            make.width.equalTo(buttonSizeValue)
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(containerVerticalInset)
        }
    }
    
    func configureLabelsWithStack() {
        let labelsStack = LabelsStackProducer().getStack(titleFontSize: titleFontSize,
                                                         descriptFontSize: descriptFontSize)
        self.nameLabel = labelsStack.titleLabel
        self.durationLabel = labelsStack.descriptionLabel
        
        let stackView = labelsStack.stack
        
        self.containerView.add(stackView)
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.playButton.snp.right).offset(containerHorizontalInset)
            make.right.equalToSuperview()
        }
    }
    
    func configureBinding() {
        self.playButton.rx.tap
            .subscribe(self.viewModel.input.onTapButton)
            .disposed(by: self.disposeBag)
    }
}

//
//  ProgressView.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

private let inversionValue: CGFloat = 1.0
private let totalTime: TimeInterval = 30.0
private let sizeRatio: CGFloat = 0.7
private let progressLineWidth: CGFloat = 4.0

class ProgressView: UIView {
    private let disposeBag = DisposeBag()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 57.0)
        label.text = Titles.defaultTimerText
        return label
    }()
    
    private var progressLayer:  CAShapeLayer?
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        let size = UIScreen.main.bounds.width * sizeRatio
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(size)
        }
        
        self.configureComponents()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addLayers()
    }
    
    func set(timeObservable: Observable<TimeInterval>) {
        timeObservable
            .map { $0.formatToDateString(withPattern: .shortTime) }
            .asDriver(onErrorJustReturn: Titles.defaultTimerText)
            .drive(self.timeLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        timeObservable
            .asDriver(onErrorJustReturn: totalTime)
            .drive(onNext: { [weak self] currentTime in
                self?.progressLayer?.strokeStart = inversionValue - CGFloat(currentTime / totalTime)
            })
            .disposed(by: self.disposeBag)
    }
    
    deinit { print("\(self) will die") }
}

private extension ProgressView {
    func configureComponents() {
        self.add(self.timeLabel)
        self.timeLabel.equalCenterToSuperview()
    }
    
    func addLayers() {
        guard
            self.progressLayer.isNil
            else { return }
        
        let backgroundLayer = self.drawRoundShapeLayer(color: .gray, lineWidth: progressLineWidth)
        self.progressLayer = self.drawRoundShapeLayer(color: .brown, lineWidth: progressLineWidth)
        
        self.layer.addSublayer(backgroundLayer)
        self.progressLayer.map { self.layer.addSublayer($0) }
    }
    
    func drawRoundShapeLayer(color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = self.createCirclePath(rect: self.bounds)
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        return shapeLayer
    }
    
    func createCirclePath(rect: CGRect) -> CGPath {
        let bgPath = UIBezierPath(roundedRect: rect,
                                  cornerRadius: rect.width / 2.0)
        bgPath.close()
        return bgPath.cgPath
    }
}

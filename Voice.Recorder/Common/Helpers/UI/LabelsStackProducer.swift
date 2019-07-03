//
//  LabelsStackProducer.swift
//  Voice.Recorder
//
//  Created by Vadym Yakovliev on 7/02/19.
//  Copyright © 2019 Vadim Yakovliev. All rights reserved.
//

import UIKit

struct LabelsStackProducer {
    typealias LabelsStack = (stack: UIStackView, titleLabel: UILabel, descriptionLabel: UILabel)
    
    func getStack(titleFontSize: CGFloat, descriptFontSize: CGFloat) -> LabelsStack {
        
        let titleLabel = self.configureLabel(withTextColor: .lightGray,
                                             size: titleFontSize)
        let descriptionLabel = self.configureLabel(withTextColor: .lightText,
                                                   size: descriptFontSize)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5.0
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        return (stackView, titleLabel, descriptionLabel)
    }
    
    private func configureLabel(withTextColor color: UIColor, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: size)
        
        return label
    }
}

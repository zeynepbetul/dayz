//
//  DZTitleLabel.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 4.12.2025.
//

import UIKit

class DZTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    private func configure() {
        self.textColor            = .label // black on light screen, white on dark screen.
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.9
        lineBreakMode             = .byTruncatingTail // how to break after it shrinks when it is too long. ... for this case
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

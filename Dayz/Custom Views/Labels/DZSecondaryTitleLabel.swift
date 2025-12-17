//
//  DZSecondaryTitleLabel.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 17.12.2025.
//

import UIKit

class DZSecondaryTitleLabel: UILabel {

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
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    private func configure() {
        self.textColor            = .secondaryLabel // light gray
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.90
        lineBreakMode             = .byTruncatingTail // ... at the end when it is too long.
        translatesAutoresizingMaskIntoConstraints = false
    }
}

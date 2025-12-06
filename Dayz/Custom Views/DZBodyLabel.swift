//
//  DZBodyLabel.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 4.12.2025.
//

import UIKit

class DZBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    private func configure() {
        self.textColor            = .secondaryLabel // light gray
        font                      = UIFont.preferredFont(forTextStyle: .body) // Dynamic Type for font
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.75
        lineBreakMode             = .byWordWrapping // how to break after it shrinks when it is too long.
        translatesAutoresizingMaskIntoConstraints = false
    }
}

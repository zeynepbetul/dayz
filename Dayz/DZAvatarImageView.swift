//
//  DZAvatarImageView.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 3.12.2025.
//

import UIKit

class DZAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(systemName: "person.circle")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds      = true // image would still look like a sharp square unless we did the clipsToBounds true
        image              = placeHolderImage
    }

}

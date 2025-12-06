//
//  SearchCell.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 3.12.2025.
//

import UIKit

class SearchCell: UITableViewCell {
    
    var avatarImageView = DZAvatarImageView(frame: .zero)
    var userNameLabel   = DZTitleLabel(textAlignment: .left, fontSize: 12)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(avatarImageView)
        addSubview(userNameLabel)

        setImageConstraints()
        setUserNameLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(dzuser: DZUser) {
        avatarImageView = dzuser.avatarImage
        userNameLabel.text = dzuser.userName
    }
    
    func setImageConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),  // y-axis is equal to the center y-axis of table view cell
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setUserNameLabelConstraints() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

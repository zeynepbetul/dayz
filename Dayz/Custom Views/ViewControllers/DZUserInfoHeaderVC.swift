//
//  DZUserInfoHeaderVCViewController.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 17.12.2025.
//

import UIKit

class DZUserInfoHeaderVC: UIViewController {
    
    let avatarImageView       = DZAvatarImageView(frame: .zero)
    let usernameLabel         = DZTitleLabel(textAlignment: .center, fontSize: 25)
    let nameLabel             = DZTitleLabel(textAlignment: .center, fontSize: 16)
    let followersLabel        = DZTitleLabel(textAlignment: .center, fontSize: 16)
    let followingLabel        = DZTitleLabel(textAlignment: .center, fontSize: 16)
    let followButton          = DZButton(backgroundColor: .black, title: "Follow")
    let bioLabel              = DZBodyLabel(textAlignment: .left)

    var user: PublicUser!
    
    init(user: PublicUser!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    func configureUIElements() {
        avatarImageView.setImage(from: user.avatarUrl)
        usernameLabel.text       = user.username
        nameLabel.text           = user.name ?? ""
        followersLabel.text      = "Followers: \(user.followers)"
        followingLabel.text      = "Follow: \(user.following)"
        bioLabel.text            = user.bio ?? ""
        bioLabel.numberOfLines   = 3
    }
    
    func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(followersLabel)
        view.addSubview(followingLabel)
        view.addSubview(followButton)
        view.addSubview(bioLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            followersLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            followersLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            
            followingLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            followingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            followButton.centerYAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            followButton.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            followButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            followButton.heightAnchor.constraint(equalToConstant: 44),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)

        ])
    }
}

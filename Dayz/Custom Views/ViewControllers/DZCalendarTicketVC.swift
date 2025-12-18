//
//  DZCalendarTicketVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 18.12.2025.
//

import UIKit

class DZCalendarTicketVC: UIViewController {
    
    let titleLabel = DZTitleLabel(textAlignment: .center, fontSize: 13)
    let bodyLabel  = DZBodyLabel(textAlignment: .center)
    let image      = DZAvatarImageView(frame: .zero)
    let button     = DZButton(backgroundColor: .black, title: "Open")
    
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
        configureBackgroundView()
        layoutUI()
        configureUIElements()
    }
    
    private func configureUIElements() {
        titleLabel.text = "John's calendar"
        bodyLabel.text = "This calendar is John's everyday"
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    private func layoutUI() {
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        view.addSubview(image)
        view.addSubview(button)
        
        image.image = UIImage(systemName: SFSymbols.emptyProfile)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            image.widthAnchor.constraint(equalToConstant: 90),
            image.heightAnchor.constraint(equalToConstant: 110),
            
            titleLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            bodyLabel.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -padding),
            bodyLabel.heightAnchor.constraint(equalToConstant: 25),
            
            button.bottomAnchor.constraint(equalTo: image.bottomAnchor),
            button.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 55),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

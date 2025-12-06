//
//  DZAlertVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 4.12.2025.
//

import UIKit

class DZAlertVC: UIViewController {
    
    let containerView        = UIView()  // TODO: reusable containerView
    let titleLabel           = DZTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel         = DZBodyLabel(textAlignment: .center)
    let actionLogOutButton   = DZButton(backgroundColor: .systemRed, title: "Log out")
    let actionCancelButton   = DZButton(backgroundColor: .systemGray6, title: "Cancel")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor             = .systemBackground
        containerView.layer.cornerRadius          = 16
        containerView.layer.borderWidth           = 2
        containerView.layer.borderColor           = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: padding)
        ])
        
        containerView.addSubview(messageLabel)
        messageLabel.text = message
    }
}

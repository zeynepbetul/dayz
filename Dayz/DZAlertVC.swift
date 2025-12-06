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
    let actionSignOutButton  = DZButton(backgroundColor: .label, title: "Sign Out")
    let actionCancelButton   = DZButton(backgroundColor: .red, title: "Cancel")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    var buttonTitleSec: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String, buttonTitleSec: String?) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.buttonTitleSec = buttonTitleSec
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        if buttonTitleSec != nil {
            configureActionButtonSec()
        }
        configureMessageLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor             = .systemBackground
        containerView.layer.cornerRadius          = 16
        containerView.layer.borderWidth           = 1
        containerView.layer.borderColor           = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 250)
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
    }
    
    func configureActionButtonSec() {
        containerView.addSubview(actionCancelButton)
        actionCancelButton.setTitle(buttonTitleSec ?? "Cancel", for: .normal)
        actionCancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionCancelButton.bottomAnchor.constraint(equalTo: actionSignOutButton.topAnchor, constant: -10),
            actionCancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionCancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionCancelButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureActionButton() {
        containerView.addSubview(actionSignOutButton)
        actionSignOutButton.setTitle(buttonTitle ?? "Sign Out", for: .normal)
        actionSignOutButton.addTarget(self, action: #selector(signout), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionSignOutButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionSignOutButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionSignOutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionSignOutButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        let bottomAnchorTarget: NSLayoutYAxisAnchor
        if buttonTitleSec != nil {
            bottomAnchorTarget = actionCancelButton.topAnchor
        } else {
            bottomAnchorTarget = actionSignOutButton.topAnchor
        }
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchorTarget, constant: -12)
        ])
    }
    
    @objc func signout() {
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

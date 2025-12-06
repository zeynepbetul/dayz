//
//  ProfileVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 2.12.2025.
//

import UIKit

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        configureLogOutButton()
    }
    
    func configureLogOutButton() {
        let button = UIButton()
        view.addSubview(button)
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func logout() {
        presentDZAlertOnMainThread(title: "Sign out", message: "Do you want to sign out of your account?",
                                   buttonTitle: "Sign Out", buttonTitleSec: "Cancel")
    }
}

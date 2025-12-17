//
//  UserInfoVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 16.12.2025.
//

import UIKit

class UserInfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissCV))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissCV() {
        dismiss(animated: true)
    }
}

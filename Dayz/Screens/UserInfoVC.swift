//
//  UserInfoVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 16.12.2025.
//

import UIKit

class UserInfoVC: UIViewController {

    var userId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissCV))
        navigationItem.rightBarButtonItem = doneButton
        
        //fetchUser()
    }
    
    @objc func dismissCV() {
        dismiss(animated: true)
    }
    
    func fetchUser() {
        NetworkManager.shared.fetchPublicUser(userId: userId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentDZAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok", buttonTitleSec: nil)
            }
        }
    }
}

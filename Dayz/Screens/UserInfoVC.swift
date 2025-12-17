//
//  UserInfoVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 16.12.2025.
//

import UIKit

class UserInfoVC: UIViewController {

    let headerView = UIView()
    let calendarView = UIView()
    let usernameLabel = DZTitleLabel(textAlignment: .center, fontSize: 13)
    
    var userId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissCV))
        navigationItem.rightBarButtonItem = doneButton
        
        layoutUI()
        fetchUser()
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        view.addSubview(calendarView)
        view.addSubview(usernameLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            calendarView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            calendarView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissCV() {
        dismiss(animated: true)
    }
    
    func fetchUser() {
        NetworkManager.shared.fetchPublicUser(userId: userId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.usernameLabel.text = user.username
                    self.navigationItem.titleView = self.usernameLabel
                    self.add(childVC: DZUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentDZAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok", buttonTitleSec: nil)
            }
        }
    }
}

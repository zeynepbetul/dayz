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
    
    var itemViews: [UIView] = []
    
    let usernameLabel = DZTitleLabel(textAlignment: .center, fontSize: 13)
    
    var userId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        fetchUser()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissCV))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        
        itemViews = [headerView, calendarView]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }

        view.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            calendarView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
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
                    self.add(childVC: DZCalendarTicketVC(user: user), to: self.calendarView)
                }
            case .failure(let error):
                self.presentDZAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok", buttonTitleSec: nil)
            }
        }
    }
}

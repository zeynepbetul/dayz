//
//  SearchVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 3.12.2025.
//

import UIKit

class SearchVC: UIViewController {
    
    let usernameTextField = DZTextField(placeholder: "Search")
    var tableView = UITableView()
    var users: [DZUser] = [] // The table view is just a list of things what are we showing.
    
    struct Cells {
        static let searchCell = "SearchCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        users = fetchData()
        
        configureTextField()
        configureTableView()
        createDismissKeyboardTapGesture()
    }
    
    func createDismissKeyboardTapGesture() {
            let recognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
            view.addGestureRecognizer(recognizer)
        }
        
    @objc func searchTapped() {
        let searchVC = SearchVC()
        navigationController?.pushViewController(searchVC, animated: true) // Push the SearchVC on top of the navigation stack.
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        setTableViewDelegates()
        tableView.rowHeight = 50
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: Cells.searchCell)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // this func gets called every time a new cell comes on the screen. You see this DQReuseableCell.
        // Phone only generates enough cells that are on the screen. Just before a cell about to come on the screen, it gets configured.
        // It is not like the long list already exists.
        // This function gets called a lots when scrolling. Make sure not a lot heavy performance stuff going on here.
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.searchCell) as! SearchCell
        let user = users[indexPath.row]
        cell.set(dzuser: user)
        return cell
    }
}

extension SearchVC {
    func fetchData() -> [DZUser] {
        let user1 = DZUser(avatarImage: DZAvatarImageView(frame: .zero), userName: "john_freeman")
        let user2 = DZUser(avatarImage: DZAvatarImageView(frame: .zero), userName: "adamdalva")
        let user3 = DZUser(avatarImage: DZAvatarImageView(frame: .zero), userName: "abraham")
        let user4 = DZUser(avatarImage: DZAvatarImageView(frame: .zero), userName: "tess_gunty")
        let user5 = DZUser(avatarImage: DZAvatarImageView(frame: .zero), userName: "ann_napolitano")
        let user6 = DZUser(avatarImage: DZAvatarImageView(frame: .zero), userName: "hernan_diaz")
        let user7 = DZUser(avatarImage: DZAvatarImageView(frame: .zero), userName: "luck_good")
        let user8 = DZUser(avatarImage: DZAvatarImageView(frame: .zero), userName: "salvadore")
        let user9 = DZUser(avatarImage: DZAvatarImageView(frame: .zero), userName: "greek_monk")
        let user10 = DZUser(avatarImage: DZAvatarImageView(frame: .zero), userName: "sendoras")

        return [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10]
    }
}

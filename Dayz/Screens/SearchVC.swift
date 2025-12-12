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
    var users: [PublicUser] = [] // The table view is just a list of things what are we showing.
    var filteredUsers: [PublicUser] = []
    
    struct Cells {
        static let searchCell = "SearchCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        configureTextField()
        configureTableView()
        createDismissKeyboardTapGesture()
        
        fetchUsersFromFirebase()
    }
    
    func fetchUsersFromFirebase() {
        NetworkManager.shared.fetchAllUsers { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedUsers):
                    self.users = fetchedUsers
                    self.filteredUsers = fetchedUsers   // show all at the first openning
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    self.presentDZAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "ok", buttonTitleSec: nil)
                }
            }
        }
    }
    
    func createDismissKeyboardTapGesture() {
            let recognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
            view.addGestureRecognizer(recognizer)
        }
        
    @objc func searchTapped() {
        let searchVC = SearchVC()
        navigationController?.pushViewController(searchVC, animated: true) // Push the SearchVC on top of the navigation stack.
    }
    
    @objc func textFieldChanged() {
        guard let text = usernameTextField.text?.lowercased(), !text.isEmpty else {
            filteredUsers = users
            tableView.reloadData()
            return
        }
        
        filteredUsers = users.filter { $0.username.contains(text) }
        tableView.reloadData()
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
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
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // this func gets called every time a new cell comes on the screen. You see this DQReuseableCell.
        // Phone only generates enough cells that are on the screen. Just before a cell about to come on the screen, it gets configured.
        // It is not like the long list already exists.
        // This function gets called a lots when scrolling. Make sure not a lot heavy performance stuff going on here.
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.searchCell) as! SearchCell
        cell.configure(with: filteredUsers[indexPath.row])
        return cell
    }
}

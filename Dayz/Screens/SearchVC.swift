//
//  SearchVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 3.12.2025.
//

import UIKit

class SearchVC: UIViewController, UITableViewDelegate {
    
    enum Section {
        case main
    }
    
    let usernameTextField = DZTextField(placeholder: "Search")
    var tableView = UITableView()
    
    private var users: [PublicUser] = [] // The table view is just a list of things what are we showing.
    private var dataSource: UITableViewDiffableDataSource<Section, PublicUser>!
    
    struct Cells {
        static let searchCell = "SearchCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        configureTextField()
        configureTableView()
        configureDataSource()
        createDismissKeyboardTapGesture()
        
        fetchUsersFromFirebase()
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, PublicUser>(tableView: tableView, cellProvider: { tableView, indexPath, publicUser in
            let cell = tableView.dequeueReusableCell(withIdentifier: Cells.searchCell, for: indexPath) as! SearchCell
            cell.configure(with: publicUser)
            return cell
        })
    }
    
    func updateData(users: [PublicUser], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PublicUser>()
        snapshot.appendSections([.main])
        snapshot.appendItems(users)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
    
    func fetchUsersFromFirebase() {
        /* we used self. self in this case is our SearchVC.
         our network manager has a strong reference to SearchVC. This could cause a memory leak.
         to make this self weak, add [weak self]. Now self can be nil, so add ?
         If we dont want to use self?. first need to unwrap self.
         */
        NetworkManager.shared.fetchAllUsers { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedUsers):
                    self.users = fetchedUsers
                    self.updateData(users: fetchedUsers, animate: false)
                    
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
            updateData(users: users)
            return
        }
        
        let filtered = users.filter { $0.username.contains(text) }
        updateData(users: filtered)
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

        tableView.delegate = self
        tableView.rowHeight = 50
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: Cells.searchCell)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

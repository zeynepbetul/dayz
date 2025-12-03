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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureTextField()
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
        setTableViewDelegates()
        // TODO: set row height
        // TODO: register cells
        // TODO: set constraints
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

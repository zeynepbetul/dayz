//
//  HomeVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 2.12.2025.
//

import UIKit

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(notificationsTapped))
    }
    
    @objc func searchTapped() {
        let searchVC = SearchVC()
        navigationController?.pushViewController(searchVC, animated: true) // Push the SearchVC on top of the navigation stack.
    }
    
    @objc func notificationsTapped() {
        
    }
}

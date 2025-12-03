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
        view.backgroundColor = .systemPink
        
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(notificationsTapped))
    }
    
    @objc func searchTapped() {
        
    }
    
    @objc func notificationsTapped() {
        
    }
}

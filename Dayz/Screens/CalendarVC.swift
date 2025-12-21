//
//  CalendarVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 2.12.2025.
//

import UIKit

class CalendarVC: UIViewController {
    
    let tableView = UITableView()
    
    let containerFirst         = UIView()
    let containerSecond        = UIView()
    let containerThird         = UIView()
    let containerFourth        = UIView()
    var itemViews: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        fetchDay()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        
        itemViews = [containerFirst, containerSecond, containerThird, containerFourth]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            containerFirst.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerFirst.heightAnchor.constraint(equalToConstant: 200),
            
            containerSecond.topAnchor.constraint(equalTo: containerFirst.bottomAnchor, constant: padding),
            containerSecond.heightAnchor.constraint(equalToConstant: 200),
            
            containerThird.topAnchor.constraint(equalTo: containerSecond.bottomAnchor, constant: padding),
            containerThird.heightAnchor.constraint(equalToConstant: 200),
            
            containerFourth.topAnchor.constraint(equalTo: containerThird.bottomAnchor, constant: padding),
            containerFourth.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func fetchDay() {
        self.add(childVC: DZIntervalContainerVC(), to: self.containerFirst)
        self.add(childVC: DZIntervalContainerVC(), to: self.containerSecond)
    }
}

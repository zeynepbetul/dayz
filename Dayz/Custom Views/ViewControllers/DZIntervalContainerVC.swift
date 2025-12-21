//
//  DZIntervalContainerVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 21.12.2025.
//

import UIKit

class DZIntervalContainerVC: UIViewController {
    
    let interval             = DZTitleLabel(textAlignment: .center, fontSize: 11)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureUIElements()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    private func layoutUI() {
        view.addSubview(interval)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            interval.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            interval.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            interval.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            interval.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    private func configureUIElements() {
        interval.text = "06:00-12:00"
    }
}

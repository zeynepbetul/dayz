//
//  DZIntervalContainerVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 21.12.2025.
//

import UIKit

class DZTimeIntervalCell: UIViewController {
    
    let intervalLabel         = DZTitleLabel(textAlignment: .center, fontSize: 11)
    let activityName          = DZTitleLabel(textAlignment: .center, fontSize: 12)

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
        view.addSubview(intervalLabel)
        view.addSubview(activityName)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            intervalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            intervalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            intervalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            intervalLabel.heightAnchor.constraint(equalToConstant: 14),
            
            activityName.topAnchor.constraint(equalTo: intervalLabel.bottomAnchor, constant: padding/2),
            activityName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            activityName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            activityName.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func configureUIElements() {
        intervalLabel.text = "06:00-12:00"
        activityName.text  = "Activity Name"
    }
}

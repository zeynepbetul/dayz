//
//  DZIntervalContainerVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 21.12.2025.
//

import UIKit

class DZTimeIntervalCell: UITableViewCell {
    
    static let reuseID        = "TimeIntervalCell"
    
    let stackView             = UIStackView()
    let containerView         = UIView()
    let intervalLabel         = DZTitleLabel(textAlignment: .center, fontSize: 11)
    let activityLabel         = DZTitleLabel(textAlignment: .center, fontSize: 12)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureContainerView()
        configureStackView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func configureContainerView() {
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 18
        containerView.clipsToBounds = true
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
    }
    
    private func layoutUI() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -10)
        ])
        
        stackView.addArrangedSubview(intervalLabel)
        stackView.addArrangedSubview(activityLabel)
    }
    
    func configure(startHour: Int, endHour: Int, activityName: String? = nil) {
        intervalLabel.text = String(format: "%02d:00 - %02d:00", startHour, endHour)
        
        if let activityName {
            activityLabel.text = activityName
            activityLabel.isHidden = false
        } else {
            activityLabel.text = nil
            activityLabel.isHidden = true
        }
    }
}

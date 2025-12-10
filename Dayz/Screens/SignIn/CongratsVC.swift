//
//  CongratsVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 10.12.2025.
//

import UIKit

class CongratsVC: UIViewController {

    let viewTitleLabel = DZTitleLabel(textAlignment: .center, fontSize: 26)
    let viewSubTitleLabel = DZBodyLabel(textAlignment: .center)
    
    let getStartedButton = DZButton(backgroundColor: .black, title: "Get started")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureComponents()
    }
    
    func configureComponents() {
        viewTitleLabel.text                     = "Congratulations!"
        viewSubTitleLabel.text                  = "Your account is complete. Enjoy tracking your day!"
        
        getStartedButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        let stack = UIStackView(arrangedSubviews: [viewTitleLabel, viewSubTitleLabel, getStartedButton])
        
        stack.axis                              = .vertical
        stack.spacing                           = 16
               
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            getStartedButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func getStartedTapped() {
        UserDefaults.standard.set(true, forKey: "seenOnboarding")

        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = sceneDelegate.createTabbar()
    }

}

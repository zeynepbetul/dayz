//
//  SignInVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 9.12.2025.
//

import UIKit

class SignInVC: UIViewController {
    
    let viewTitleLabel = DZTitleLabel(textAlignment: .left, fontSize: 26)
    let viewSubTitleLabel = DZBodyLabel(textAlignment: .left)
    
    let emailTextField = DZTextField(placeholder: "Your email")
    let emailTitleLabel = DZTitleLabel(textAlignment: .left, fontSize: 11)
    
    let passwordTextField = DZTextField(placeholder: "Password")
    let passwordTitleLabel = DZTitleLabel(textAlignment: .left, fontSize: 11)
    
    let forgetPasswordTitleLabel = DZTitleLabel(textAlignment: .left, fontSize: 11)
    
    let loginButton = DZButton(backgroundColor: .black, title: "Login")
    
    let dontHaveAccountSubTitleLabel = DZBodyLabel(textAlignment: .center)
    
    let orWithSubTitleLabel = DZBodyLabel(textAlignment: .center)
    
    let googleButton = DZButton(backgroundColor: .black, title: "Sign in with Google")
    let appleButton = DZButton(backgroundColor: .black, title: "Sign in with Apple")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureComponents()
    }
    
    func configureComponents() {
        viewTitleLabel.text                     = "Welcome Back"
        viewSubTitleLabel.text                  = "Sign to your account"
        emailTitleLabel.text                    = "Email"
        passwordTitleLabel.text                 = "Password"
        forgetPasswordTitleLabel.text           = "Forget Password?"
        dontHaveAccountSubTitleLabel.text       = "Don’t have an account? Sign Up"
        orWithSubTitleLabel.text                = "Or with"
        
        
        let stack = UIStackView(arrangedSubviews: [viewTitleLabel, viewSubTitleLabel, emailTitleLabel, emailTextField, passwordTitleLabel, passwordTextField, forgetPasswordTitleLabel, loginButton, dontHaveAccountSubTitleLabel, orWithSubTitleLabel, googleButton, appleButton])
        
        stack.axis                              = .vertical
        stack.spacing                           = 16
               
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            appleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

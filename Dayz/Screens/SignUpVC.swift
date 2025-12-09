//
//  SignUpVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 9.12.2025.
//

import UIKit

class SignUpVC: UIViewController {
    let viewTitleLabel = DZTitleLabel(textAlignment: .left, fontSize: 26)
    let viewSubTitleLabel = DZBodyLabel(textAlignment: .left)
    
    let nameTextField = DZTextField(placeholder: "Name")
    let nameTitleLabel = DZTitleLabel(textAlignment: .left, fontSize: 11)
    
    let emailTextField = DZTextField(placeholder: "Email")
    let emailTitleLabel = DZTitleLabel(textAlignment: .left, fontSize: 11)
    
    let passwordTextField = DZTextField(placeholder: "Password")
    let passwordTitleLabel = DZTitleLabel(textAlignment: .left, fontSize: 11)
    
    let registerButton = DZButton(backgroundColor: .black, title: "Register")
    
    let haveAccountSubTitleLabel = DZBodyLabel(textAlignment: .center)
    let signInButton = UIButton(type: .system)
    let haveAccountStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureComponents()
        createDismissKeyboardTapGesture()
    }
    
    func configureComponents() {
        viewTitleLabel.text                     = "Sign Up"
        viewSubTitleLabel.text                  = "Create account"
        nameTitleLabel.text                     = "Name"
        emailTitleLabel.text                    = "Email"
        passwordTitleLabel.text                 = "Password"
        haveAccountSubTitleLabel.text           = "Have an account?"
        
        signInButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        
        configureHaveAccountStack()
        let stack = UIStackView(arrangedSubviews: [viewTitleLabel, viewSubTitleLabel, nameTitleLabel, nameTextField, emailTitleLabel, emailTextField, passwordTitleLabel, passwordTextField, registerButton, haveAccountStack])
        
        stack.axis                              = .vertical
        stack.spacing                           = 16
               
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            registerButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureHaveAccountStack() {
        haveAccountStack.addArrangedSubview(haveAccountSubTitleLabel)
        haveAccountStack.addArrangedSubview(signInButton)
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        signInButton.setTitleColor(.label, for: .normal)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)

        haveAccountStack.axis             = .horizontal
        haveAccountStack.spacing          = 1
        haveAccountStack.alignment        = .center
        haveAccountStack.distribution     = .fillProportionally
    }

    @objc func signInTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func registerTapped() {
        
    }
    
    
    func createDismissKeyboardTapGesture() {
        let recognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(recognizer)
    }
}

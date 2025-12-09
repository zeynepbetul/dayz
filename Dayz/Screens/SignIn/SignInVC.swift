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
    let signUpButton = UIButton(type: .system)
    let dontHaveAccountStack = UIStackView()
    
    let orWithSubTitleLabel = DZBodyLabel(textAlignment: .center)
    
    let googleButton = DZButton(backgroundColor: .black, title: "Sign in with Google")
    let appleButton = DZButton(backgroundColor: .black, title: "Sign in with Apple")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureComponents()
        createDismissKeyboardTapGesture()
    }
    
    func configureComponents() {
        viewTitleLabel.text                     = "Welcome Back"
        viewSubTitleLabel.text                  = "Sign to your account"
        emailTitleLabel.text                    = "Email"
        passwordTitleLabel.text                 = "Password"
        forgetPasswordTitleLabel.text           = "Forget Password?"
        dontHaveAccountSubTitleLabel.text       = "Don't have an account?"
        orWithSubTitleLabel.text                = "Or with"
        
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
        appleButton.addTarget(self, action: #selector(appleTapped), for: .touchUpInside)
        
        configureDontHaveAccountStack()
        let stack = UIStackView(arrangedSubviews: [viewTitleLabel, viewSubTitleLabel, emailTitleLabel, emailTextField, passwordTitleLabel, passwordTextField, forgetPasswordTitleLabel, loginButton, dontHaveAccountStack, orWithSubTitleLabel, googleButton, appleButton])
        
        stack.axis                              = .vertical
        stack.spacing                           = 16
               
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            appleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureDontHaveAccountStack() {
        dontHaveAccountStack.addArrangedSubview(dontHaveAccountSubTitleLabel)
        dontHaveAccountStack.addArrangedSubview(signUpButton)
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        signUpButton.setTitleColor(.label, for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)

        dontHaveAccountStack.axis             = .horizontal
        dontHaveAccountStack.spacing          = 1
        dontHaveAccountStack.alignment        = .center
        dontHaveAccountStack.distribution     = .fillProportionally
    }

    @objc func signUpTapped() {
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func loginTapped() {
        
    }
    
    @objc func googleTapped() {
        
    }
    
    @objc func appleTapped() {
        
    }
    
    func createDismissKeyboardTapGesture() {
        let recognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(recognizer)
    }
}

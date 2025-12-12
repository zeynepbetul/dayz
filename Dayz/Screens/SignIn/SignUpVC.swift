//
//  SignUpVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 9.12.2025.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {
    let viewTitleLabel = DZTitleLabel(textAlignment: .left, fontSize: 26)
    let viewSubTitleLabel = DZBodyLabel(textAlignment: .left)
    
    let usernameTextField = DZTextField(placeholder: "Username")
    let usernameTitleLabel = DZTitleLabel(textAlignment: .left, fontSize: 11)
    let usernameErrorLabel = DZBodyLabel(textAlignment: .left)
    
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
        usernameTitleLabel.text                 = "Username"
        emailTitleLabel.text                    = "Email"
        passwordTitleLabel.text                 = "Password"
        haveAccountSubTitleLabel.text           = "Have an account?"
        configureErrorLabel()
        
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        usernameTextField.addTarget(self, action: #selector(usernameDidEndEditing), for: .editingDidEnd)
        
        configureHaveAccountStack()
        let stack = UIStackView(arrangedSubviews: [viewTitleLabel, viewSubTitleLabel, usernameTitleLabel, usernameTextField, usernameErrorLabel, emailTitleLabel, emailTextField, passwordTitleLabel, passwordTextField, registerButton, haveAccountStack])
        
        stack.axis                              = .vertical
        stack.spacing                           = 16
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            usernameTextField.heightAnchor.constraint(equalToConstant: 44),
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
    
    @objc func usernameDidEndEditing() {
        guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !username.isEmpty else {
            usernameErrorLabel.isHidden = true
            return
        }
        
        NetworkManager.shared.checkUsernameExists(username) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.usernameErrorLabel.text = error.rawValue
                    self.usernameErrorLabel.isHidden = false
                } else {
                    self.usernameErrorLabel.isHidden = true
                }
            }
        }
    }
    
    @objc func signInTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func registerTapped() {
        let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" // 4. Nil-coalescing
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if let errorMessage = validateFields(email: email, password: password, username: username) {
            // TODO: show error
            print(errorMessage)
            return
        }
        
        // Check if username exists
        NetworkManager.shared.checkUsernameExists(username) { error in
            if let error = error {
                print(error)
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { authdata, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = authdata?.user else { return }
                
                let newUser = User(
                    id: user.uid,
                    username: username,
                    email: email,
                    name: nil,
                    bio: nil,
                    avatarUrl: nil,
                    followers: 0,
                    following: 0,
                    createdAt: Date()
                )
                
                // Save private data
                NetworkManager.shared.createPrivateUser(newUser) { error in
                    if let error = error {
                        print(error.rawValue)
                        return
                    }
                    
                    // Save public data
                    NetworkManager.shared.createPublicUser(newUser) { error in
                        if let error = error {
                            print(error.rawValue)
                            return
                        }
                        print("User created successfully")
                        user.sendEmailVerification { error in
                            if let error = error {
                                print(ErrorMessage.emailVerificationError.rawValue)
                                return
                            }
                            DispatchQueue.main.async {
                                self.navigationController?.pushViewController(ValidateEmailVC(), animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    func validateFields(email: String, password: String, username: String) -> String? {
        if email.isEmpty || password.isEmpty {
            return "Please fill in all fields."
        }
        
        if !email.contains("@") || !email.contains(".") {
            return "Please enter a valid email."
        }
        
        if password.count < 6 {
            return "Password must be at least 6 characters."
        }
        
        if username.count < 3 {
            return "Username must be at least 3 characters."
        }
        return nil
    }
    
    
    func createDismissKeyboardTapGesture() {
        let recognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(recognizer)
    }
    
    func configureErrorLabel() {
        usernameErrorLabel.textColor = .systemRed
        usernameErrorLabel.font = UIFont.systemFont(ofSize: 12)
        usernameErrorLabel.numberOfLines = 0
        usernameErrorLabel.isHidden = true
    }
}

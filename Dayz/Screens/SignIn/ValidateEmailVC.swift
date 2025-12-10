//
//  ValidateEmailVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 9.12.2025.
//

import UIKit
import FirebaseAuth

class ValidateEmailVC: UIViewController {
    let viewTitleLabel = DZTitleLabel(textAlignment: .center, fontSize: 26)
    let viewSubTitleLabel = DZBodyLabel(textAlignment: .center)
    let emailTitleLabel = DZTitleLabel(textAlignment: .center, fontSize: 16)
    
    let receiveCodeSubTitleLabel = DZBodyLabel(textAlignment: .center)
    let resendButton = UIButton(type: .system)
    let resendStack = UIStackView()
    
    var verificationTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureComponents()
        startVerificationCheck()
    }
    
    func startVerificationCheck() {
        verificationTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(checkEmailVerification), userInfo: nil, repeats: true)
    }
    
    @objc func checkEmailVerification() {
        guard let user = Auth.auth().currentUser else { return }
        
        user.reload { error in
            if let error = error {
                print("Reload error:", error.localizedDescription)
                return
            }
            
            if user.isEmailVerified {
                self.verificationTimer?.invalidate()
                self.verificationTimer = nil
                print("Email verified! Proceed to next screen")
                DispatchQueue.main.async {
                    let congratsVC = CongratsVC()
                    congratsVC.modalPresentationStyle = .fullScreen
                    self.present(congratsVC, animated: true, completion: nil)
                }
            } else {
                print("Email not verified yet")
            }
        }
    }
    deinit {
        verificationTimer?.invalidate()
    }
    
    func configureComponents() {
        viewTitleLabel.text                     = "Verification Email"
        viewSubTitleLabel.text                  = "We sent a verification email to your inbox"
        emailTitleLabel.text                    = "Johndoe@gmail.com"
        receiveCodeSubTitleLabel.text           = "If you didn’t receive an email"
        
        configureStack()
        let stack = UIStackView(arrangedSubviews: [viewTitleLabel, viewSubTitleLabel, emailTitleLabel, resendStack])
        
        stack.axis                              = .vertical
        stack.spacing                           = 16
               
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func configureStack() {
        resendStack.addArrangedSubview(receiveCodeSubTitleLabel)
        resendStack.addArrangedSubview(resendButton)
        
        resendButton.setTitle("Resend", for: .normal)
        resendButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        resendButton.setTitleColor(.label, for: .normal)
        resendButton.addTarget(self, action: #selector(resendTapped), for: .touchUpInside)

        resendStack.axis             = .horizontal
        resendStack.spacing          = 1
        resendStack.alignment        = .center
        resendStack.distribution     = .fillProportionally
    }
    
    @objc func resendTapped() {

    }

}

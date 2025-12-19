//
//  UIViewController+Ext.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 6.12.2025.
//

import UIKit
import SafariServices

// extensions must not contain stored properties.
// fileprivate is, anything in this file can use this variable.
fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentDZAlertOnMainThread(title: String, message: String, buttonTitle: String, buttonTitleSec: String?) {
        DispatchQueue.main.async {
            let alertVC = DZAlertVC(title: title, message: message, buttonTitle: buttonTitle, buttonTitleSec: buttonTitleSec)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGray6
        present(safariVC, animated: true)
    }
   
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha           = 0 // transparancy value. now view is here but cannot see. it will be slowly become visible with animation.
         
        UIView.animate(withDuration: 0.25) {containerView.alpha = 0.8}
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView      = DZEmptyStateView(message: message)
        emptyStateView.frame    = view.bounds
        view.addSubview(emptyStateView)
    }
}

//
//  UIViewController+Ext.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 6.12.2025.
//

import UIKit

extension UIViewController {
    
    func presentDZAlertOnMainThread(title: String, message: String, buttonTitle: String, buttonTitleSec: String?) {
        DispatchQueue.main.async {
            let alertVC = DZAlertVC(title: title, message: message, buttonTitle: buttonTitle, buttonTitleSec: buttonTitleSec)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}

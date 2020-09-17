//
//  UIViewController.swift
//  On The Map
//
//  Created by Simon Wells on 2020/8/13.
//  Copyright © 2020 Simon Wells. All rights reserved.
//

import UIKit

extension UIViewController {

    
    
    func buttonEnabled(_ enabled: Bool, button: UIButton) {
        if enabled {
            button.isEnabled = true
            
        } else {
            
            button.isEnabled = false
        }
    }
    //Alerts
    
    func showAlert(message: String, title: String) {
        let alertVC = UIAlertController (title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
}
    
    //open links
    
    func openLink(_ url: String) {
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url)
            else {
                showAlert(message: "Cannot open link", title: "Invalid URL")
                return
        }
}
}

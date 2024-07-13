//
//  UIViewController+Extension.swift
//  News
//
//  Created by Ajith SB 
//

import UIKit

extension UIViewController {
    // MARK: - KeyBoard handiling
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UIViewController {
    func showToast(message: String, font: UIFont = UIFont.systemFont(ofSize: 15)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width * 0.05,
                                               y: 50,
                                               width: self.view.frame.size.width * 0.9,
                                               height: 50))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)

        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}

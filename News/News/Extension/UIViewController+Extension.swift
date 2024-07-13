//
//  UIViewController+Extension.swift
//  News
//
//  Created by Aj on 13/07/24.
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


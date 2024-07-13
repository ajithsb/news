//
//  UISearchBar+Extension
//  News
//
//  Created by Ajith SB 
//

import UIKit

extension UISearchBar {
    func applyTextFieldBorder() {
        // Access the text field inside the search bar
        if let textField = self.value(forKey: "searchField") as? UITextField {
            // Set border style to none to remove default border
            textField.borderStyle = .none
            
            // Add corner radius and border to the text field
            textField.layer.cornerRadius = 10 // Adjust corner radius as needed
            textField.layer.masksToBounds = true
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.lightGray.cgColor
            
            // Set background color to white
            textField.backgroundColor = .white
        }
    }
}

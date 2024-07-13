//
//  UINavigationBar+Extension.swift
//  News
//
//  Created by Aj on 13/07/24.
//

import UIKit

extension UINavigationBar {
    func addSeparatorLine(color: UIColor = .black, height: CGFloat = 0.2) {
        let separator = UIView()
        separator.backgroundColor = color.withAlphaComponent(0.1)
        separator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(separator)

        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: height),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

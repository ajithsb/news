//
//  BaseViewController.swift
//  News
//
//  Created by Ajith SB 
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
    }
    
    private func setUpNavigationBar(){
        let leadingButton = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(hambergerButtonTapped)
        )
        leadingButton.tintColor = .black
        navigationItem.leftBarButtonItem = leadingButton
        navigationController?.navigationBar.addSeparatorLine(height: 1)
        
        // Set the back button item with no title
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: - IBActions
    
    @objc func hambergerButtonTapped() {
    }
   
}

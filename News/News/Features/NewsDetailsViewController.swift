//
//  NewsDetailsViewController.swift
//  News
//
//  Created by Ajith SB 
//

import UIKit

class NewsDetailsViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var data: Article?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle()
        tableView.register(NewsDetailsTableViewCell.nib(), forCellReuseIdentifier: NewsDetailsTableViewCell.identifier)

    }
    // MARK: - Private func
    
    private func setupNavigationTitle() {
        // Create and customize the UILabel
        let titleLabel = UILabel()
        titleLabel.text = Constants.ConstantValues.news
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        
        // Set the UILabel as the title view
        navigationItem.titleView = titleLabel
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension NewsDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: NewsDetailsTableViewCell.identifier) as! NewsDetailsTableViewCell
        if let data = data {
            cell.config(data: data)
        }
        return cell
    }
}

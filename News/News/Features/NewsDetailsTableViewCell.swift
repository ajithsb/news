//
//  NewsDetailsTableViewCell.swift
//  News
//
//  Created by Ajith SB 
//

import UIKit

class NewsDetailsTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    static let identifier = "NewsDetailsTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "NewsDetailsTableViewCell", bundle: nil)
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func config(data: ArticleEntity) {
        titleLabel.text = data.title
        dateLabel.text = data.publishedAt
        newsImageView.loadImageAsync(with: data.urlToImage)
        descriptionLabel.text = data.articleDescription
        authorLabel.text = data.author
    }
    
}

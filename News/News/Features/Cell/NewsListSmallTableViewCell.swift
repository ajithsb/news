//
//  NewsListSmallTableViewCell.swift
//  News
//
//  Created by Ajith SB 
//

import UIKit

class NewsListSmallTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    // MARK: - Properties
    static let identifier = "NewsListSmallTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "NewsListSmallTableViewCell", bundle: nil)
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(data: ArticleEntity) {
        titleLabel.text = data.title ?? ""
        dateLabel.text = data.publishedAt ?? ""
        newsImageView.loadImageAsync(with: data.urlToImage ?? "")
    }
    
}

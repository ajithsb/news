//
//  NewsListBigTableViewCell.swift
//  News
//
//  Created by Aj on 13/07/24.
//

import UIKit

class NewsListBigTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    // MARK: - Properties
    static let identifier = "NewsListBigTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "NewsListBigTableViewCell", bundle: nil)
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
    func config(data: Article) {
        titleLabel.text = data.title ?? ""
        dateLabel.text = data.publishedAt ?? ""
        newsImageView.loadImageAsync(with: data.urlToImage ?? "")

    }
    
}

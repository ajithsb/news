//
//  Article.swift
//  News
//
//  Created by Aj on 13/07/24.
//

import Foundation

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

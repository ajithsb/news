//
//  NewsModel.swift
//  News
//
//  Created by Ajith SB 
//

import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}

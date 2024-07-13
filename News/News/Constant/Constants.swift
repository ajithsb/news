//
//  Constants.swift
//  News
//
//  Created by Ajith SB 
//

import Foundation

enum Constants {

    // API EndPoints
    enum API {
        static let baseURL = "https://newsapi.org/v2/everything"
        static let apiKeyValue = "2398dd6a78f7454f87c532c8eb991fd4"
    }
    
    enum QueryParam {
        static let q = "q"
        static let page = "page"
        static let pageSize = "pageSize"
        static let apiKey = "apiKey"
    }
    
    enum ConstantValues {
        static let newsConsatnt = "bitcoin"
        static let news = "News"
        static let pageSize = 25
    }
    
}

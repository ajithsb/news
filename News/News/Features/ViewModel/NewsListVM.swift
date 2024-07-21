//
//  NewsListVM.swift
//  News
//
//  Created by Ajith SB
//

import Foundation

class NewsListVM {
    
    var totalResult = 0
    var page = 1
    let pageSize = Constants.ConstantValues.pageSize
    var onComplete: (() -> Void)?
    var onError: (() -> Void)?
    
    var newsListDataFull: [ArticleEntity] = []
    var newsListData: [ArticleEntity] = []
    var search = ""
    var errorMessage = ""
    
    func callNews(search: String = Constants.ConstantValues.newsConsatnt) {
        if let url = URL(string: Constants.API.baseURL) {
            let queryParams = [Constants.QueryParam.q: "\(search)", Constants.QueryParam.page: "\(page)", Constants.QueryParam.pageSize: "\(pageSize)",Constants.QueryParam.apiKey: Constants.API.apiKeyValue]
            if NetworkCheck.shared.isConnected {
                NetworkManager.shared.getRequest(url: url, queryParams: queryParams) { [weak self] (result: Result<NewsModel, Error>) in
                    switch result {
                    case .success(let posts):
                        // Handle success, use the array of Post models
                        guard let articles = posts.articles, let totalData = posts.totalResults else {
                            return
                        }
                        self?.totalResult = totalData
                        for item in articles {
                            CoreDataManager.shared.saveArticle(item)
                        }
                        self?.filterWithSearch()
                    case .failure(let error):
                        // Handle error
                        self?.errorMessage = "\(error.localizedDescription)"
                        self?.onError?()
                    }
                }
            } else {
                self.errorMessage = "No connection."
                self.onError?()
                filterWithSearch()
            }
        }
    }
    
    func filterWithSearch(){
        guard let articles = CoreDataManager.shared.fetchArticles() else { return }
        newsListDataFull = articles
        if !search.isEmpty {
            newsListData = newsListDataFull.filter { news in
                if let title = news.title {
                    return title.contains(search)
                }
                return false
            }
        } else {
            newsListData = newsListDataFull
        }
        self.onComplete?()
    }
    
    func isAlldataFetched() -> Bool {
        return (page * pageSize) > totalResult
    }
    
    func isFirstPage() -> Bool {
        return page == 1
    }
    
}


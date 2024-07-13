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

    var newsListDataFull: [Article] = []
    var newsListData: [Article] = []
    var search = ""
    var errorMessage = ""
    
    func callNews(search: String = Constants.ConstantValues.newsConsatnt) {
        if let url = URL(string: Constants.API.baseURL) {
            let queryParams = [Constants.QueryParam.q: "\(search)", Constants.QueryParam.page: "\(page)", Constants.QueryParam.pageSize: "\(pageSize)",Constants.QueryParam.apiKey: Constants.API.apiKeyValue]
            NetworkManager.shared.getRequest(url: url, queryParams: queryParams) { [weak self] (result: Result<NewsModel, Error>) in
                switch result {
                case .success(let posts):
                    // Handle success, use the array of Post models
                    guard let articles = posts.articles, let totalData = posts.totalResults else {
                        return
                    }
                    self?.totalResult = totalData
                    if self?.page == 1 {
                        self?.newsListDataFull = articles
                    }else{
                        self?.newsListDataFull.append(contentsOf: articles)
                    }
                    self?.filterWithSearch()
                case .failure(let error):
                    // Handle error
                    self?.errorMessage = "\(error.localizedDescription)"
                    self?.onError?()
                }
            }
        }
    }
    
    func filterWithSearch(){
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
}

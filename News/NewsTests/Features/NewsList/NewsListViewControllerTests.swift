//
//  NewsListViewControllerTests.swift
//  NewsTests
//
//  Created by Aj on 22/07/24.
//

import XCTest
@testable import News

final class NewsListViewControllerTests: XCTestCase {
    
    var viewController: NewsListViewController!
    var mockVM: MockNewsListVM!
    
    override func setUp() {
        super.setUp()
        viewController = NewsListViewController()
        _ = viewController.view
        mockVM = MockNewsListVM()
    }
}

class MockNewsListVM: NewsListVM {
    var callNewsCalled = false
    var shouldReturnError = false

    func callNews() {
        callNewsCalled = true
        if shouldReturnError {
            onError?()
        } else {
            onComplete?()
        }
    }
}

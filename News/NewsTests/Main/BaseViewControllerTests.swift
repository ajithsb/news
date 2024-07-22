//
//  BaseViewControllerTests.swift
//  NewsTests
//
//  Created by Aj on 22/07/24.
//

import XCTest
@testable import News

class BaseViewControllerTests: XCTestCase {

    var viewController: BaseViewController!

    override func setUp() {
        super.setUp()
        viewController = BaseViewController()
        _ = viewController.view // Trigger viewDidLoad
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testNavigationBarSetup() {
        // Test left bar button item
        let leftBarButtonItem = viewController.navigationItem.leftBarButtonItem
        XCTAssertNotNil(leftBarButtonItem, "Left bar button item should be set")
        XCTAssertEqual(leftBarButtonItem?.image, UIImage(systemName: "line.3.horizontal"), "Left bar button item image should be 'line.3.horizontal'")
        XCTAssertEqual(leftBarButtonItem?.tintColor, .black, "Left bar button item tint color should be black")
        
        // Test back button item
        let backButtonItem = viewController.navigationItem.backBarButtonItem
        XCTAssertNotNil(backButtonItem, "Back button item should be set")
        XCTAssertEqual(backButtonItem?.title, "", "Back button item title should be empty")
    }
}

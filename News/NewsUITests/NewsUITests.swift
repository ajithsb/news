//
//  NewsUITests.swift
//  NewsUITests
//
//  Created by Ajith SB
//

import XCTest

final class NewsUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = app.tables
        let newsTitle = "Craig Wright Faces Perjury Investigation Over Claims He Created Bitcoin"
        let newsDate = "2024-07-16T11:30:00Z"
        
        // Ensure the news item exists and tap it
        let newsStaticText = tablesQuery.staticTexts[newsTitle]
        XCTAssertTrue(newsStaticText.exists, "News item should exist")
        newsStaticText.tap()
        
        // Wait for the News button in the navigation bar to appear
        let newsButton = app.navigationBars["News"].buttons["News"]
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: newsButton, handler: nil)
        waitForExpectations(timeout: 10, handler: nil) // Increased timeout
        
        // Verify that the News button exists and tap it
        XCTAssertTrue(newsButton.exists, "News button should exist")
        newsButton.tap()
        
        // Swipe right on the specific news cell
        let dateCell = tablesQuery.cells.containing(.staticText, identifier: newsDate).children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(dateCell.exists, "Date cell should exist")
        dateCell.swipeRight()
        
        // Tap on the News button again
        newsButton.tap()
        
    }
    
    func testSearching() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchField = app/*@START_MENU_TOKEN@*/.searchFields["Serach here..."]/*[[".otherElements[\"searchField\"].searchFields[\"Serach here...\"]",".searchFields[\"Serach here...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        searchField.tap()
        
        // Type the query
        let query = "Craig"
        for character in query {
            app.keys[String(character)].tap()
        }
        
        Thread.sleep(forTimeInterval: 2.0)

        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.tap()
        
        Thread.sleep(forTimeInterval: 2.0)

        
        // Tap on a specific news item
        let tablesQuery = app.tables
        let newsTitle = "Craig Wright Faces Perjury Investigation Over Claims He Created Bitcoin"
        let newsStaticText = tablesQuery.staticTexts[newsTitle]
        XCTAssertTrue(newsStaticText.exists, "News item should exist")
        newsStaticText.tap()
        
        // Tap on the News button in the navigation bar
        let newsButton = app.navigationBars["News"].buttons["News"]
        newsButton.tap()
        
        // Clear the search field
        let clearTextButton = searchField.buttons["Clear text"]
        XCTAssertTrue(clearTextButton.waitForExistence(timeout: 20), "Clear text button should exist")
        
        clearTextButton.tap()
        
        Thread.sleep(forTimeInterval: 2.0)
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.tap()
        

        // Tap on another specific news item
        let newNewsTitle = "A Tiny Texas Village Is About To Annex a Gigantic Bitcoin Mine"
        let newNewsStaticText = tablesQuery.staticTexts[newNewsTitle]
        XCTAssertTrue(newNewsStaticText.exists, "New news item should exist")
        newNewsStaticText.tap()
        
        // Tap on the News button again
        newsButton.tap()
                
    }
}


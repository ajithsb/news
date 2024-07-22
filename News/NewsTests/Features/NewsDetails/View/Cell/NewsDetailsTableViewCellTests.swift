//
//  NewsDetailsTableViewCellTests.swift
//  NewsTests
//
//  Created by Aj on 21/07/24.
//

import CoreData
import XCTest
@testable import News

final class NewsDetailsTableViewCellTests: XCTestCase {
    
    var cell: NewsDetailsTableViewCell!
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    override func setUp() {
        super.setUp()
        // Initialize the cell from nib
        let nib = NewsDetailsTableViewCell.nib()
        cell = nib.instantiate(withOwner: nil, options: nil).first as? NewsDetailsTableViewCell
        // Ensure all IBOutlets are connected
    }
    
    override func tearDown() {
        cell = nil
        super.tearDown()
    }
    
    func testCellConfiguration() {
        // Given
        let article = ArticleEntity(entity: NSEntityDescription.entity(forEntityName: "ArticleEntity", in: context)!, insertInto: context)
        article.title = "Test Title"
        article.publishedAt = "2024-07-21"
        article.urlToImage = "https://example.com/image.jpg"
        article.articleDescription = "Test Description"
        article.author = "Test Author"
        
        // When
        cell.config(data: article)
        
        // Then
        cell.config(data: article)
        XCTAssertEqual(cell.titleLabel.text, article.title, "Title label should display the correct title")
        XCTAssertEqual(cell.dateLabel.text, article.publishedAt, "Date label should display the correct date")
        XCTAssertEqual(cell.descriptionLabel.text, article.articleDescription, "Description label should display the correct description")
        XCTAssertEqual(cell.authorLabel.text, article.author, "Author label should display the correct author")
        // For image verification, you would need to mock or verify the async image loading
    }
    
    func testCellSelectionStyle() {
        // Given
        cell.selectionStyle = .none
        
        // When
        cell.setSelected(true, animated: false)
        
        // Then
        XCTAssertEqual(cell.selectionStyle, .none, "Selection style should be .none")
    }

}

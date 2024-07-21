//
//  NewsListSmallTableViewCellTests.swift
//  NewsTests
//
//  Created by Aj on 22/07/24.
//

import CoreData
import XCTest
@testable import News

final class NewsListSmallTableViewCellTests: XCTestCase {
    
    var cell: NewsListSmallTableViewCell!
    
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
        let nib = NewsListSmallTableViewCell.nib()
        cell = nib.instantiate(withOwner: nil, options: nil).first as? NewsListSmallTableViewCell
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
        article.publishedAt = "2024-07-16T12:58:12Z"
        article.urlToImage = "https://media.wired.com/photos/6696630a5d2d61e4805c3175/191:100/w_1280,c_limit/GettyImages-1979197796.jpg"
        article.articleDescription = "Test Description"
        article.author = "Test Author"
        
        // When
        cell.config(data: article)
        
        // Then
        cell.config(data: article)
        XCTAssertEqual(cell.titleLabel.text, "Test Title", "Title label text should be correctly set")
        XCTAssertEqual(cell.dateLabel.text, "2024-07-16T12:58:12Z", "Date label text should be correctly set")
        
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

//
//  NewsDetailsViewControllerTests.swift
//  NewsTests
//
//  Created by Aj on 21/07/24.
//

import XCTest
@testable import News
import CoreData

final class NewsDetailsViewControllerTests: XCTestCase {
    
    
    var viewController: NewsDetailsViewController!
    var tableView: UITableView!
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
        
        // Load the view controller from the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as? NewsDetailsViewController
        viewController.loadViewIfNeeded()
        
        tableView = viewController.tableView
        tableView.dataSource = viewController
        tableView.delegate = viewController
    }
    
    override func tearDown() {
        deleteAllDataWithTitle(title: "Test Title")
        viewController = nil
        tableView = nil
        super.tearDown()
    }
    
    func testViewController_ViewDidLoad() {
        XCTAssertNotNil(viewController.view, "View should be loaded")
        XCTAssertNotNil(viewController.tableView, "Table view should be connected")
    }
    
    func testTableView_NumberOfRowsInSection() {
        let rows = viewController.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rows, 1, "Number of rows should be 1")
    }
    
    func testTableView_CellForRowAtIndexPath() {
        // Create a new ArticleEntity instance
        guard let entity = NSEntityDescription.entity(forEntityName: "ArticleEntity", in: context) else {
            XCTFail("Failed to create entity description for ArticleEntity")
            return
        }
        
        let newArticle: ArticleEntity? = ArticleEntity(entity: entity, insertInto: context)
        newArticle?.author = "Test Author"
        newArticle?.title = "Test Title"
        newArticle?.articleDescription = "Test Description"
        newArticle?.url = "https://example.com"
        newArticle?.urlToImage = "https://example.com/image.jpg"
        newArticle?.publishedAt = "2024-07-21"
        
        // Save the context to persist the new article
        do {
            try context.save()
        } catch {
            XCTFail("Failed to save context with error: \(error)")
        }
        
        // Set the data for the view controller
        viewController.data = newArticle
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        // Get the cell
        guard let cell = viewController.tableView(tableView, cellForRowAt: indexPath) as? NewsDetailsTableViewCell else {
            XCTFail("Failed to dequeue NewsDetailsTableViewCell")
            return
        }
        
        XCTAssertEqual(cell.titleLabel.text, newArticle?.title ?? "" , "Cell should be configured with the article title")
    }
    
    func testSetupNavigationTitle() {
        viewController.setupNavigationTitle()
        let titleLabel = viewController.navigationItem.titleView as? UILabel
        XCTAssertNotNil(titleLabel, "Title view should be a UILabel")
        XCTAssertEqual(titleLabel?.text, Constants.ConstantValues.news, "Title label text should be set correctly")
        XCTAssertEqual(titleLabel?.font, UIFont.systemFont(ofSize: 17, weight: .bold), "Title label font should be set correctly")
        XCTAssertEqual(titleLabel?.textColor, UIColor.black, "Title label text color should be set correctly")
    }
    
    func deleteAllDataWithTitle(title: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleEntity")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                if let objectData = object as? NSManagedObject {
                    context.delete(objectData)
                }
            }
            try context.save()
        } catch let error {
            print("Delete all data with title \(title) error: ", error)
        }
    }
}

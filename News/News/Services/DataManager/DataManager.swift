//
//  DataManager.swift
//  News
//
//  Created by Aj on 20/07/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    // Reference to the managed object context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func articleExists(withTitle title: String) -> Bool {
        let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Failed to check if article exists: \(error)")
            return false
        }
    }
    func saveArticle(_ article: Article) -> Bool {
        guard let title = article.title else {
            print("Article title is nil.")
            return false
        }
        
        if articleExists(withTitle: title) {
            print("Article with title '\(title)' already exists.")
            return false
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "ArticleEntity", in: context)!
        let newArticle = ArticleEntity(entity: entity, insertInto: context)
        newArticle.author = article.author
        newArticle.title = title
        newArticle.articleDescription = article.description
        newArticle.url = article.url
        newArticle.urlToImage = article.urlToImage
        newArticle.publishedAt = article.publishedAt
        saveContext()
        return true
    }
    
    // MARK: - Fetch Articles
    func fetchArticles() -> [ArticleEntity]? {
        let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        do {
            let articles = try context.fetch(fetchRequest)
            return articles
        } catch {
            print("Failed to fetch Articles: \(error)")
            return nil
        }
    }
}

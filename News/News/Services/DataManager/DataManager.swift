//
//  DataManager.swift
//  News
//
//  Created by Aj on 20/07/24.
//

import Foundation
import CoreData

// Protocol for managing articles
protocol ArticleManaging {
    func saveArticle(_ article: Article)
    func articleExists(withTitle title: String) -> Bool
}

// Protocol for fetching articles
protocol ArticleFetching {
    func fetchArticles() -> [ArticleEntity]?
}

class CoreDataManager: ArticleManaging, ArticleFetching {
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
    
    // MARK: - ArticleManaging Protocol Methods
    func saveArticle(_ article: Article) {
        guard let title = article.title else {
            return
        }
        
        if articleExists(withTitle: title) {
            return
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
    
    // MARK: - ArticleFetching Protocol Method
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

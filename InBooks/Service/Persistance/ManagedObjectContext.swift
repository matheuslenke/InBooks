//
//  ManagedObjectContext.swift
//  InBooks
//
//  Created by Matheus Lenke on 12/05/22.
//

import Foundation

import UIKit
import CoreData

typealias onCompletionHandler = (String) -> Void

protocol managedProtocol {
    func getBooks() -> [SimpleBook]
}

protocol managedSaveProtocol {
    func save(book: SimpleBook, onCompletionHandler: onCompletionHandler)
}

protocol managedDeleteProtocol {
    func delete(title: String, onCompletionHandler: onCompletionHandler)
}

class ManagedObjectContext: managedProtocol, managedSaveProtocol, managedDeleteProtocol {
    
    private let entity = "PersistanceBook"
    
    static let shared: ManagedObjectContext = {
        let instance = ManagedObjectContext()
        return instance
    }()

    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getBooks() -> [SimpleBook] {
        var booksList: [SimpleBook] = []
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)

        do {
            guard let books = try getContext().fetch(fetchRequest) as? [NSManagedObject] else { return booksList }

            for item in books {

                if let bookTitle = item.value(forKey: "title") as? String,
                   let cover = item.value(forKey: "coverUrl") as? String {

                    let newBook = SimpleBook(title: bookTitle, coverUrl: cover)

                    booksList.append(newBook)
                }
            }
        } catch let error as NSError {
            print("Error in request \(error.localizedDescription)")
        }

        return booksList
    }

    func save(book: SimpleBook, onCompletionHandler: (String) -> Void) {
        
        let context = getContext()

        guard let entity = NSEntityDescription.entity(forEntityName: entity, in: context) else { return }
        let transaction = NSManagedObject(entity: entity, insertInto: context)

        transaction.setValue(book.title, forKey: "title")
        transaction.setValue(book.coverUrl, forKey: "coverUrl")

        do {
            try context.save()
            onCompletionHandler("Save Success")

        } catch let error as NSError {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    
    func delete(title: String, onCompletionHandler: (String) -> Void) {
        let context = getContext()
        let predicate = NSPredicate(format: "title == %@","\(title)")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>=NSFetchRequest(entityName: entity)
        
        fetchRequest.predicate = predicate
        
        do {
            let fetchResult = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            if let entityDelete = fetchResult.first {
                context.delete(entityDelete)
            }
            
            try context.save()
            
            onCompletionHandler("Delete Success")
            
        } catch let error as NSError {
            print("Fetch failed \(error.localizedDescription)")
        }
    }
    
}

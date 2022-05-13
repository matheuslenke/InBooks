//
//  FavoritesViewModel.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import Foundation

class LibraryViewModel {
    
    var books: [SimpleBook] = []
    
    init() {
        fetchBooks()
    }
    
    func fetchBooks() {
        books = ManagedObjectContext.shared.getBooks()
    }
    
    func deleteBook(book: SimpleBook) {
        let index = books.firstIndex { b in
            return b.title == book.title
        }
        if let index = index {
            books.remove(at: index)            
        }
    }
}

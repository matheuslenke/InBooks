//
//  BookDetailsViewModel.swift
//  InBooks
//
//  Created by Matheus Lenke on 12/05/22.
//

import Foundation

class BookDetailsViewModel {
    
    var book: Book
    var descriptionElements: [TextDescriptionElement] = []
    
    init(book: Book) {
        self.book = book
        descriptionElements = createTextDescriptionElements()
    }
    
    private func createTextDescriptionElements() -> [TextDescriptionElement] {
        var textDescriptions: [TextDescriptionElement] = []
            
        textDescriptions.append(TextDescriptionElement(title: "Sinopse:", description: book.sinopse ?? ""))
        textDescriptions.append(TextDescriptionElement(title: "ISBN:", description: book.isbn))
        textDescriptions.append(TextDescriptionElement(title: "Formato:", description: book.formato?.rawValue ?? "Físico" ))
        textDescriptions.append(TextDescriptionElement(title: "Preço:", description: book.preco ?? "0"))
        textDescriptions.append(TextDescriptionElement(title: "Ano edição:", description: book.anoEdicao ?? "Sem ano"))
        return textDescriptions
    }
    
}

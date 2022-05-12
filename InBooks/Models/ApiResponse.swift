//
//  ApiResponse.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import Foundation

struct ApiSearchBooksResponse: Codable {
    let books: [Book]?
    let navigation: Navigation?
    let status: Status
}

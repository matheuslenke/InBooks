//
//  ApiError.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import Foundation

public enum BooksAPIError: Error {
    case error(String)
    case requestFailed(Error)
    case urlInvalid
    case noDataAvailable
    case noProcessData
}

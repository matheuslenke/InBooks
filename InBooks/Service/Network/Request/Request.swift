//
//  Request.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import Foundation

enum Request: URLRequestProtocol {
    
    case searchBooksByTitle(title: String, page: Int)
    
    /// The API's base url
    var baseURL: String {
        return Environment.baseURL
    }
    
    /// Defines the endpoint we want to hit
    var path: String {
        switch self {
        case .searchBooksByTitle:
            return "book"
        }
    }
    
    /// The API's query params
    var queryParams: [URLQueryItem] {
        switch self {
        case .searchBooksByTitle(let title, let page):
            return [URLQueryItem(name: "titulo", value: title), URLQueryItem(name: "page", value: "\(page)")]
        }
    }
    
    /// Relative to the method we want to call, that was defined with an enum above
    var method: HTTPMethod {
        switch self {
        case .searchBooksByTitle:
            return .get
        }
    }
    
}


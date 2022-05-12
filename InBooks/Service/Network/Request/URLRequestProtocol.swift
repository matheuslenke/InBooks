//
//  URLRequestProtocol.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import Foundation

protocol URLRequestProtocol {
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var queryParams: [URLQueryItem] { get }
    
    var method: HTTPMethod { get }
}

//
//  HTTPMethod.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import Foundation

enum HTTPMethod: String {
    
    // Defines the supported tyoes of HTTP methods
    case post
    case put
    case `get`
    case delete
    case patch
    
    public var name: String {
        return rawValue.uppercased()
    }
}

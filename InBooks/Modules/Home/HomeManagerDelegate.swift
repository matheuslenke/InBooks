//
//  HomeManagerDelegate.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import Foundation

protocol HomeManagerDelegate: AnyObject {
    func fetchBooksWithSuccess()
    func errorToFetchBooks(_ error: String)
}

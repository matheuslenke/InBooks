//
//  ViewStateProtocol.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import UIKit

enum ViewState {
    case loading
    case normal
    case error
    case empty
}

protocol MultiStateViewProtocol {
            
    func setupLoadingState()
    func setupErrorState(message: String?)
    func setupNormalState()
    func setupEmptyState(message: String?)
    
}


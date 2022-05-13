//
//  BookDetailsCoordinator.swift
//  InBooks
//
//  Created by Matheus Lenke on 12/05/22.
//

import UIKit

class BookDetailsCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    var rootViewController: UINavigationController {
        return navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    var book: Book?
    
    func start() {
        
        let bookDetailsViewController = BookDetailsViewController()
        if let book = book {
            let viewModel = BookDetailsViewModel(book: book)
            bookDetailsViewController.viewModel = viewModel
        }
        
        navigationController.pushViewController(bookDetailsViewController, animated: true)
    }
    
}

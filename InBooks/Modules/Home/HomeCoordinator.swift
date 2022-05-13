//
//  HomeCoordinator.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    var rootViewController: UINavigationController {
        return navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let homeViewController = HomeViewController()
        let booksService = BooksService()
        let viewModel =  HomeViewModel(searchBookService: booksService)
        viewModel.coordinator = self
        homeViewController.viewModel = viewModel
        
        navigationController.setViewControllers([homeViewController], animated: true)
    }
    
    func bookDetail(book: Book) {
        let bookDetailsCoordinator = BookDetailsCoordinator(navigationController: navigationController)
        bookDetailsCoordinator.book = book
        childCoordinators.append(bookDetailsCoordinator)
        bookDetailsCoordinator.start()
    }
    
}

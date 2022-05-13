//
//  LibraryCoordinator.swift
//  InBooks
//
//  Created by Matheus Lenke on 12/05/22.
//

import UIKit

class LibraryCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    var rootViewController: UINavigationController {
        return navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let libraryViewController = LibraryViewController()
        let viewModel = LibraryViewModel()
        libraryViewController.viewModel = viewModel
        viewModel.delegate = libraryViewController

        navigationController.setViewControllers([libraryViewController], animated: true)
    }

    
    
}

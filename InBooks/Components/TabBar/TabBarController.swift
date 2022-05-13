//
//  TabBarController.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: Coordinators
    
    private var homeCoordinator: HomeCoordinator?
//    private var bookDetailsCoordinator: BookDetailsCoordinator?
    private var libraryCoordinator: LibraryCoordinator?
    
    // MARK: View Controllers
    
    private var homeViewController: UIViewController? {
        return self.homeCoordinator?.rootViewController
    }
    
//    private var bookDetailsViewController: UIViewController? {
//        return self.homeCoordinator?.rootViewController
//    }
    
    private var libraryViewController: UIViewController? {
        return self.libraryCoordinator?.rootViewController
    }
    
    // MARK: UI Elements
    
    lazy var homeViewNavigationController: UINavigationController = {
        let navigation = UINavigationController()
        
        let homeTabBar = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        navigation.tabBarItem = homeTabBar
        return navigation
    }()
    
    lazy var libraryNavigationController: UINavigationController = {
        let navigation = UINavigationController(rootViewController: LibraryViewController())
        let libraryTabBar = UITabBarItem(title: "My Library", image: UIImage(systemName: "books.vertical.circle.fill"), tag: 1)
        navigation.tabBarItem = libraryTabBar
        return navigation
    }()
    
    lazy var appearance: UITabBarAppearance = {
        var appearance = UITabBarAppearance()
//        appearance.shadowColor = Colors.secondaryBackgoundColor
        appearance.selectionIndicatorTintColor = .systemBrown
        appearance.backgroundColor = .systemBackground
//        appearance.titleTextAttributes = [.foregroundColor: Colors.tintTabBarItem ?? UIColor.label]
        return appearance
    }()
    
    // MARK: Life Cycle
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
        setupCoordinators()
        setupViewControllers()
    }
    
    // MARK: Private Functions
    
    private func configTabBar() {
        self.tabBar.standardAppearance = appearance
        self.tabBar.isTranslucent = true
//        homeViewNavigationController.navigationBar.standardAppearance = appearance
        self.viewControllers = [homeViewNavigationController, libraryNavigationController]
    }
    
    private func setupCoordinators() {
        homeCoordinator = HomeCoordinator(navigationController: homeViewNavigationController)
        homeCoordinator?.start()
        
        libraryCoordinator = LibraryCoordinator(navigationController: libraryNavigationController)
        libraryCoordinator?.start()
    }
    
    private func setupViewControllers() {
        if let homeViewController = homeViewController,
        let libraryViewController = libraryViewController {
            setViewControllers([homeViewController, libraryViewController], animated: true)
        }
    }
    

}

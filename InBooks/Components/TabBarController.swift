//
//  TabBarController.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: UI Elements
    
    lazy var homeViewNavigationController: UINavigationController = {
        let home = HomeViewController()
        home.viewModel = HomeViewModel(searchBookService: BooksService())
        home.title = "Home"
        let navigation = UINavigationController(rootViewController: home)
        
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
        self.tabBar.standardAppearance = appearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
    }
    
    private func configTabBar() {
        self.tabBar.standardAppearance = appearance
        self.tabBar.isTranslucent = true
//        homeViewNavigationController.navigationBar.standardAppearance = appearance
        self.viewControllers = [homeViewNavigationController, libraryNavigationController]
    }
    
    // MARK: Private Functions

}

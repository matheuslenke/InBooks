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
        let navigation = UINavigationController(rootViewController: HomeViewController())
        let homeTabBar = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        navigation.tabBarItem = homeTabBar
        return navigation
    }()
    
    lazy var favoritesNavigationController: UINavigationController = {
        let navigation = UINavigationController(rootViewController: FavoritesViewController())
        let favoritesTabBar = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)
        navigation.tabBarItem = favoritesTabBar
        return navigation
    }()
    
    lazy var appearance: UITabBarAppearance = {
        var appearance = UITabBarAppearance()
//        appearance.shadowColor = Colors.secondaryBackgoundColor
        appearance.backgroundColor = .systemBackground
//        appearance.titleTextAttributes = [.foregroundColor: Colors.tintTabBarItem ?? UIColor.label]
        return appearance
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
    }
    
    private func configTabBar() {
        self.tabBar.isTranslucent = false
        self.tabBar.standardAppearance = appearance
//        homeViewNavigationController.navigationBar.standardAppearance = appearance
        self.viewControllers = [homeViewNavigationController, favoritesNavigationController]
    }
    
    // MARK: Private Functions

}

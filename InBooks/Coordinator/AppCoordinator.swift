//
//  AppCoordinator.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        let mainTabBarController = TabBarController()
        
        window.rootViewController = mainTabBarController
        
        window.makeKeyAndVisible()
                
    }
}

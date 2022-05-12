//
//  Coordinator.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import Foundation

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get }
    
    func start()
}

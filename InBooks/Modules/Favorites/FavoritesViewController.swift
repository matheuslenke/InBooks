//
//  FavoritesViewController.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    lazy var favoritesView: FavoritesView = {
        let favorites = FavoritesView()
        return favorites
    }()
    
    override func loadView() {
        self.view = favoritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    

}

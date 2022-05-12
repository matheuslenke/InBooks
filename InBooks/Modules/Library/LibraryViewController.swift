//
//  FavoritesViewController.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import UIKit

class LibraryViewController: UIViewController {
    
    lazy var libraryView: LibraryView = {
        let library = LibraryView()
        return library
    }()
    
    override func loadView() {
        self.view = libraryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    

}

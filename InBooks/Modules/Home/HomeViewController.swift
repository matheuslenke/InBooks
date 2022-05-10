//
//  HomeViewController.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var homeView: HomeView = {
        let homeView = HomeView()
        return homeView
    }()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

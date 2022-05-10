//
//  HomeView.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didSelectActivity()
}

class HomeView: UIView {

    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

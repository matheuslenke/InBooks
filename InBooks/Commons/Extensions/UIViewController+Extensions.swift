//
//  UIViewController+Extensions.swift
//  InBooks
//
//  Created by Matheus Lenke on 12/05/22.
//

import UIKit

extension UIViewController {
    
    func displayAlert(titulo: String, mensagem: String, completion: ( () -> Void)? = nil) {
        let alertController = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            completion?()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


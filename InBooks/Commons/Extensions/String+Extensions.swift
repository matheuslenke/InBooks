//
//  String+Extensions.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import UIKit

extension String {
    
    func formatPrice(with currency: String) -> String {
        switch currency {
        case "BRL":
            return "R$\(self)"
        default:
            return "$\(self)"
        }
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return boundingBox.height
    }
}

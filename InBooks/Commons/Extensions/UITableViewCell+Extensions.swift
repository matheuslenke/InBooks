//
//  Extension+UITableViewCell.swift
//  InBooks
//
//  Created by Matheus Lenke on 11/05/22.
//

import UIKit

extension UITableViewCell {

    class func classIdentifier() -> String {
        guard let className = String(describing: self).components(separatedBy: ".").last else {
            return ""
        }

        return className
    }
}

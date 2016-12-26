//
//  Extensions.swift
//  budgeter
//
//  Created by Kevin Maloles on 26/12/2016.
//  Copyright © 2016 KAM. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    class func nib() -> UINib {
        return UINib(nibName: handyClassName(), bundle: NSBundle(forClass: self))
    }
    
    class func reuseIdentifier() -> String {
        return handyClassName()
    }
    
    class func handyClassName() -> String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}
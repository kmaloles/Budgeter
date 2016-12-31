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

extension NSDate
{
    func hour() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
    
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let minute = components.minute
        
        //Return Minute
        return minute
    }
    
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let timeString = formatter.stringFromDate(self)
        
        //Return Short Time String
        return timeString
    }
    
    func toShortDateString() -> String {
        
        return ""
    }
}

extension Dictionary{
    func keyExpense() -> String {
        return Constants.keyExpenseValue
    }
    
    func keyDate() -> String {
        return Constants.keyDate
    }
    
    func keyId() -> String {
        return Constants.keyId
    }
}

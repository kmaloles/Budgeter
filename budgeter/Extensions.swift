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

extension String {
    var length: Int {
        get {
            return self.characters.count
        }
    }
    
    func contains(s: String) -> Bool {
        return self.rangeOfString(s) != nil ? true : false
    }
    
    func replace(target: String, withString: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    subscript (i: Int) -> Character {
        get {
            let index = startIndex.advancedBy(i)
            return self[index]
        }
    }
    
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.startIndex.advancedBy(r.endIndex - 1)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
    
    func subString(startIndex: Int, length: Int) -> String {
        let start = self.startIndex.advancedBy(startIndex)
        let end = self.startIndex.advancedBy(startIndex + length)
        return self.substringWithRange(Range<String.Index>(start: start, end: end))
    }
    
    func indexOf(target: String) -> Int {
        let range = self.rangeOfString(target)
        if let range = range {
            return self.startIndex.distanceTo(range.startIndex)
        } else {
            return -1
        }
    }
    
    func indexOf(target: String, startIndex: Int) -> Int {
        let startRange = self.startIndex.advancedBy(startIndex)
        
        let range = self.rangeOfString(target, options: NSStringCompareOptions.LiteralSearch, range: Range<String.Index>(start: startRange, end: self.endIndex))
        
        if let range = range {
            return self.startIndex.distanceTo(range.startIndex)
        } else {
            return -1
        }
    }
    
    func lastIndexOf(target: String) -> Int {
        var index = -1
        var stepIndex = self.indexOf(target)
        while stepIndex > -1 {
            index = stepIndex
            if stepIndex + target.length < self.length {
                stepIndex = indexOf(target, startIndex: stepIndex + target.length)
            } else {
                stepIndex = -1
            }
        }
        return index
    }
    
    func isMatch(regex: String, options: NSRegularExpressionOptions) -> Bool {
        var exp:NSRegularExpression?
        
        do {
            exp = try NSRegularExpression(pattern: regex, options: options)
            
        } catch let error as NSError {
            exp = nil
            print(error.description)
            return false
        }
        
        let matchCount = exp!.numberOfMatchesInString(self, options: [], range: NSMakeRange(0, self.length))
        return matchCount > 0
    }
    
    func getMatches(regex: String, options: NSRegularExpressionOptions) -> [NSTextCheckingResult] {
        var exp:NSRegularExpression?
        
        do {
            exp = try NSRegularExpression(pattern: regex, options: options)
        } catch let error as NSError {
            print(error.description)
            exp = nil
            return []
        }
        
        let matches = exp!.matchesInString(self, options: [], range: NSMakeRange(0, self.length))
        return matches
    }
}

extension UITextField {
    func setBottomBorder(borderColor: UIColor)
    {
        self.borderStyle = UITextBorderStyle.None
        self.backgroundColor = UIColor.clearColor()
        let width = 0.5
        
        let borderLine = UIView(frame: CGRectMake(0, self.frame.height - CGFloat(width), self.frame.width + self.frame.width , CGFloat(width)))
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
}

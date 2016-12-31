//
//  DateFormatter.swift
//  budgeter
//
//  Created by Kevin Maloles on 26/12/2016.
//  Copyright © 2016 KAM. All rights reserved.
//


import Foundation

class DateFormatter {
    
    let serverTimeFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    let serverTimeFormat2 = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    
    let localTimeFormat = "EEE\nMMM dd\nh:mm a"
    let localTimeFormatToday = "MMM dd\nh:mm a"
    let timeFormatDayOfWeek = "EEE"
    let timeFormatDayOfMonth = "MMM dd"
    let timeFormatTimeOfDay = "h:mm a"
    let idFormat = "yyyyMMddHHmmss"
    
    let todayString = "Today"
    
    let serverDateFormatter = NSDateFormatter()
    let serverDateFormatter2 = NSDateFormatter()
    let localDateFormatter = NSDateFormatter()
    let localDateFormatterToday = NSDateFormatter()
    let localDateFormatterDayOfWeek = NSDateFormatter()
    let localDateFormatterDayOfMonth = NSDateFormatter()
    let localDateFormatterTimeOfDay = NSDateFormatter()
    let idFormatter = NSDateFormatter()
    
    
    static let sharedInstance = DateFormatter()
    
    init() {
        let utcTimezone = NSTimeZone(abbreviation: "UTC")
        let localTimezone = NSTimeZone.localTimeZone()
        
        serverDateFormatter.dateFormat = serverTimeFormat
        serverDateFormatter2.dateFormat = serverTimeFormat2
        localDateFormatter.dateFormat = localTimeFormat
        localDateFormatterToday.dateFormat = localTimeFormatToday
        localDateFormatterDayOfWeek.dateFormat = timeFormatDayOfWeek
        localDateFormatterDayOfMonth.dateFormat = timeFormatDayOfMonth
        localDateFormatterTimeOfDay.dateFormat = timeFormatTimeOfDay
        idFormatter.dateFormat = idFormat
        
        serverDateFormatter.timeZone = utcTimezone
        serverDateFormatter2.timeZone = utcTimezone
        localDateFormatter.timeZone = localTimezone
        localDateFormatterDayOfWeek.timeZone = localTimezone
        localDateFormatterDayOfMonth.timeZone = localTimezone
        localDateFormatterTimeOfDay.timeZone = localTimezone
        localDateFormatterToday.timeZone = localTimezone
    }
    
    func getDateFromString(dateNotNull: String) -> NSDate? {
        return getDate(dateNotNull)
    }
    
    func getDate(date: String?) -> NSDate? {
        if  let date = date {
            var result = serverDateFormatter.dateFromString(date)
            if result == nil {
                result = serverDateFormatter2.dateFromString(date)
            }
            return result
        }
        return nil
    }
    
    func getDayOfWeekFromDate(date: NSDate) -> String {
        return localDateFormatterDayOfWeek.stringFromDate(date)
    }
    
    func getDayOfMonthFromDate(date: NSDate) -> String {
        return localDateFormatterDayOfMonth.stringFromDate(date)
    }
    
    func getTimeOfDayFromDate(date: NSDate) -> String {
        return localDateFormatterTimeOfDay.stringFromDate(date)
    }
    
    func getIdFromDate (date: NSDate) -> String {
        return idFormatter.stringFromDate(date)
    }
    
    func isDateToday(date: NSDate) -> Bool {
        let cal = NSCalendar.currentCalendar()
        var components = cal.components([.Era, .Year, .Month, .Day], fromDate:NSDate())
        let today = cal.dateFromComponents(components)!
        
        components = cal.components([.Era, .Year, .Month, .Day], fromDate: date);
        let otherDate = cal.dateFromComponents(components)!
        
        return today.isEqualToDate(otherDate)
    }
//
//    func getCurrentTime() -> String {
//        let now = moment() /* (now) */
//        let date: NSDate = NSDate.init(timeIntervalSince1970: now.epoch())
//        return serverDateFormatter.stringFromDate(date)
//    }
//    
//    func getCurrentTimestamp() -> Int {
//        return Int(moment().epoch())
//    }
//    
    
    
//    func getFormattedFullDate(serverFormatDate: String) -> String {
//        guard let date = getDate(serverFormatDate) else {
//            return serverFormatDate
//        }
//        return "\(getDayOfWeekFromDate(date)), \(getDayOfMonthFromDate(date)) AT \(getTimeOfDayFromDate(date))".uppercaseString
//    }
//    
//    func getDateStringForList(event: Event?) -> String {
//        let date = getDate(event)
//        if let date = date {
//            let cal = NSCalendar.currentCalendar()1
//            var components = cal.components([.Era, .Year, .Month, .Day], fromDate:NSDate())
//            let today = cal.dateFromComponents(components)!
//            
//            components = cal.components([.Era, .Year, .Month, .Day], fromDate: date);
//            let otherDate = cal.dateFromComponents(components)!
//            
//            if(today.isEqualToDate(otherDate)) {
//                return (self.todayString + "\n" + localDateFormatterToday.stringFromDate(date))
//            } else {
//                let result = localDateFormatter.stringFromDate(date)
//                return result
//            }
//        }
//        return ""
//    }
//    
//    func getRelativeSpanToDate(serverDate: String) -> String {
//        let nullableDate = getDateFromString(serverDate)
//        guard let date = nullableDate else {return ""}
//        return date.timeAgoSinceNow()
//    }
}

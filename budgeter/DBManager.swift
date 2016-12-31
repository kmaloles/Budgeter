//
//  DBManager.swift
//  budgeter
//
//  Created by Kevin Maloles on 30/12/2016.
//  Copyright © 2016 KAM. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    
    static let sharedInstance  = DBManager()
    let dateFormatter = DateFormatter.sharedInstance
    let realm = try! Realm()
    
    func persistExpense(expense: Dictionary<String, AnyObject>) {
        let date = (expense[expense.keyDate()] as? NSDate)!
        let id = getYearMonDD(date)
        let expense = (expense[expense.keyExpense()] as? Int)!
        
        try! realm.write() {
            let newExpense = Expense()
            newExpense.id = id
            newExpense.expense = expense
            newExpense.date = date
            self.realm.add(newExpense)
        }
        
    }
    
    func getYearMonDD(date: NSDate) -> Int {
        return Int(self.dateFormatter.getIdFromDate(date))!
    }
    
    func getAllExpenses() -> Results<Expense> {
        return realm.objects(Expense)
    }
    
    func countExpenses() -> Int {
        return realm.objects(Expense).count
    }
}

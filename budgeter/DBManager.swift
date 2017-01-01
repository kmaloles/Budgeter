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
    
    func getYearMonDD(date: NSDate) -> String {
        return self.dateFormatter.getIdFromDate(date)
    }
    
    func getAllExpenses() -> Results<Expense> {
        return realm.objects(Expense)
    }
    
    func countExpenses() -> Int {
        return realm.objects(Expense).count
    }
    
    func getDateSections() -> [String] {
        var dateSections = [String]()
        let result = getAllExpenses()
        for expense in result {
            dateSections.append(expense.id.subString(0, length: 8))
        }
        return Array(Set(dateSections)).sort({$0 > $1})
    }
    
    func getExpensesForSection(section: String) -> Results<Expense> {
        let predicate = NSPredicate(format: "id CONTAINS %@", section)
        return realm.objects(Expense).filter(predicate).sorted("id", ascending: false)
    }
    
    func deleteMyExpense(indexPath: NSIndexPath){
        let sections = getDateSections()
        let expensesForSection = getExpensesForSection(sections[indexPath.section])
        let expenseToDelete = expensesForSection[indexPath.row]
        print("Deleting \(expenseToDelete)")
        try! realm.write() {
            realm.delete(expenseToDelete)
        }
        
    }
}

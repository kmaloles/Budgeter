//
//  ExpenseViewController.swift
//  budgeter
//
//  Created by Kevin Maloles on 22/12/2016.
//  Copyright © 2016 KAM. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm

class ExpenseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var expenseText: UITextField!
    @IBOutlet weak var addExpenseButton: UIButton!
    let cellConfigurator = ExpenseCellConfigurator()
    
    var expense = [Int]()
    let realm = try! Realm()
    var expenseToPersist = Dictionary<String, AnyObject>()
    
    @IBAction func onAddExpenseTapped(sender: UIButton) {
        addExpense()
    }

    let dbmanager = DBManager.sharedInstance
    let dateFormatter = DateFormatter.sharedInstance
    
    override func viewDidLoad() {
        tableView.registerNib(ExpenseTableCell.nib(), forCellReuseIdentifier: ExpenseTableCell.reuseIdentifier())
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
//        let paddingView = UIView(frame:CGRectMake(0, 0, 30, 30))
        expenseText.leftView = addExpenseButton
        expenseText.leftViewMode = UITextFieldViewMode.Always
        expenseText.clearButtonMode = .WhileEditing
        expenseText.borderStyle = UITextBorderStyle.RoundedRect
        
        addDoneButtonToKeyboard()
//        expenseText.addTarget(self, action: #selector(onExpenseFieldTapped), forControlEvents: UIControlEvents.TouchDown)
        
    }
    
    func addDoneButtonToKeyboard(){
        //Add done button to numeric pad keyboard
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(addExpense))
        toolbarDone.items = [barBtnDone] // You can even add cancel button too
        expenseText.inputAccessoryView = toolbarDone
    }
    
    func addExpense(){
        if let value = Int(expenseText.text!){
            let date = NSDate()
            expenseToPersist[expenseToPersist.keyExpense()] = value
            expenseToPersist[expenseToPersist.keyDate()] = date
//            expense.append(value)
            dbmanager.persistExpense(expenseToPersist)
            tableView.reloadData()
        }else{
            expenseText.becomeFirstResponder()
        }
        print("Expense count: \(expense.count)")
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        tableView.reloadData()
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
//        return expense.count
        return dbmanager.countExpenses()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //      let cell: EventTableViewCell = tableView.dequeueReusableCellWithIdentifier(EventTableViewCell.reuseIdentifier(), forIndexPath: indexPath) as! EventTableViewCell
//        cell.delegate = self

        let cell:ExpenseTableCell = self.tableView.dequeueReusableCellWithIdentifier(ExpenseTableCell.reuseIdentifier(), forIndexPath: indexPath) as! ExpenseTableCell
//         let item = expense[indexPath.row]
        let expenseItem = dbmanager.getAllExpenses()[indexPath.row]
        cellConfigurator.configure(expenseItem, cell: cell)
//        cell.textLabel?.text = String(item)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("You selected cell #\(indexPath.row)!")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
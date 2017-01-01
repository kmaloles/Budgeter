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
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryText: UITextView!
    @IBOutlet weak var categoryView: UIView!
    
    let cellConfigurator = ExpenseCellConfigurator()
    
    var expense = [Int]()
    let realm = try! Realm()
    var expenseToPersist = Dictionary<String, AnyObject>()
    
    @IBAction func onAddExpenseTapped(sender: UIButton) {
        addExpense()
    }

    let dbmanager = DBManager.sharedInstance
    let dateFormatter = DateFormatter.sharedInstance
//    let newExpenseTpe = Dictionary[String]
    
    override func viewDidLoad() {
//        print("Date Sections : \(dbmanager.getExpensesForSection("20170101"))")
        tableView.registerNib(ExpenseTableCell.nib(), forCellReuseIdentifier: ExpenseTableCell.reuseIdentifier())
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        let categoryTap = UITapGestureRecognizer(target: self, action: #selector(showCategorySelector))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        categoryImage.addGestureRecognizer(categoryTap)
        categoryText.addGestureRecognizer(categoryTap)
        categoryView.addGestureRecognizer(categoryTap)
        
//        let border = CALayer()
//        let width = CGFloat(0.5)
//        border.borderColor = UIColor.lightGrayColor().CGColor
//        border.frame = CGRect(x: 0, y: expenseText.frame.size.height - width, width: expenseText.frame.size.width, height: expenseText.frame.size.height)
//        
//        border.borderWidth = width
//        expenseText.layer.addSublayer(border)
//        expenseText.layer.masksToBounds = true
        
//        let paddingView = UIView(frame:CGRectMake(0, 0, 30, 30))
        expenseText.leftView = addExpenseButton
        expenseText.leftViewMode = .Always
        expenseText.clearButtonMode = .WhileEditing
        expenseText.setBottomBorder(UIColor.lightGrayColor())
        
        addDoneButtonToKeyboard()
        
    }
    
    func refreshCategoriesView(type: String){
        let newImage = UIImage(named: type)
        UIView.transitionWithView(self.categoryView,
                                  duration: 0.5,
                                  options: .TransitionCrossDissolve,
                                  animations: { self.categoryImage.image = newImage; self.categoryText.text = type },
                                  completion: nil)
    }
    
    func showCategorySelector(){
        let alertController = UIAlertController(title: nil, message: "Type of expense", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { action in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(cancelAction)
        //TODO: yuck! simplify all these
        let fareSelected = UIAlertAction(title: "Fare", style: .Default) { action in
            self.refreshCategoriesView("Fare")
        }
        alertController.addAction(fareSelected)
        
        let foodSelected = UIAlertAction(title: "Food", style: .Default) { action in
            self.refreshCategoriesView("Food")
        }
        alertController.addAction(foodSelected)
        
        let billSelected = UIAlertAction(title: "Bill", style: .Default) { action in
            self.refreshCategoriesView("Bill")
        }
        alertController.addAction(billSelected)
        
        let rentSelected = UIAlertAction(title: "Rent", style: .Default) { action in
            self.refreshCategoriesView("Rent")
        }
        alertController.addAction(rentSelected)
        
        let transferSelected = UIAlertAction(title: "Transfer", style: .Default) { action in
            self.refreshCategoriesView("Transfer")
        }
        alertController.addAction(transferSelected)
        
        
        self.presentViewController(alertController, animated: true){}
    }
    
    func addDoneButtonToKeyboard(){
        //Add done button to numeric pad keyboard
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(onDoneButtonPressed))
        toolbarDone.items = [barBtnDone] // You can even add cancel button too
        expenseText.inputAccessoryView = toolbarDone
    }
    
    func onDoneButtonPressed(){
        guard expenseText.text != "" else { dismissKeyboard(); return }
        addExpense()
        
    }
    
    func addExpense(){
        if let value = Int(expenseText.text!){
            let date = NSDate()
            expenseToPersist[expenseToPersist.keyExpense()] = value
            expenseToPersist[expenseToPersist.keyDate()] = date
            let initialSectionsCount = dbmanager.getDateSections().count
            dbmanager.persistExpense(expenseToPersist)
            expenseText.text = ""
            if dbmanager.getDateSections().count != initialSectionsCount{
                tableView.reloadData()
            }
            let range = NSMakeRange(0, dbmanager.getDateSections().count)
            let sections = NSIndexSet(indexesInRange: range)
            self.tableView.reloadSections(sections, withRowAnimation: .Automatic)
        }else{
            //enter edit mode if textfield is empty
            expenseText.becomeFirstResponder()
        }
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dbmanager.getDateSections().count
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
//        return expense.count
        let sections = dbmanager.getDateSections()
        return dbmanager.getExpensesForSection(sections[section]).count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ExpenseTableCell = self.tableView.dequeueReusableCellWithIdentifier(ExpenseTableCell.reuseIdentifier(), forIndexPath: indexPath) as! ExpenseTableCell
        //get one section at a time
        let sections = dbmanager.getDateSections()
        let expensesForSection = dbmanager.getExpensesForSection(sections[indexPath.section])
        let expenseItem = expensesForSection[indexPath.row]
        cellConfigurator.configure(expenseItem, cell: cell)
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionRaw = dbmanager.getDateSections()[section]
        let date = dateFormatter.getDateForSection(sectionRaw)
        return dateFormatter.getHeaderTitleFromDate(date!)
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
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .Normal, title: "More") { action, index in
            print("more button tapped")
        }
        more.backgroundColor = Constants.blueColor
        let delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
            let section = self.dbmanager.getDateSections()[indexPath.section]
            self.dbmanager.deleteMyExpense(indexPath)
            //don't animate if there's no more item under a section
            guard self.dbmanager.getExpensesForSection(section).count > 0 else { tableView.reloadData(); return }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            print("delete button tapped")
        }
        delete.backgroundColor = Constants.redColor
        return [delete, more]
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
}
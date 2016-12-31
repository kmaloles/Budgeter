//
//  ExpenseTableCell
//  budgeter
//
//  Created by Kevin Maloles on 26/12/2016.
//  Copyright © 2016 KAM. All rights reserved.
//

import Foundation
import UIKit

class ExpenseTableCell : UITableViewCell{

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var expenseCell: UITextField!
    
}

class ExpenseCellConfigurator {
    
    let dateFormatter = DateFormatter.sharedInstance
    
    func configure(expenseItem: Expense, cell: ExpenseTableCell){
        cell.expenseCell.text = "PHP " + String(expenseItem.expense)
        let date = expenseItem.date
        
        let isToday = dateFormatter.isDateToday(date)
        if isToday {
            cell.dateLabel.hidden = true
            cell.dayLabel.text = "Today"
        } else {
            cell.dateLabel.hidden = false
            cell.dayLabel.text = dateFormatter.getDayOfWeekFromDate(date).uppercaseString
            cell.dateLabel.text = dateFormatter.getDayOfMonthFromDate(date)
        }
        cell.timeLabel.text = dateFormatter.getTimeOfDayFromDate(date)
        
    }
}
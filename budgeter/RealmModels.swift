//
//  RealmModels.swift
//  budgeter
//
//  Created by Kevin Maloles on 30/12/2016.
//  Copyright © 2016 KAM. All rights reserved.
//

import Foundation
import RealmSwift

class Expense: Object {
    dynamic var id = ""
    dynamic var expense = 0
    dynamic var date = NSDate()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

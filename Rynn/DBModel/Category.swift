//
//  Category.swift
//  Rynn
//
//  Created by Govind Rakholiya on 10/10/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit

class Category {
    var categoryId : Int  = 0
    var categoryName : String   = ""
}


class expense : NSObject {
    
    static let sharedExpense = expense()
    var expenseAmount : String  = ""
    var expenseType   : String  = ""
    var expenseDate   : String  = ""
    var eID   : Int  = 0
    var rID   : Int  = 0
    var expenseCategoryName : String = ""
    var expenseCategoryId : Int = 0
    var expenseTitle : String = ""
    var isexpense : String = ""
    var id : Int = 0
}

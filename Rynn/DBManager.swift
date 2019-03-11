//
//  DBManager.swift
//  Rynn
//
//  Created by Govind Rakholiya on 09/10/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit

class DBManager: NSObject {

    typealias completionBlock = (_ sucess : Bool) -> Void
    typealias rIDBlock = (_ sucess : Bool,_ rID : Int) -> Void
    static let shared: DBManager = DBManager()
    
    var databaseFileName = "Rynn.db"
    
    var pathToDatabase: String!
    
    var database: FMDatabase!
    
    //MARK:-  Table Name
    
    let table_Expense = "expense"
    let table_Category = "category"
    let table_Expense_Recurrence = "expenseRecurrence"
    
    //MARK:-  expense Table Fields
    let userId = "userId"
    let id = "id"
    let expenseId = "expenseId"
    let expenseDaTe = "expenseDate"
    let expenseAmount = "expenseAmount"
    let categoryId = "categoryId"
    let categoryName = "categoryName"
    let categoryType = "categoryType" // 1 = earninng 2 = expense
    
    let expenseType = "expenseType"
    let expenseTitle = "expenseTitle"
    let isexpense = "isexpense"
    
    //MARK:-  expense Recurrence Table Fields
    let eId = "eId"
    let rId = "rId"
    
    //MARK:-  Category Table Fields
    let tblCategoryId   = "categoryId"
    let tblCategoryName = "categoryName"
   
    
    override init() {
        super.init()
        
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    func copyDatabase() -> Bool {
        var created = false
         print("DB Path : \(pathToDatabase)")
        
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {

            let fileManager = FileManager.default
            if let dbFilePath = Bundle.main.path(forResource: "Rynn", ofType: "db") {
                
                do {
                    try fileManager.copyItem(atPath: dbFilePath, toPath: pathToDatabase)
                    database = FMDatabase(path: pathToDatabase!)
                    created = true
                }
                catch {
                    created = false
                    print("Could not create table.")
                    print(error.localizedDescription)
                }
                
                
            } else {
                print("Uh oh - foo.db is not in the app bundle")
            }
        }
        else{
            created = true

        }
        
        return created
    }
    
    
    
    func copyDatabaseFromServer(sourcePath : String) -> Bool {
        
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent("Rynn.db")
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: sourcePath)
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url:fileURL!)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                    do{
                        try FileManager.default.removeItem(at: destinationFileUrl)
                    }catch{
                        
                    }
                
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    do {
                        
                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    } catch (let writeError) {
                        print("Error creating a file \(self.pathToDatabase) : \(writeError)")
                    }
                    
//                })
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
            }
        }
        task.resume()
        return true

    }
    
    
    
    func getDatabase() -> Data {
        var created = false
        print("DB Path : \(pathToDatabase)")
        
            var data2: Data = Data()
       let fileManager = FileManager.default
            if let dbFilePath = Bundle.main.path(forResource: "Rynn", ofType: "db") {
                
                do {
                    
                    
                        data2 = try NSData.init(contentsOf: URL.init(fileURLWithPath: pathToDatabase, isDirectory: true)) as Data

                }
                catch {
                    created = false
                    print("Could not create table.")
                    print(error.localizedDescription)
                }
                
                return data2
            } else {
                print("Uh oh - foo.db is not in the app bundle")
                return data2
            }
       
        
       
    }
    
    func openDatabase() -> Bool {
        
        
        
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    
    func loadAllCategories() -> [Category]  {
        var categoryArray: [Category] = [Category]()
        
        if openDatabase() {
            let query = "select * from \(table_Category) order by \(categoryId) asc"
            
            // print(query)
            do {
                print(database)
                let results = try database.executeQuery(query, values: nil)
                //                print(results)
                //
                
                while results.next() {
                    let categoryObj = Category()
                    categoryObj.categoryId = Int(results.int(forColumn: categoryId))
                    categoryObj.categoryName = results.string(forColumn: categoryName)!
                    
                    
                    if categoryArray == nil {
                        categoryArray = [Category]()
                    }
                    
                    categoryArray.append(categoryObj)
                }
                //                print(categoryArray)
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return categoryArray
    }
    
    
    func loadCategories(categorytypeObj : String) -> [Category]  {
        var categoryArray: [Category] = [Category]()
        
        if openDatabase() {
            let query = "select * from \(table_Category) where \(categoryType) = '\(categorytypeObj)' order by \(categoryId) asc"
            
           // print(query)
            do {
                print(database)
                let results = try database.executeQuery(query, values: nil)
//                print(results)
//
               
                while results.next() {
                    let categoryObj = Category()
                    categoryObj.categoryId = Int(results.int(forColumn: categoryId))
                    categoryObj.categoryName = results.string(forColumn: categoryName)!

                    
                    if categoryArray == nil {
                        categoryArray = [Category]()
                    }
                    
                    categoryArray.append(categoryObj)
                }
//                print(categoryArray)
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return categoryArray
    }
    
    
    
    func loadExpenseDateWise(strDate : String) -> [expense]  {
        var expenseArray: [expense] = [expense]()
        
//        let userIdGet = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.User_Id) ?? 0
//        let query = "select * from \(table_Expense_Recurrence) where \(userId) = \(userIdGet) order by \(id) desc"
        
        if openDatabase() {
            let userIdGet = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.User_Id) ?? 0
            let query = "select * from \(table_Expense) where \(expenseDaTe) = '\(strDate)' and  \(userId) = \(userIdGet) order by \(id) desc"
            print(query)
            do {
//                print(database)
                let results = try database.executeQuery(query, values: nil)
//                                print(results)
                //
                
                while results.next() {
                    let expenseObj = expense()
                    expenseObj.expenseAmount = results.string(forColumn: expenseAmount)!
                    expenseObj.expenseType = results.string(forColumn: expenseType)!
                    expenseObj.expenseTitle = results.string(forColumn: expenseTitle)!
                    expenseObj.expenseCategoryName = results.string(forColumn: categoryName)!
                    expenseObj.expenseCategoryId = Int(results.int(forColumn: categoryId))
                    
                    expenseObj.id = Int(results.int(forColumn: id))
                    expenseObj.expenseDate = results.string(forColumn: expenseDaTe)!
                    expenseObj.isexpense = results.string(forColumn: isexpense)!
                    
                    
                    if expenseArray == nil {
                        expenseArray = [expense]()
                    }
                    
                    expenseArray.append(expenseObj)
                }
                //                print(categoryArray)
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
//        print(expenseArray.count)
        return expenseArray
    }
    
    
    
    func loadExpense() -> [expense]  {
        var expenseArray: [expense] = [expense]()
        
        if openDatabase() {
            let userIdGet = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.User_Id) ?? 0
            let query = "select * from \(table_Expense_Recurrence) where \(userId) = \(userIdGet) order by \(id) desc"
            print(query)
            do {
                print(database)
                let results = try database.executeQuery(query, values: nil)
                //                print(results)
                //
                
                while results.next() {
                    let expenseObj = expense()
                    expenseObj.expenseAmount = results.string(forColumn: expenseAmount)!
                    expenseObj.expenseType = results.string(forColumn: expenseType)!
                    expenseObj.expenseTitle = results.string(forColumn: expenseTitle)!
                    expenseObj.expenseCategoryName = results.string(forColumn: categoryName)!
                    expenseObj.expenseCategoryId = Int(results.int(forColumn: categoryId))
                    
                    expenseObj.id = Int(results.int(forColumn: id))
                    expenseObj.expenseDate = results.string(forColumn: expenseDaTe)!
                    expenseObj.isexpense = results.string(forColumn: isexpense)!
                    
                    
                    if expenseArray == nil {
                        expenseArray = [expense]()
                    }
                    
                    expenseArray.append(expenseObj)
                }
                //                print(categoryArray)
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return expenseArray
    }
    
    
    
    
    func loadExpenseForCount() -> [expense]  {
        var expenseArray: [expense] = [expense]()
        
        if openDatabase() {
            let userIdGet = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.User_Id) ?? 0
            let query = "select * from \(table_Expense) where \(userId) = \(userIdGet) order by \(id) desc"
            print(query)
            do {
                print(database)
                let results = try database.executeQuery(query, values: nil)
                //                print(results)
                //
                
                while results.next() {
                    let expenseObj = expense()
                    expenseObj.expenseAmount = results.string(forColumn: expenseAmount)!
                    expenseObj.expenseType = results.string(forColumn: expenseType)!
                    expenseObj.expenseTitle = results.string(forColumn: expenseTitle)!
                    expenseObj.expenseCategoryName = results.string(forColumn: categoryName)!
                    expenseObj.rID = Int(results.int(forColumn: rId))
                    expenseObj.expenseCategoryId = Int(results.int(forColumn: categoryId))
                    expenseObj.expenseDate = results.string(forColumn: expenseDaTe)!
                    expenseObj.isexpense = results.string(forColumn: isexpense)!
                    
                    
                    if expenseArray == nil {
                        expenseArray = [expense]()
                    }
                    
                    expenseArray.append(expenseObj)
                }
                //                print(categoryArray)
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return expenseArray
    }

    
    
    
    
    func deleteExpense(expenseIdChoosen : Int,onsucess :  @escaping (completionBlock))  {
        
        if openDatabase() {
            let userIdGet = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.User_Id) ?? 0
            let query = "DELETE FROM \(table_Expense) where \(rId) = \(expenseIdChoosen)"
            
            let query1 = "DELETE FROM \(table_Expense_Recurrence) where \(id) = \(expenseIdChoosen)"
            
            print(query)
            do {
                print(database)
                
                if !database.executeStatements(query) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                    onsucess(false)
                }
                else{
                    database.executeStatements(query1)
                    onsucess(true)
                }
                
                //                let results = try database.executeQuery(query, values: nil)
                //                print(results)
                //
                
                //                print(categoryArray)
            }
            catch {
                print(error.localizedDescription)
                onsucess(false)
            }
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    func clearExpenseTable(onsucess :  @escaping (completionBlock))  {
      
        if openDatabase() {
            let userIdGet = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.User_Id) ?? 0
            let query = "DELETE FROM \(table_Expense) where \(userId) = \(userIdGet)"
            
            let query1 = "DELETE FROM \(table_Expense_Recurrence) where \(userId) = \(userIdGet)"
            
            print(query)
            do {
                print(database)
                
                if !database.executeStatements(query) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                    onsucess(false)
                }
                else{
                    database.executeStatements(query1)
                    onsucess(true)
                }
                
//                let results = try database.executeQuery(query, values: nil)
                //                print(results)
                //
                
                //                print(categoryArray)
            }
            catch {
                print(error.localizedDescription)
                onsucess(false)
            }
            
           
        }
        
     
    }
    
    

    func AddCategory(categoryName : String,categoryType:String,onsucess :  @escaping (completionBlock)) {
       
        
        if (self.openDatabase()){
            let InsertQry = "insert into \(DBManager.shared.table_Category) (\(DBManager.shared.categoryName),\(DBManager.shared.categoryType)) values ('\(categoryName)','\(categoryType)')"
            
            print(InsertQry)
            
            do {
                print(database)
                
                let results = try database.executeQuery(InsertQry, values: nil)
                
                if !database.executeStatements(InsertQry) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                    onsucess(false)
                }
                else{
                    onsucess(true)
                }
                print(results)
                
            }
            catch {
                onsucess(false)
                print(error.localizedDescription)
            }
            
 
            database.close()
        }
        
    }
    
    
    
    
    func AddExpenseRecurrence(ExpenseObj : expense,onsucess :  @escaping (rIDBlock)) {
        //        let id = "id"
        //        let expenseId = "expenseId"
        //        let expenseDaTe = "expenseDate"
        //        let expenseAmount = "expenseAmount"
        //        let categoryId = "categoryId"
        //        let categoryName = "categoryName"
        //        let expenseType = "expenseType"
        //        let isexpense = "isexpense"
        let userIdFor = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.User_Id)
        
        if (self.openDatabase()){
            let InsertQry = "insert into \(DBManager.shared.table_Expense_Recurrence) (\(DBManager.shared.expenseDaTe),\(DBManager.shared.eId),\(DBManager.shared.expenseTitle),\(DBManager.shared.expenseAmount),\(DBManager.shared.categoryId),\(DBManager.shared.categoryName),\(DBManager.shared.expenseType),\(DBManager.shared.isexpense),\(DBManager.shared.userId)) values ('\(ExpenseObj.expenseDate)','\(ExpenseObj.eID)','\(ExpenseObj.expenseTitle)','\(ExpenseObj.expenseAmount)','\(ExpenseObj.expenseCategoryId)','\(ExpenseObj.expenseCategoryName)','\(ExpenseObj.expenseType)','\(ExpenseObj.isexpense)','\(userIdFor ?? 0)')"
            
                        print(InsertQry)
            
            do {
                print(database)
                
                let results = try database.executeQuery(InsertQry, values: nil)
                
                if !database.executeStatements(InsertQry) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                    
                    var lastId: Int = Int(database.lastInsertRowId)
                    print(lastId)
                    onsucess(false, lastId)
                }
                else{
                   
                     var lastId: Int = Int(database.lastInsertRowId)
                     print(lastId)
                    onsucess(true, lastId)
                }
                print(results)
                
            }
            catch {
                onsucess(false, 0)
                print(error.localizedDescription)
            }
            
            
            database.close()
        }
        
    }
    
    
    
    func AddExpense(ExpenseObj : expense,onsucess :  @escaping (completionBlock)) {
//        let id = "id"
//        let expenseId = "expenseId"
//        let expenseDaTe = "expenseDate"
//        let expenseAmount = "expenseAmount"
//        let categoryId = "categoryId"
//        let categoryName = "categoryName"
//        let expenseType = "expenseType"
//        let isexpense = "isexpense"
         let userIdFor = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.User_Id)
        
        if (self.openDatabase()){
            let InsertQry = "insert into \(DBManager.shared.table_Expense) (\(DBManager.shared.expenseDaTe),\(DBManager.shared.expenseTitle),\(DBManager.shared.expenseAmount),\(DBManager.shared.categoryId),\(DBManager.shared.categoryName),\(DBManager.shared.expenseType),\(DBManager.shared.isexpense),\(DBManager.shared.userId),\(DBManager.shared.rId)) values ('\(ExpenseObj.expenseDate)','\(ExpenseObj.expenseTitle)','\(ExpenseObj.expenseAmount)','\(ExpenseObj.expenseCategoryId)','\(ExpenseObj.expenseCategoryName)','\(ExpenseObj.expenseType)','\(ExpenseObj.isexpense)','\(userIdFor ?? 0)','\(ExpenseObj.rID)')"
            
//            print(InsertQry)
            
            do {
                print(database)
                
                let results = try database.executeQuery(InsertQry, values: nil)
                
                if !database.executeStatements(InsertQry) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                    onsucess(false)
                }
                else{
                    onsucess(true)
                }
                print(results)
                
            }
            catch {
                onsucess(false)
                print(error.localizedDescription)
            }
            
            
            database.close()
        }
        
    }
}

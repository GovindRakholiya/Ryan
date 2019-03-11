//
//  AddExpenseViewController.swift
//  Rynn
//
//  Created by Govind Rakholiya on 17/09/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit
import DropDown


class AddExpenseViewController: UIViewController,selectCategoryDelegate,UITextFieldDelegate,selectRecurrenceCycleDelegate {
    
    
    @IBOutlet weak var viewOutsideHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewAddCategoryHeight: NSLayoutConstraint!
    @IBOutlet weak var viewAddCategory: UIView!
    @IBOutlet weak var lblRecurrenceCycle: UILabel!
    @IBOutlet weak var lblRecurrenceDuration: UILabel!
    @IBOutlet weak var lblAddExpenseHeaderTitle: UILabel!
    
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblExpenseType: UILabel!
    @IBOutlet weak var btnExpenseDuration: UIButton!
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var viewOutside: UIView!
    @IBOutlet weak var viewEnterValue: UIView!
    
    var selectedDateForExpenseOrEarning : Date = Date()
    
     let datePicker: UIDatePicker = UIDatePicker()
    var selectedCategoryId : Int = 0
    var selectedExpenseType : String = "One Time"
    var selectedRecurrenceCycle : Int = 1
    var expenseTypeArray : [String] = ["One Time","Weekly","Monthly","Yearly"]
    var expenseTypeDD : DropDown = DropDown()
    var isexpense : Bool = true
    
    var monthCount  : Int = 1
    var yearCount   : Int = 1
    var dayCount    : Int = 1
    var weekCount   : Int = 1
    
    var expenseModelObj = expense()
    
    //MARK:-  View Life Cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       txtDate.text = Date().string(format: "MM-dd-yyyy")
        selectedDateForExpenseOrEarning = Date ()
        
        
        // Posiiton date picket within a view
        datePicker.frame = CGRect(x: 10, y: self.view.frame.height - 280, width: self.view.frame.width, height: 200)
        
        // Set some of UIDatePicker properties
        //        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = .date
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
        
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        txtDate.inputView = datePicker
        txtDate.inputAccessoryView = toolBar
        
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissPicker() {

        view.endEditing(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        DBManager.shared.loadCategories()
        if (isexpense == true){
            lblAddExpenseHeaderTitle.text = "ADD EXPENSE"
            expenseTypeArray  = ["One Time","Weekly","Monthly","Yearly"]
//            viewAddCategory.isHidden = true
//            viewAddCategoryHeight.constant = 0
//            viewOutsideHeight.constant = 310
            viewAddCategory.isHidden = false
            viewAddCategoryHeight.constant = 70
            viewOutsideHeight.constant = 380
            
        }else{
            viewAddCategory.isHidden = false
            expenseTypeArray  = ["One Time","Weekly","Bi-Weekly","Monthly","Yearly"]
            lblAddExpenseHeaderTitle.text = "ADD EARNING"
            viewAddCategoryHeight.constant = 70
            viewOutsideHeight.constant = 380
        }
    }
    
    override func viewDidLayoutSubviews() {
        Singleton.sharedSingleton.setCornerRadius(view: viewOutside, radius: 5.0)
        
        viewEnterValue.layer.borderWidth = 1.0
        
        viewEnterValue.layer.borderColor = UIColor.darkGray.cgColor
        Singleton.sharedSingleton.setCornerRadius(view: viewEnterValue, radius: 2.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:-  Recurrence Delegate
    
    func recurrenceSelected(cycle: Int, type: String) {
        selectedExpenseType = type
        selectedRecurrenceCycle = cycle
        
        if (type == "One Time"){
            lblRecurrenceCycle.text = "\(cycle) Days"
        }else{
            lblRecurrenceCycle.text = "\(cycle) \(type)"
        }
        
    }
    
    //MARK:-  Custom Delegate
    func categorySelected(categoryId: Int, categoryName: String) {
        self.view.endEditing(true)
        lblCategory.text = categoryName
        selectedCategoryId = categoryId
        
    }
    @IBAction func btnBackPressed(_ sender: Any) {
        self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
        
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnRecurrenceSettingPressed(_ sender: Any) {
        guard selectedExpenseType != "" else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: "Please Select Duration (How often?) First")
            return
        }
//        guard selectedExpenseType != "Daily" else {
//           
//            return
//        }
        let recurrenceVc = RecurrenceCycleViewController(nibName: "RecurrenceCycleViewController", bundle: nil)
        recurrenceVc.recurrenceTypeSelected = selectedExpenseType
        recurrenceVc.recurrenceDelegate = self
        self.navigationController?.pushViewController(recurrenceVc, animated: false)
    }
    
    //MARK:-  Add Expense/Earning Pressed
    @IBAction func btnRightClickPressed(_ sender: Any) {
        
      
        
        let strAmount = txtValue.text!.trimmingCharacters(in: .whitespaces)
        
        let strDate = txtDate.text!.trimmingCharacters(in: .whitespaces)
        
        let strTitle = txtTitle.text!.trimmingCharacters(in: .whitespaces)
        
        guard strAmount.count > 0 else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.OtherAlerts.NO_AMOUNT)
            return
        }
        
        if let value = strAmount.double  {
            print(value) 
            // "2.9\n"
            
            if value == 0 {
                Singleton.sharedSingleton.showWarningAlert(withMsg: "Please Enter Value greater than 0")
                return
            }
        } else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: "Please Enter Proper value")
            return
        }
        
        guard strTitle.count > 0 else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.OtherAlerts.NO_TITLE)
            return
        }
        guard selectedExpenseType != "" else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.OtherAlerts.NO_EXPENSE_TYPE)
            return
        }
//        guard selectedCategoryId != nil else {
//            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.OtherAlerts.NO_CATEGORY)
//            return
//        }
        guard strDate.count > 0 else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.OtherAlerts.NO_DATE)
            return
        }
        
        var isezpenseString : String = ""
        if (isexpense == true){
            isezpenseString = "1"
        }else{
            isezpenseString = "0"
        }
        expenseModelObj.expenseAmount = strAmount
        expenseModelObj.expenseCategoryId = selectedCategoryId
        expenseModelObj.expenseCategoryName = lblCategory.text!
        expenseModelObj.expenseDate = strDate
        expenseModelObj.expenseTitle = strTitle
        expenseModelObj.expenseType = selectedExpenseType
        expenseModelObj.isexpense = isezpenseString
        
        let amount = Int(strAmount)
        if (amount == 0){
         Singleton.sharedSingleton.showWarningAlert(withMsg: "You can not add 0 amount")
            return
        }
        
        DBManager.shared.AddExpenseRecurrence(ExpenseObj: expenseModelObj) { (isSucess, rID) in
            if (isSucess){
                self.expenseModelObj.rID = rID
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                if (self.selectedExpenseType == "One Time"){
                    let totalDays = self.selectedRecurrenceCycle * 1
                    var totalCost = Float(strAmount)! / Float(1)
                    
                    
                    var dayComponent = DateComponents()
                    
                    
                    for i in 0...totalDays {
                        print(i)
                        
//                        if (i == 1){
//                            dayComponent.day = 0
//                        }else{
//                            dayComponent.day = i
//                        }
                        
                        if (i == totalDays){
                            self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                            
                            self.navigationController?.popViewController(animated: false)
                            
                            return
                            
                            
                        }
                        
                        
                        dayComponent.day = i
                        var theCalendar = Calendar.current
                        let nextDate = theCalendar.date(byAdding: dayComponent, to: self.selectedDateForExpenseOrEarning)
                        
                        if let aDate = nextDate {
                            //                    let changedDate = aDate.string(with: "MM-dd-yyyy HH:mm")
                            let changedDate = aDate.string(with: "MM-dd-yyyy")
                            print(changedDate)
                            print("nextDate: \(aDate) ...")
                            
                            print(totalCost.description)
                            self.expenseModelObj.expenseDate = changedDate.description
                            self.expenseModelObj.expenseAmount = totalCost.description
                            DBManager.shared.AddExpense(ExpenseObj: self.expenseModelObj) { (issuccess) in
                                if (issuccess){
                                    if (i == totalDays){
                                        self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                                        
                                        self.navigationController?.popViewController(animated: false)
                                        
                                    }
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                    print(totalDays)
                    print(totalCost)
                }
                
                
                if (self.selectedExpenseType == "Monthly"){
                    let totalDays = self.selectedRecurrenceCycle * 30
                    var totalCost = Float(strAmount)! / Float(30)
                    
                    
                    var dayComponent = DateComponents()
                    
                    
                    for i in 0...totalDays {
                        print(i)
                        if (i == totalDays){
                            self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                            
                            self.navigationController?.popViewController(animated: false)
                            return
                            
                        }
                        
//                        if (i == 1){
//                            dayComponent.day = 0
//                        }else{
//                            dayComponent.day = i
//                        }
                        dayComponent.day = i
                        var theCalendar = Calendar.current
                        var nextDate = theCalendar.date(byAdding: dayComponent, to: self.selectedDateForExpenseOrEarning)
                        
                        if let aDate = nextDate {
                            //                    let changedDate = aDate.string(with: "MM-dd-yyyy HH:mm")
                            let changedDate = aDate.string(with: "MM-dd-yyyy")
                            print(changedDate)
                            print("nextDate: \(aDate) ...")
                            
                            self.expenseModelObj.expenseDate = changedDate.description
                            self.expenseModelObj.expenseAmount = totalCost.description
                            DBManager.shared.AddExpense(ExpenseObj: self.expenseModelObj) { (issuccess) in
                                if (issuccess){
                                    if (i == totalDays){
                                        self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                                        
                                        self.navigationController?.popViewController(animated: false)
                                        
                                    }
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                    print(totalDays)
                    print(totalCost)
                }else if (self.selectedExpenseType == "Weekly"){
                    let totalDays = self.selectedRecurrenceCycle * 7
                    var totalCost = Float(strAmount)! / Float(7)
                    
                    
                    var dayComponent = DateComponents()
                    
                    
                    for i in 0...totalDays {
                        print(i)
                        
                        if (i == totalDays){
                            self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                            
                            self.navigationController?.popViewController(animated: false)
                            return
                            
                        }
                        
//                        if (i == 1){
//                            dayComponent.day = 0
//                        }else{
//                            dayComponent.day = i
//                        }
                        dayComponent.day = i
                        var theCalendar = Calendar.current
                        var nextDate = theCalendar.date(byAdding: dayComponent, to: self.selectedDateForExpenseOrEarning)
                        
                        if let aDate = nextDate {
                            //                    let changedDate = aDate.string(with: "MM-dd-yyyy HH:mm")
                            let changedDate = aDate.string(with: "MM-dd-yyyy")
                            print(changedDate)
                            print("nextDate: \(aDate) ...")
                            
                            self.self.expenseModelObj.expenseDate = changedDate.description
                            self.expenseModelObj.expenseAmount = totalCost.description
                            DBManager.shared.AddExpense(ExpenseObj: self.expenseModelObj) { (issuccess) in
                                if (issuccess){
                                    if (i == totalDays){
                                        self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                                        
                                        self.navigationController?.popViewController(animated: false)
                                        
                                    }
                                    //                            self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                                    //
                                    //                            self.navigationController?.popViewController(animated: false)
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                    print(totalDays)
                    print(totalCost)
                }else if (self.selectedExpenseType == "Bi-Weekly"){
                    let totalDays = self.selectedRecurrenceCycle * 14
                    var totalCost = Float(strAmount)! / Float(14)
                    
                    
                    var dayComponent = DateComponents()
                    
                    
                    for i in 0...totalDays {
                        print(i)
                        
                        if (i == totalDays){
                            self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                            
                            self.navigationController?.popViewController(animated: false)
                            return
                            
                        }
                        
                        //                        if (i == 1){
                        //                            dayComponent.day = 0
                        //                        }else{
                        //                            dayComponent.day = i
                        //                        }
                        dayComponent.day = i
                        var theCalendar = Calendar.current
                        var nextDate = theCalendar.date(byAdding: dayComponent, to: self.selectedDateForExpenseOrEarning)
                        
                        if let aDate = nextDate {
                            //                    let changedDate = aDate.string(with: "MM-dd-yyyy HH:mm")
                            let changedDate = aDate.string(with: "MM-dd-yyyy")
                            print(changedDate)
                            print("nextDate: \(aDate) ...")
                            
                            self.self.expenseModelObj.expenseDate = changedDate.description
                            self.expenseModelObj.expenseAmount = totalCost.description
                            DBManager.shared.AddExpense(ExpenseObj: self.expenseModelObj) { (issuccess) in
                                if (issuccess){
                                    if (i == totalDays){
                                        self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                                        
                                        self.navigationController?.popViewController(animated: false)
                                        
                                    }
                                    //                            self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                                    //
                                    //                            self.navigationController?.popViewController(animated: false)
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                    print(totalDays)
                    print(totalCost)
                }else if (self.selectedExpenseType == "Yearly"){
                    
                    let totalDays = self.selectedRecurrenceCycle * 365
                    var totalCost = Float(strAmount)! / Float(365)
                    
                    var dayComponent = DateComponents()
                    
                    
                    for i in 0...totalDays {
                        print(i)
                        if (i == totalDays){
                            self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                            
                            self.navigationController?.popViewController(animated: false)
                            return
                            
                        }
                        
//                        if (i == 1){
//                            dayComponent.day = 0
//                        }else{
//                            dayComponent.day = i
//                        }
                        dayComponent.day = i
                        var theCalendar = Calendar.current
                        var nextDate = theCalendar.date(byAdding: dayComponent, to: self.selectedDateForExpenseOrEarning)
                        
                        if let aDate = nextDate {
                            //                    let changedDate = aDate.string(with: "MM-dd-yyyy HH:mm")
                            let changedDate = aDate.string(with: "MM-dd-yyyy")
                            print(changedDate)
                            print("nextDate: \(aDate) ...")
                            
                            self.expenseModelObj.expenseDate = changedDate.description
                            self.expenseModelObj.expenseAmount = totalCost.description
                            DBManager.shared.AddExpense(ExpenseObj: self.expenseModelObj) { (issuccess) in
                                if (issuccess){
                                    if (i == totalDays){
                                        self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                                        
                                        self.navigationController?.popViewController(animated: false)
                                        
                                    }
                                    //                            self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                                    //
                                    //                            self.navigationController?.popViewController(animated: false)
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                    print(totalDays)
                    print(totalCost)
                }else if (self.selectedExpenseType == "Bi-Weekly"){
                    let totalDays = self.selectedRecurrenceCycle * 14
                    var totalCost = Float(strAmount)! / Float(14)
                    
                    
                    var dayComponent = DateComponents()
                    
                    
                    for i in 0...totalDays {
                        print(i)
                        print(totalDays)
                        if (i == totalDays){
                            self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                            
                            self.navigationController?.popViewController(animated: false)
                            return
                            
                        }
                        
//                        if (i == 1){
//                            dayComponent.day = 0
//                        }else{
//                            dayComponent.day = i
//                        }
                        dayComponent.day = i
                        var theCalendar = Calendar.current
                        var nextDate = theCalendar.date(byAdding: dayComponent, to: self.selectedDateForExpenseOrEarning)
                        
                        if let aDate = nextDate {
                            //                    let changedDate = aDate.string(with: "MM-dd-yyyy HH:mm")
                            let changedDate = aDate.string(with: "MM-dd-yyyy")
                            print(changedDate)
                            print("nextDate: \(aDate) ...")
                            
                            self.expenseModelObj.expenseDate = changedDate.description
                            self.expenseModelObj.expenseAmount = totalCost.description
                            DBManager.shared.AddExpense(ExpenseObj: self.expenseModelObj) { (issuccess) in
                                if (issuccess){
                                    if (i == totalDays){
                                        self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                                        
                                        self.navigationController?.popViewController(animated: false)
                                        
                                    }
                                    //                            self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
                                    //
                                    //                            self.navigationController?.popViewController(animated: false)
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                    print(totalDays)
                    print(totalCost)
                }
                
                
                
                
                
                
                
                
                
                
                
            }
        }
       
        
       
        
       
        
//        var dayComponent = DateComponents()
//        dayComponent.day = 1
//
//        var theCalendar = Calendar.current
//        var nextDate = theCalendar.date(byAdding: dayComponent, to: Date(), options: [])
//
//        if let aDate = nextDate {
//            print("nextDate: \(aDate) ...")
//        }
        
        
//
//        DBManager.shared.AddExpense(ExpenseObj: expenseModelObj) { (issuccess) in
//            if (issuccess){
//                self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromBottom(), forKey: kCATransition)
//
//                self.navigationController?.popViewController(animated: false)
//            }
//        }
    }
    
    
    
    
    @IBAction func btnSelectDurationPressed(_ sender: Any) {
        expenseTypeDD.dataSource = expenseTypeArray
        expenseTypeDD.anchorView = btnExpenseDuration
        expenseTypeDD.show()
        expenseTypeDD.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblExpenseType.text = item
            self.selectedExpenseType = item
            if (item == "Bi-Weekly"){
                self.selectedRecurrenceCycle = 1
            }
            if (item == "One Time"){
//                self.lblRecurrenceCycle.text = "10 Days"
                self.selectedRecurrenceCycle = 1
            }
            if (item == "Monthly"){
//                self.lblRecurrenceCycle.text = "12 Month"
                self.selectedRecurrenceCycle = 1
            }
            if (item == "Weekly"){
//                self.lblRecurrenceCycle.text = "4 Week"
                self.selectedRecurrenceCycle = 1
            }
            if (item == "Yearly"){
//                self.lblRecurrenceCycle.text = "5 Year"
                self.selectedRecurrenceCycle = 1
            }
            
        }
    }
    @IBAction func btnCategoryPressed(_ sender: Any) {
        let categoryVC = categoryListViewController(nibName: "categoryListViewController", bundle: nil)
        categoryVC.isComingFrom = "ADDEXPENSE"
        categoryVC.catdelegate = self
        categoryVC.isexpense = isexpense
        self.navigationController?.pushViewController(categoryVC, animated: false)
    }
    
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
//        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        // Apply date format
        selectedDateForExpenseOrEarning = sender.date
        let selectedDate: String = dateFormatter.string(from: sender.date)
        txtDate.text = selectedDate
        print("Selected value \(selectedDate)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:-  TextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 8
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    

}

//extension UIToolbar {
////
////    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
////
////        let toolBar = UIToolbar()
////
////        toolBar.barStyle = UIBarStyle.default
////        toolBar.isTranslucent = true
////        toolBar.tintColor = UIColor.black
////        toolBar.sizeToFit()
////
////        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
////        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
////
////        toolBar.setItems([ spaceButton, doneButton], animated: false)
////        toolBar.isUserInteractionEnabled = true
////
////        return toolBar
////    }
//
//}


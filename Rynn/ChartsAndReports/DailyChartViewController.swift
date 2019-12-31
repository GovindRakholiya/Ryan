//
//  DailyChartViewController.swift
//  BUILD
//
//  Created by Ishan Vyas on 11/04/19.
//  Copyright © 2019 Govind Rakholiya. All rights reserved.
//

import UIKit

class DailyChartViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var lblDataNotAvailble: UILabel!
    
    @IBOutlet weak var tblDailyChart: UITableView!
    var expenseArray = [expense]()
    var earnedArray = [expense]()
    var responseArray = [expense]()
    var todaysArray = [expense]()
    
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var lblSelectedDate: UILabel!
    let datePicker: UIDatePicker = UIDatePicker()
     var startDate : String = ""
    
    @IBOutlet weak var txtSelectedDate: UITextField!
    @IBOutlet weak var viewDate: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        
        setDatePicker()
        showTableViewAccordingSelectedDate()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
//        viewDate.layer.cornerRadius = 5.0
        Singleton.sharedSingleton.setCornerRadius(view: viewDate, radius: 5.0)
        Singleton.sharedSingleton.setShadow(to: viewDate)
        
        Singleton.sharedSingleton.setCornerRadius(view: btnSearch, radius: 5.0)
        Singleton.sharedSingleton.setShadow(to: btnSearch)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let nib = UINib(nibName: "DailyExpenseTableViewCell", bundle: nil)
        tblDailyChart.register(nib, forCellReuseIdentifier: "DailyExpenseTableViewCell")
    }
    
    @IBAction func btnBarChartPressed(_ sender: Any) {
        let barChartVC = BarChartReportViewController(nibName: "BarChartReportViewController", bundle: nil)
        self.add(barChartVC, frame: self.view.frame)
    }
    
    @IBAction func btnPieChartPressed(_ sender: Any) {
        let piechartVC = ChartsAndReportsViewController(nibName: "ChartsAndReportsViewController", bundle: nil)
        self.add(piechartVC, frame: self.view.frame)
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
   
    @IBAction func btnSearchPressed(_ sender: Any) {
        txtSelectedDate.resignFirstResponder()
        showTableViewAccordingSelectedDate()
    }
    
    func setDatePicker() {
        // Posiiton date picket within a view
        datePicker.frame = CGRect(x: 10, y: self.view.frame.height - 280, width: self.view.frame.width, height: 200)
        
        // Set some of UIDatePicker properties
        //        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = .date
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
        
        // Do any additional setup after loading the view.
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        txtSelectedDate.inputView = datePicker
        txtSelectedDate.inputAccessoryView = toolBar
        
        
        
        // Do any additional setup after loading the view.
        
        
    }
    
    
    @objc func dismissPicker() {
        
        view.endEditing(true)
        
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        
//        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.dateFormat = "EEEE d MMMM, yyyy"
        
        let selectedDate: String = dateFormatter.string(from: sender.date)
        startDate = selectedDate
        
        lblSelectedDate.text = selectedDate
        
        print("Selected value \(selectedDate)")
    }
    
    
    
    func showTableViewAccordingSelectedDate() {
//        lblTodaysDate.text = Date().string(format: "EEEE d MMMM, yyyy")
//        lblBudgetType.text = "Daily Budget"
        responseArray = DBManager.shared.loadExpenseForCount()
        expenseArray = [expense]()
        earnedArray  = [expense]()
        todaysArray = [expense]()
        for response in responseArray {
            let dateFormatter = DateFormatter()
            //            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm" //Your date format
            
            dateFormatter.dateFormat = "MM-dd-yyyy"
            
            //            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
            //according to date format your date string
            guard let date = dateFormatter.date(from: response.expenseDate) else {
                fatalError()
            }
            
            dateFormatter.dateFormat = "EEEE d MMMM, yyyy" //Your New Date format as per requirement change it own
            let newDate = dateFormatter.string(from: date) //pass Date here

            
//            let currentDate : String = Date().string(format: "EEEE d MMMM, yyyy")
            var currentDate : String = ""
            if (startDate == ""){
                currentDate = Date().string(format: "EEEE d MMMM, yyyy")
                lblSelectedDate.text = currentDate
            }else{
                currentDate  = startDate
            }
            
            
            if (currentDate == newDate){
                todaysArray.append(response)
            }
            
        }
        expenseArray = [expense]()
        
        for today in todaysArray{
            if (today.isexpense == "1"){
                expenseArray.append(today)
            }else{
                earnedArray.append(today)
            }
        }
        var expenseValueCount : Double = 0
        for expenseObject in expenseArray {
            
            let expenseValue = Double(expenseObject.expenseAmount)
            expenseValueCount = expenseValueCount + expenseValue!
            
        }
        
        var earnValueCount : Double = 0
        
        for expenseObject in earnedArray {
            
            let earnValue = Double(expenseObject.expenseAmount)
            earnValueCount = earnValueCount + earnValue!
            
        }
        let totalval = earnValueCount - expenseValueCount
//        btnDailyBudgetAmount.setTitle("$ \(String(format:"%.2f", totalval))", for: .normal)
//        Global.appDelegate.tabBarController.showTabBar()
        
        tblDailyChart.reloadData()
        
        
        
//        var track = ["Inc %","Exp %"]
//        var percentage : Double = (100 * expenseValueCount) / earnValueCount
//
//        var monthExpensePercentage : [Double] = [percentage]
//        if (expenseValueCount == 0) && (earnValueCount != 0){
//            track = ["100 % Saving","0 % Expense"]
//            monthExpensePercentage = [100,0]
//        }else if (earnValueCount == 0) && (expenseValueCount != 0){
//            track = ["0 % Saving","100 % Expense"]
//            monthExpensePercentage = [0,100]
//        }else if (earnValueCount == 0) && (expenseValueCount == 0){
//            track = ["0 % Saving","0 % Expense"]
//            monthExpensePercentage = [0,0]
//        }else if (percentage > 100){
//            track = ["0 % Saving","100 % Expense"]
//            monthExpensePercentage = [0,100]
//        }else if (percentage < 100){
//            let remainPercentage = 100 - percentage
//            track = ["\(String(format:"%.2f", remainPercentage)) % Saving","\(String(format:"%.2f", percentage)) % Expense"]
//            monthExpensePercentage = [remainPercentage,percentage]
//        }
//
//        print(track)
//        print(monthExpensePercentage)
//        updateChartData(track: track, money: monthExpensePercentage)
        
        
        
        
        //        let tracky = ["Earned", "Spent"]
        //        //        print(earnValueCount)
        //        //        print(expenseValueCount)
        //        let mone = [earnValueCount, expenseValueCount]
        //
        //        updateChartData(track: tracky, money: mone)
    }
    
    //MARk:-  Uitableview Datasource Delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DailyExpenseTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "DailyExpenseTableViewCell") as? DailyExpenseTableViewCell)!
        if (indexPath.section == 0){
            if (earnedArray.count != 0){
                if let earningObj : expense = earnedArray[indexPath.row]{
                    cell.lblTitle.text = earningObj.expenseTitle
                    cell.lblCategory.text = earningObj.expenseCategoryName
                    
                    var floatEarningValue : Float = Float(earningObj.expenseAmount) ?? 0.0
                    cell.lblAmount.text = "$ \(String(format:"%.2f", floatEarningValue))"
                    
//                    cell.lblAmount.text = "$ \(earningObj.expenseAmount)"
                }
            }else{
                if let expenseObj : expense = expenseArray[indexPath.row]{
                    cell.lblTitle.text = expenseObj.expenseTitle
                    cell.lblCategory.text = expenseObj.expenseCategoryName
//                    cell.lblAmount.text = "$ \(expenseObj.expenseAmount)"
                    var floatExpenseValue : Float = Float(expenseObj.expenseAmount) ?? 0.0
                    cell.lblAmount.text = "$ \(String(format:"%.2f", floatExpenseValue))"
                }
            }
           
        }else{
            if let expenseObj : expense = expenseArray[indexPath.row]{
                cell.lblTitle.text = expenseObj.expenseTitle
                cell.lblCategory.text = expenseObj.expenseCategoryName
//                cell.lblAmount.text = "$ \(expenseObj.expenseAmount)"
                var floatExpenseValue : Float = Float(expenseObj.expenseAmount) ?? 0.0
                cell.lblAmount.text = "$ \(String(format:"%.2f", floatExpenseValue))"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (earnedArray.count == 0) && (expenseArray.count == 0){
            lblDataNotAvailble.isHidden = false
        }else{
            lblDataNotAvailble.isHidden = true
        }
        if (section == 0){
            if (earnedArray.count != 0){
                return earnedArray.count
            }else{
                return expenseArray.count
            }
            
        }else{
            return expenseArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (expenseArray.count != 0) && (earnedArray.count != 0){
            return 2
        }else if (expenseArray.count == 0) && (earnedArray.count != 0){
            return 1
        }else if (expenseArray.count != 0) && (earnedArray.count == 0){
            return 1
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myview : UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width - 40, height: 50.0))
        let lblRecent : UILabel = UILabel(frame: CGRect(x: 5.0, y: 0.0, width: UIScreen.main.bounds.size.width - 40, height: 50.0))
        lblRecent.textColor = UIColor.white
        
        let newview : UIView = UIView(frame: CGRect(x: 10.0, y: 0.0, width: (tableView.frame.size.width - 20), height: 49.0))
        if (section == 0){
            if (earnedArray.count != 0){
                lblRecent.text = "Earning"
                newview.backgroundColor = UIColor.init(red: 62.0/255.0, green: 188.0/255.0, blue: 165.0/255.0, alpha: 1.0)
            }else{
                lblRecent.text = "Expense"
                newview.backgroundColor = UIColor.init(red: 244.0/255.0, green: 121.0/255.0, blue: 29.0/255.0, alpha: 1.0)
            }
        }else{
            lblRecent.text = "Expense"
             newview.backgroundColor = UIColor.init(red: 244.0/255.0, green: 121.0/255.0, blue: 29.0/255.0, alpha: 1.0)
        }
       
        myview.backgroundColor = UIColor.clear
        Singleton.sharedSingleton.setCornerRadius(view: newview, radius: 5.0)
        myview.addSubview(newview)
       
        
        newview.addSubview(lblRecent)
        return myview
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

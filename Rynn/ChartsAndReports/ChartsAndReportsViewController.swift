//
//  ChartsAndReportsViewController.swift
//  Rynn
//
//  Created by Govind Rakholiya on 18/10/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit
import Charts

class ChartsAndReportsViewController: UIViewController {
    
    @IBOutlet weak var barChartScrollView: UIScrollView!
    @IBOutlet weak var pieChartScrollView: UIScrollView!
    @IBOutlet weak var btnChart: UIButton!
    @IBOutlet weak var viewBudgetAmount: UIView!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    var isFilter : Bool = false
    var startDate : String = ""
    var endDate : String = ""
    
    var startDateForComp : Date?
    var endDateForComp : Date?
    
    var selectedDateArray : [Date] = [Date]()
    
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
   
    let datePicker: UIDatePicker = UIDatePicker()
    let datePickerEndDate: UIDatePicker = UIDatePicker()
    
    @IBOutlet weak var txtStartDate: UITextField!
    
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var viewDateSelectionHeight: NSLayoutConstraint!
    @IBOutlet weak var viewDateSelection: UIView!
    @IBOutlet weak var lblBudgetType: UILabel!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var lblTodaysDate: UILabel!
    
    @IBOutlet weak var chartOfEarning: PieChartView!
    @IBOutlet weak var btnDailyBudgetAmount: UIButton!
    
    var expenseArray = [expense]()
    var earnedArray = [expense]()
    var responseArray = [expense]()
    var responseArrayForTable = [expense]()
    var todaysArray = [expense]()
    
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        DisplayData()
       setDatePicker()
        
        
    }
    
    @IBAction func btnChartPressed(_ sender: Any) {
        let barChartVC = BarChartReportViewController(nibName: "BarChartReportViewController", bundle: nil)
        self.add(barChartVC, frame: self.view.frame)
//        if (barChartScrollView.isHidden == true){
//            barChartScrollView.isHidden = false
//            pieChartScrollView.isHidden = true
//        }else{
//            barChartScrollView.isHidden = true
//            pieChartScrollView.isHidden = false
//        }
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
        
        
        
        // Posiiton date picket within a view
        datePickerEndDate.frame = CGRect(x: 10, y: self.view.frame.height - 280, width: self.view.frame.width, height: 200)
        
        // Set some of UIDatePicker properties
        //        datePicker.timeZone = NSTimeZone.local
        datePickerEndDate.backgroundColor = UIColor.white
        datePickerEndDate.datePickerMode = .date
        // Add an event to call onDidChangeDate function when value is changed.
        datePickerEndDate.addTarget(self, action: #selector(self.datePickerValueEndDateChanged(_:)), for: .valueChanged)
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        txtStartDate.inputView = datePicker
        txtStartDate.inputAccessoryView = toolBar
        
        let toolBarD = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        txtEndDate.inputView = datePickerEndDate
        txtEndDate.inputAccessoryView = toolBarD
        
        
        // Do any additional setup after loading the view.
        
        
    }
    
    @objc func dismissPicker() {
        
        view.endEditing(true)
        
    }
    
    
    //MARK:-  Left-Right Pressed 
    @IBAction func btnRightPressed(_ sender: Any) {
        if (currentIndex != 3){
            currentIndex = currentIndex + 1
            loadViewAsPerSwipe()
        }
    }
    
    @IBAction func btnLeftPressed(_ sender: Any) {
        
        if (currentIndex != 0){
            currentIndex = currentIndex - 1
            loadViewAsPerSwipe()
        }
    }
    
    //MARK:-  Start Date Selected
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        //        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        startDateForComp = sender.date
        // Apply date format
        //selectedDateForExpenseOrEarning = sender.date
        let selectedDate: String = dateFormatter.string(from: sender.date)
      startDate = selectedDate
        
            lblStartDate.text = selectedDate
        
        print("Selected value \(selectedDate)")
    }
    
    //MARK:-  Search Betwen Two Dates Pressed
    
    @IBAction func btnSearchBetweenTwoDatesPressed(_ sender: Any) {
        guard selectedDateArray.count > 0 else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: "Please Select Start and End Date Different")
            return
        }
        setDataBetweenTwoDates(dateArray: selectedDateArray)
        
    }
    
    //MARK:-  End Date Selected
    @objc func datePickerValueEndDateChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        //        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        dateFormatter.dateFormat = "MM-dd-yyyy"
        endDateForComp = sender.date
        
        // Apply date format
        //selectedDateForExpenseOrEarning = sender.date
        let selectedDate: String = dateFormatter.string(from: sender.date)
        if (startDate == ""){
            Singleton.sharedSingleton.showWarningAlert(withMsg: "Please Select Start Date")
            return
        }
        if (startDate > selectedDate){
            Singleton.sharedSingleton.showWarningAlert(withMsg: "Start Date can not be Older than End Date")
            return
        }

        lblEndDate.text = selectedDate
        endDate = selectedDate
        print("Selected value \(selectedDate)")
        
        selectedDateArray = Date().generateDatesArrayBetweenTwoDates(startDate: startDateForComp! , endDate: endDateForComp!)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Global.appDelegate.tabBarController.hideTabBar()
        
        viewDateSelectionHeight.constant = 0
        
        viewDateSelection.isHidden = true
        
        Singleton.sharedSingleton.setCornerRadius(view: viewBudgetAmount, radius: viewBudgetAmount.frame.size.height / 2)
//        print(newDate.string(format: "MM-dd-yyyy"))
//        print(Date().startOfMonth())
//        print(Date().endOfMonth())
    }
    
    override func viewDidLayoutSubviews() {
        Singleton.sharedSingleton.setCornerRadius(view: btnDailyBudgetAmount, radius: btnDailyBudgetAmount.frame.size.height / 2)
        Singleton.sharedSingleton.setCornerRadius(view: viewTop, radius: 5.0)
        Singleton.sharedSingleton.setShadow(to: viewTop)
    }
    
    func DisplayData() {
        
        showPieChart()
        addGestureForSwipe()
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    func addGestureForSwipe() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    //MARK:-  Change View On Swipe
    
    func loadViewAsPerSwipe() {
        if (currentIndex == 0){
            showPieChart()
        }else if (currentIndex == 1){
            let newDate = Date().startOfWeek
            let endDate = Date().endOfWeek
            
            let startDate = newDate?.string(format: "d MMMM, yyyy") ?? ""
            
            let stopDate = endDate?.string(format: "d MMMM, yyyy") ?? ""
            
            lblTodaysDate.text = "\(startDate) - \(stopDate)"
            
            getTheMonthlyData(startDate: newDate!)
        }
        else if (currentIndex == 2){
            let newDate = Date().startOfMonth()
            let endDate = Date().endOfMonth()
            
            lblTodaysDate.text = "\(newDate.string(format: "d MMMM, yyyy")) - \(endDate.string(format: "d MMMM, yyyy"))"
            
            getTheMonthlyData(startDate: newDate)
        }
        else if (currentIndex == 3){
//            let newDate = Date().st()
//            let endDate = Date().endOfMonth()
//
//            lblTodaysDate.text = "\(newDate.string(format: "d MMMM, yyyy")) - \(endDate.string(format: "d MMMM, yyyy"))"
//
//            getTheMonthlyData(startDate: newDate)
        }
    }
    
    //MARK:-  Gesture Recognizer methods
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                if (isFilter == false){
                    if (currentIndex != 0){
                        currentIndex = currentIndex - 1
                        loadViewAsPerSwipe()
                    }
                }
                
                
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                if (isFilter == false){
                    if (currentIndex != 3){
                        currentIndex = currentIndex + 1
                        loadViewAsPerSwipe()
                    }
                }
                
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
   
    @IBAction func btnFilterPressed(_ sender: Any) {
        if (viewDateSelectionHeight.constant == 160){
            viewDateSelectionHeight.constant = 0
            isFilter = false
            btnNext.isHidden = false
            btnPrev.isHidden = false
            viewDateSelection.isHidden = true
        }else{
            viewDateSelectionHeight.constant = 160
            isFilter = true
            btnNext.isHidden = true
            btnPrev.isHidden = true
            viewDateSelection.isHidden = false
        }
    }
    //MARK:-  Draw Pie Chart
    
    
    
    func showPieChart() {
        lblTodaysDate.text = Date().string(format: "EEEE d MMMM, yyyy")
        lblBudgetType.text = "Daily Budget"
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
            
            
            let currentDate : String = Date().string(format: "EEEE d MMMM, yyyy")
            print(currentDate)
            print(newDate)
            
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
        btnDailyBudgetAmount.setTitle("$ \(String(format:"%.2f", totalval))", for: .normal)
        Global.appDelegate.tabBarController.showTabBar()
        
        
        
        
        
        var track = ["Inc %","Exp %"]
        var percentage : Double = (100 * expenseValueCount) / earnValueCount
        
        var monthExpensePercentage : [Double] = [percentage]
        if (expenseValueCount == 0) && (earnValueCount != 0){
            track = ["100 % Saving","0 % Expense"]
            monthExpensePercentage = [100,0]
        }else if (earnValueCount == 0) && (expenseValueCount != 0){
            track = ["0 % Saving","100 % Expense"]
            monthExpensePercentage = [0,100]
        }else if (earnValueCount == 0) && (expenseValueCount == 0){
            track = ["0 % Saving","0 % Expense"]
            monthExpensePercentage = [0,0]
        }else if (percentage > 100){
            track = ["0 % Saving","100 % Expense"]
            monthExpensePercentage = [0,100]
        }else if (percentage < 100){
            let remainPercentage = 100 - percentage
            track = ["\(String(format:"%.2f", remainPercentage)) % Saving","\(String(format:"%.2f", percentage)) % Expense"]
            monthExpensePercentage = [remainPercentage,percentage]
        }
        
        print(track)
        print(monthExpensePercentage)
        updateChartData(track: track, money: monthExpensePercentage)
        
        
        
        
//        let tracky = ["Earned", "Spent"]
//        //        print(earnValueCount)
//        //        print(expenseValueCount)
//        let mone = [earnValueCount, expenseValueCount]
//
//        updateChartData(track: tracky, money: mone)
    }
    
    
    
    func updateChartData( track : [String], money : [Double])  {
        
        
        // 2. generate chart data entries
        
        
        var entries = [PieChartDataEntry]()
        for (index, value) in money.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = value
            entry.label = track[index]
            entries.append( entry)
        }
        
        // 3. chart setup
        let set = PieChartDataSet( values: entries, label: "")
        // this is custom extension method. Download the code for more details.
        set.selectionShift = 0
        
        set.drawValuesEnabled = false
        chartOfEarning.drawEntryLabelsEnabled = false
        
        var colors: [UIColor] = []
        colors.append(UIColor(red: 62.0/255.0, green: 188.0/255.0, blue: 165.0/255.0, alpha: 1.0))
        
        colors.append(UIColor(red: 244.0/255.0, green: 121.0/255.0, blue: 30.0/255.0, alpha: 1.0))
        
        set.colors = colors
        let data = PieChartData(dataSet: set)
        chartOfEarning.data = data
        chartOfEarning.noDataText = "No data available"
        // user interaction
        chartOfEarning.isUserInteractionEnabled = true
        chartOfEarning.chartDescription?.text = ""
        chartOfEarning.centerText = ""
        //        let d = Description()
        //        d.text = "iOSCharts.io"
        //        chartOfEarning.chartDescription = d
        
        //        chartOfEarning.centerText = "Pie Chart"
        chartOfEarning.holeRadiusPercent = 0.5
        chartOfEarning.transparentCircleColor = UIColor.clear
        
    }
    
    
    //MARK:-  Display Chart Between Two Dates
    
    func setDataBetweenTwoDates(dateArray : [Date]) {
        lblBudgetType.text = "Budget"
        lblTodaysDate.text = "\(lblStartDate.text ?? "") - \(lblEndDate.text ?? "")"
        var expenseArrayBetweenTwoDates : [expense] = [expense]()
        
        for aDate in selectedDateArray {
           
            let changedDate = aDate.string(with: "MM-dd-yyyy")
 
                let expensedData : [expense] = DBManager.shared.loadExpenseDateWise(strDate: changedDate)

                for exp in expensedData{
                    expenseArrayBetweenTwoDates.append(exp)
                }
    
        }
        showMonthlyChart(mothlyExpense: expenseArrayBetweenTwoDates)
    }
    //MARK:-  Get The Monthly Data
    func getTheMonthlyData(startDate : Date){
        
        
        var dayComponent = DateComponents()
        var expenseArrayCheck : [expense] = [expense]()
       
        var totalDays : Int = Date().getDaysInMonth()
        if (currentIndex == 1){
            totalDays = 7
            lblBudgetType.text = "Weekly Budget"
        }else if (currentIndex == 2){
            totalDays = Date().getDaysInMonth()
            lblBudgetType.text = "Monthly Budget"
        }
        else if (currentIndex == 3){
            totalDays = 365
            lblBudgetType.text = "Yearly Budget"
        }
        
        for i in 0...totalDays {
            print(i)
            print(totalDays)
            
            if (i == totalDays){
                
                showMonthlyChart(mothlyExpense: expenseArrayCheck)
                return
                
            }
            
//            if (i == 0){
//                dayComponent.day = 0
//            }else{
                dayComponent.day = i
//            }
            
            let theCalendar = Calendar.current
            let nextDate = theCalendar.date(byAdding: dayComponent, to: startDate)
           
//
            if let aDate = nextDate {
                //                    let changedDate = aDate.string(with: "MM-dd-yyyy HH:mm")
                let changedDate = aDate.string(with: "MM-dd-yyyy")
                let currentDate = Date().string(format: "MM-dd-yyyy")
                
                

                let expensedData : [expense] = DBManager.shared.loadExpenseDateWise(strDate: changedDate)
                print(changedDate)
                print("expenseDataCount : \(expensedData.count)")
                for exp in expensedData{
                    expenseArrayCheck.append(exp)
                }
                print("expenseArrayCount : \(expenseArrayCheck.count)")
//                if (changedDate == currentDate){
//                    break
//                }

            }
        }
        print(expenseArrayCheck)
        showMonthlyChart(mothlyExpense: expenseArrayCheck)
    }
    
    func showMonthlyChart(mothlyExpense : [expense])  {
        
        
        var expense_Array = [expense]()
        var earned_Array = [expense]()
        
        for today in mothlyExpense{
            if (today.isexpense == "1"){
                expense_Array.append(today)
            }else{
                earned_Array.append(today)
            }
        }
        var expenseValueCount : Double = 0
        for expenseObject in expense_Array {
            
            let expenseValue = Double(expenseObject.expenseAmount)
            expenseValueCount = expenseValueCount + expenseValue!
            
        }
        
        var earnValueCount : Double = 0
        
        for expenseObject in earned_Array {
            
            let earnValue = Double(expenseObject.expenseAmount)
            earnValueCount = earnValueCount + earnValue!
            
        }
        let totalval = earnValueCount - expenseValueCount
        btnDailyBudgetAmount.setTitle("$ \(String(format:"%.2f", totalval))", for: .normal)
        
        
        
        
        var track = ["Inc %","Exp %"]
        var percentage : Double = (100 * expenseValueCount) / earnValueCount
        
        var monthExpensePercentage : [Double] = [percentage]
        if (expenseValueCount == 0) && (earnValueCount != 0){
            track = ["100 % Saving","0 % Expense"]
            monthExpensePercentage = [100,0]
        }else if (earnValueCount == 0) && (expenseValueCount != 0){
            track = ["0 % Saving","100 % Expense"]
            monthExpensePercentage = [0,100]
        }else if (earnValueCount == 0) && (expenseValueCount == 0){
            track = ["0 % Saving","0 % Expense"]
            monthExpensePercentage = [0,0]
        }else if (percentage > 100){
            track = ["0 % Saving","100 % Expense"]
            monthExpensePercentage = [0,100]
        }else if (percentage < 100){
            let remainPercentage = 100 - percentage
            track = ["\(String(format:"%.2f", remainPercentage)) % Saving","\(String(format:"%.2f", percentage)) % Expense"]
            monthExpensePercentage = [remainPercentage,percentage]
        }
        
        print(track)
        print(monthExpensePercentage)
        updateChartData(track: track, money: monthExpensePercentage)
        
        
        
//        let tracky = ["Earned", "Spent"]
//        let mone = [earnValueCount, expenseValueCount]
//
//        updateChartData(track: tracky, money: mone)
    }
   
    
    
    
    func getTheDateBetweenDates(startDate : Date){
        
        
        var dayComponent = DateComponents()
        var expenseArrayCheck : [expense] = [expense]()
        
        var totalDays : Int = 1000
        
        
        for i in 0...totalDays {
            print(i)
            print(totalDays)
            
            if (i == totalDays){
                
                showMonthlyChart(mothlyExpense: expenseArrayCheck)
                return
                
            }
            
            //            if (i == 0){
            //                dayComponent.day = 0
            //            }else{
            dayComponent.day = i
            //            }
            
            let theCalendar = Calendar.current
            let nextDate = theCalendar.date(byAdding: dayComponent, to: startDate)
            
            //
            if let aDate = nextDate {
                //                    let changedDate = aDate.string(with: "MM-dd-yyyy HH:mm")
                let changedDate = aDate.string(with: "MM-dd-yyyy")
                let currentDate = Date().string(format: "MM-dd-yyyy")
                
                
                
                let expensedData : [expense] = DBManager.shared.loadExpenseDateWise(strDate: changedDate)
                print(changedDate)
                print("expenseDataCount : \(expensedData.count)")
                for exp in expensedData{
                    expenseArrayCheck.append(exp)
                }
                print("expenseArrayCount : \(expenseArrayCheck.count)")
                //                if (changedDate == currentDate){
                //                    break
                //                }
                
            }
        }
        print(expenseArrayCheck)
        showMonthlyChart(mothlyExpense: expenseArrayCheck)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    
    
    
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    
    
   
    
}



extension Calendar {
    
  
    func startOfYear(_ date: Date) -> Date {
        return self.date(from: self.dateComponents([.year], from: date))!
    }
    
    func endOfYear(_ date: Date) -> Date {
        return self.date(from: DateComponents(year: self.component(.year, from: date), month: 12, day: 31))!
    }
}



extension Date {
    
    func getDaysInMonth() -> Int{
        let calendar = Calendar.current
        
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        return numDays
    }
    
}

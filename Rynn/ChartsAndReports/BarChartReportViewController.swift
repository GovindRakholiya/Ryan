//
//  BarChartReportViewController.swift
//  BUILD
//
//  Created by Ishan Vyas on 25/03/19.
//  Copyright © 2019 Govind Rakholiya. All rights reserved.
//

import UIKit
import Charts

class ChartMarker: MarkerView {
    
    
    var text = ""
    
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        super.refreshContent(entry: entry, highlight: highlight)
        text = String(entry.y)
    }
    
    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)
        
        var drawAttributes = [NSAttributedStringKey : Any]()
        drawAttributes[.font] = UIFont.systemFont(ofSize: 15)
        drawAttributes[.foregroundColor] = UIColor.white
        drawAttributes[.backgroundColor] = UIColor.darkGray
        
        self.bounds.size = (" \(text) " as NSString).size(withAttributes: drawAttributes)
        self.offset = CGPoint(x: 0, y: -self.bounds.size.height - 2)
        
        let offset = self.offsetForDrawing(atPoint: point)
        
        drawText(text: " \(text) " as NSString, rect: CGRect(origin: CGPoint(x: point.x + offset.x, y: point.y + offset.y), size: self.bounds.size), withAttributes: drawAttributes)
    }
    
    func drawText(text: NSString, rect: CGRect, withAttributes attributes: [NSAttributedStringKey : Any]? = nil) {
        let size = text.size(withAttributes: attributes)
        let centeredRect = CGRect(x: rect.origin.x + (rect.size.width - size.width) / 2.0, y: rect.origin.y + (rect.size.height - size.height) / 2.0, width: size.width, height: size.height)
        text.draw(in: centeredRect, withAttributes: attributes)
    }
}


class BarChartReportViewController: UIViewController,ChartViewDelegate {
    
    var lastDate : Date = Date()
    @IBOutlet weak var lblNoDataAvailable: UILabel!
    
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var viewStartDate: UIView!
    @IBOutlet weak var viewEndDate: UIView!
    @IBOutlet weak var viewBottom: UIView!
    
    @IBOutlet weak var lblBudgetType: UILabel!
    @IBOutlet weak var lblTodaysDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewDateSelection: UIView!
    @IBOutlet weak var filterViewHeight: NSLayoutConstraint!
    @IBOutlet weak var chartForbarView: BarChartView!
    var months: [String]!
    var dataEntries: [BarChartDataEntry] = []
    
    var isFilter : Bool = false
    var startDate : String = ""
    var endDate : String = ""
    
    var startDateForComp : Date?
    var endDateForComp : Date?
    
    var selectedDateArray : [Date] = [Date]()
    
    let datePicker: UIDatePicker = UIDatePicker()
    let datePickerEndDate: UIDatePicker = UIDatePicker()
    
    
    var expenseArray = [expense]()
    var earnedArray = [expense]()
    var responseArray = [expense]()
    var responseArrayForTable = [expense]()
    var todaysArray = [expense]()
    
    
    var dateStringArray : [String] = [String]()
    var incomeDoubleValueArray : [Double] = [Double]()
    var expenseDoubleValueArray : [Double] = [Double]()
    
    var currentIndex = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        
        viewBottom.layer.cornerRadius = 5.0
        Singleton.sharedSingleton.setShadow(to: viewBottom)
        
        viewEndDate.layer.cornerRadius = 5.0
        Singleton.sharedSingleton.setShadow(to: viewEndDate)
        
        viewStartDate.layer.cornerRadius = 5.0
        Singleton.sharedSingleton.setShadow(to: viewStartDate)
        
        btnSearch.layer.cornerRadius = 5.0
        Singleton.sharedSingleton.setShadow(to: btnSearch)
        
        Global.appDelegate.tabBarController.hideTabBar()
        DisplayData()
        setDatePicker()
        
        chartForbarView.xAxis.drawAxisLineEnabled = false
        chartForbarView.xAxis.drawGridLinesEnabled = false
        chartForbarView.doubleTapToZoomEnabled = false
        chartForbarView.rightAxis.drawGridLinesEnabled = false
        chartForbarView.rightAxis.drawAxisLineEnabled = false
        chartForbarView.leftAxis.drawAxisLineEnabled = false
        chartForbarView.leftAxis.drawGridLinesEnabled = false
    }
    
    func DisplayData() {
        
//        showPieChart()
        currentIndex = 1
        loadViewAsPerSwipe()
        addGestureForSwipe()
    }
    
    func addGestureForSwipe() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
//        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
//        self.view.addGestureRecognizer(swipeRight)
    }
    
    @IBAction func btnDailyChartPressed(_ sender: Any) {
        let dailyChartVC = DailyChartViewController(nibName: "DailyChartViewController", bundle: nil)
        self.add(dailyChartVC, frame: self.view.frame)
    }
    
    @IBAction func btnPieChartPressed(_ sender: Any) {
        let chartAndReportVC = ChartsAndReportsViewController(nibName: "ChartsAndReportsViewController", bundle: nil)
        self.add(chartAndReportVC, frame: self.view.frame)
//        self.remove()
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
            getTheWeeklyData(startDate: newDate!, next: true)
//            getTheMonthlyData(startDate: newDate!)
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
    
    
    
    //MARK:-  Get The Weekly Data
    func getTheWeeklyData(startDate : Date,next : Bool){
        
        
        var dayComponent = DateComponents()
        var expenseArrayCheck : [expense] = [expense]()
        
        var totalDays : Int = Date().getDaysInMonth()
        
        if (next == true){
            totalDays = 7
        }else{
            totalDays = 7
        }
        
            lblBudgetType.text = "Weekly Budget"
        
        
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
            lastDate = nextDate ?? Date()
            //
            if let aDate = nextDate {
                //                    let changedDate = aDate.string(with: "MM-dd-yyyy HH:mm")
                let changedDate = aDate.string(with: "MM-dd-yyyy")
                let currentDate = Date().string(format: "MM-dd-yyyy")
                
                
                let startPrintDate = startDate.string(format: "d MMMM, yyyy") ?? ""
                
                let stopPrintDate = aDate.string(format: "d MMMM, yyyy") ?? ""
                
                lblTodaysDate.text = "\(startPrintDate) - \(stopPrintDate)"
                
                
                
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
            lastDate = nextDate ?? Date()
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
        dateStringArray = [String]()
        incomeDoubleValueArray = [Double]()
        expenseDoubleValueArray = [Double]()
        
        for today in todaysArray{
            print(today.expenseDate)
            
            if (today.isexpense == "1"){
                expenseArray.append(today)
            }else{
                earnedArray.append(today)
            }
        
        }
        
        
        var expenseValueCount : Double = 0
        for expenseObject in expenseArray {
            dateStringArray = [expenseObject.expenseDate]
            let expenseValue = Double(expenseObject.expenseAmount)
            expenseValueCount = expenseValueCount + expenseValue!
            
        }
        
        var earnValueCount : Double = 0
        
        for expenseObject in earnedArray {
            dateStringArray = [expenseObject.expenseDate]
            let earnValue = Double(expenseObject.expenseAmount)
            earnValueCount = earnValueCount + earnValue!
            
        }
        expenseDoubleValueArray = [expenseValueCount]
        incomeDoubleValueArray = [earnValueCount]
        
        setGroupBarChart(months: dateStringArray, unitsSold: incomeDoubleValueArray, unitsBought: expenseDoubleValueArray)

    }
    
    
    func setGroupBarChart(months : [String],unitsSold : [Double],unitsBought : [Double]) {
//        let months = ["Jan", "Feb", "Mar", "Apr", "May"]
//        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0]
//        let unitsBought = [10.0, 14.0, 60.0, 13.0, 2.0]
        
        
        //legend
        let legend = chartForbarView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        
        
        let yaxis = chartForbarView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        
        
        
        chartForbarView.rightAxis.enabled = false
        
        chartForbarView.delegate = self
        chartForbarView.noDataText = "You need to provide data for the chart."
        chartForbarView.chartDescription?.textColor = UIColor.clear
        chartForbarView.drawMarkers = true
        
        
        let xaxis = chartForbarView.xAxis
        //xaxis.valueFormatter = axisFormatDelegate
        
        xaxis.forceLabelsEnabled = true
        xaxis.drawGridLinesEnabled = false
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = IndexAxisValueFormatter(values:months)
        xaxis.granularityEnabled = true
        xaxis.granularity = 1
        xaxis.labelCount = 7
       
//        xaxis.setLabelCount(dateStringArray.count, force: true)
        chartForbarView.fitBars = true
        
        
        
        
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
        for i in 0..<months.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(unitsSold[i]))
            dataEntries.append(dataEntry)
            
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: Double(unitsBought[i]))
            dataEntries1.append(dataEntry1)
            
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Earning")
        let chartDataSet1 = BarChartDataSet(values: dataEntries1, label: "Expense")
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        chartDataSet.colors = [UIColor(red: 62/255, green: 188/255, blue: 165/255, alpha: 1.0)]
        chartDataSet1.colors = [UIColor(red: 244/255, green: 121/255, blue: 29/255, alpha: 1.0)]
        
        
        //chartDataSet.colors = ChartColorTemplates.colorful()
        //let chartData = BarChartData(dataSet: chartDataSet)
        
        let chartData = BarChartData(dataSets: dataSets)
        
        let groupSpace = 0.3
        let barSpace = 0.03
        let barWidth = groupSpace
        
        
        let groupCount = months.count
        let startYear = 0
        
////
//        chartForbarView.xAxis.labelRotationAngle = -45.0
        
        
        chartData.barWidth = barWidth;
        chartForbarView.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        
        chartForbarView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        
        if (chartData.entryCount == 0){
            lblNoDataAvailable.isHidden = false
        }else{
            lblNoDataAvailable.isHidden = true
        }
        
        
        //print(chartData)
        chartForbarView.data = chartData
        
        chartForbarView.setVisibleXRangeMaximum(15)
        chartForbarView.animate(yAxisDuration: 1.0, easingOption: .easeOutSine)
        
        chartForbarView.fitBars = true
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
    
    
    @IBAction func btnSearchBetweenTwoDatesPressed(_ sender: Any) {
        guard selectedDateArray.count > 0 else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: "Please Select Start and End Date Different")
            return
        }
        setDataBetweenTwoDates(dateArray: selectedDateArray)
        
    }
    
    
    @IBAction func btnRightPressed(_ sender: Any) {
        getTheWeeklyData(startDate: lastDate, next: true)
//        if (currentIndex != 3){
//            currentIndex = currentIndex + 1
//            loadViewAsPerSwipe()
//        }
    }
    
    @IBAction func btnLeftPressed(_ sender: Any) {
        var dayComponent = DateComponents()
        dayComponent.day = -12
        let theCalendar = Calendar.current
        let nextDate = theCalendar.date(byAdding: dayComponent, to: lastDate)
        getTheWeeklyData(startDate: nextDate!, next: false)
//        if (currentIndex != 0){
//            currentIndex = currentIndex - 1
//            loadViewAsPerSwipe()
//        }
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
    
    
    func showMonthlyChart(mothlyExpense : [expense])  {
        
        var dateDisplayArray : [String] = [String]()
        var expense_Array = [expense]()
        var earned_Array = [expense]()
        
        dateStringArray = [String]()
        
        for today in mothlyExpense{
            if (dateStringArray.contains(today.expenseDate)){
                
            }else{
                let dateToDisplay = today.expenseDate.split(separator: "-")
                dateDisplayArray.append(dateToDisplay[1].description ?? "")
                dateStringArray.append(today.expenseDate)
            }
            if (today.isexpense == "1"){
                expense_Array.append(today)
            }else{
                earned_Array.append(today)
            }
        }
//        var expenseValueCount : Double = 0
//        for expenseObject in expense_Array {
//
//            let expenseValue = Double(expenseObject.expenseAmount)
//            expenseValueCount = expenseValueCount + expenseValue!
//
//        }
        expenseDoubleValueArray = [Double]()
        incomeDoubleValueArray = [Double]()
        for dates in dateStringArray{
            var expenseOnThatDate : Double = 0
            var earningOnThatDate : Double = 0
            for expenseObject in expense_Array {
                if (dates == expenseObject.expenseDate){
                    let expenseValue = Double(expenseObject.expenseAmount)
                    expenseOnThatDate = expenseOnThatDate + expenseValue!
                }
            }
            for expenseObject in earned_Array {
                if (dates == expenseObject.expenseDate){
                    let earningValue = Double(expenseObject.expenseAmount)
                    earningOnThatDate = earningOnThatDate + earningValue!
                }
            }
            
            expenseDoubleValueArray.append(expenseOnThatDate)
            incomeDoubleValueArray.append(earningOnThatDate)
        }
        
       // print(dateDisplayArray)
//        setGroupBarChart(months: dateStringArray, unitsSold: incomeDoubleValueArray, unitsBought: expenseDoubleValueArray)

       setGroupBarChart(months: dateDisplayArray, unitsSold: incomeDoubleValueArray, unitsBought: expenseDoubleValueArray)
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
    
    //MARK:-  Bar Chart Delegate
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let marker = ChartMarker()
        marker.chartView = chartView
       
        chartForbarView.marker = marker
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.removeChild()
        filterViewHeight.constant = 0
        Global.appDelegate.tabBarController.hideTabBar()
        viewDateSelection.isHidden = true
    }
    @IBAction func btnFilterPressed(_ sender: Any) {
        if (filterViewHeight.constant == 160){
            filterViewHeight.constant = 0
            isFilter = false
            btnNext.isHidden = false
            btnPrev.isHidden = false
            viewDateSelection.isHidden = true
        }else{
            filterViewHeight.constant = 160
            isFilter = true
            btnNext.isHidden = true
            btnPrev.isHidden = true
            viewDateSelection.isHidden = false
        }
    }
    @IBAction func btnBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        chartForbarView.noDataText = "You need to provide data for the chart."
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        chartForbarView.data = chartData
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

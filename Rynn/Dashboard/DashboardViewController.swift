//
//  DashboardViewController.swift
//  Rynn
//
//  Created by Govind Rakholiya on 20/09/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit
import Charts

class DashboardViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var viewBudgetTopButton: UIView!
    
    @IBOutlet weak var viewRecentActivity: UIView!
    
    @IBOutlet weak var btnDailyBudgetAmount: UIButton!
    @IBOutlet weak var tblRecentActivityHeight: NSLayoutConstraint!
    @IBOutlet weak var tblRecent: UITableView!
    @IBOutlet weak var chartOfEarning: PieChartView!
    
    @IBOutlet weak var lblTodaysDate: UILabel!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewEarned: UIView!
    @IBOutlet weak var viewSpent: UIView!
    
    var expenseArray = [expense]()
    var earnedArray = [expense]()
    var responseArray = [expense]()
    
    var responseArrayForTable = [expense]()
    
    var todaysArray = [expense]()
    
    var isSecure : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Yes")
        
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        
        DBManager.shared.copyDatabase()
        
        Singleton.sharedSingleton.setCornerRadius(view: viewTop, radius: 5.0)
        
        lblTodaysDate.text = Date().string(format: "EEEE d MMMM, yyyy")
        Singleton.sharedSingleton.setShadow(to: viewTop)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        Singleton.sharedSingleton.setCornerRadius(view: viewSpent, radius: viewSpent.frame.size.width / 2)
        
        
        Singleton.sharedSingleton.setCornerRadius(view: viewEarned, radius: viewEarned.frame.size.width / 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        isSecure = false
        
        Singleton.sharedSingleton.setCornerRadius(view: viewBudgetTopButton, radius: viewBudgetTopButton.frame.size.height / 2)
        
        Singleton.sharedSingleton.setCornerRadius(view: btnDailyBudgetAmount, radius: btnDailyBudgetAmount.frame.size.height / 2)
        tblRecent.isScrollEnabled = false
        let nib = UINib(nibName: "ExpenseTableViewCell", bundle: nil)
        tblRecent.register(nib, forCellReuseIdentifier: "ExpenseTableViewCell")
        
        
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
       
//        print(track)
//        print(monthExpensePercentage)
        updateChartData(track: track, money: monthExpensePercentage)
//        let tracky = ["Earned", "Spent"]
//        let mone = [earnValueCount, expenseValueCount]
//        updateChartData(track: tracky, money: mone)
        
        
        
        responseArrayForTable = DBManager.shared.loadExpense()
        tblRecent.reloadData()
    }
    
    @IBAction func btnGotoChartPressed(_ sender: Any) {
        let chartsAndReportsVc = ChartsAndReportsViewController(nibName: "ChartsAndReportsViewController", bundle: nil)
        self.navigationController?.pushViewController(chartsAndReportsVc, animated: false)
    }
    @IBAction func btnOnChartPressed(_ sender: Any) {
        if (isSecure == true){
            isSecure = false
            viewWillAppear(false)
        }else{
            isSecure = true
            btnDailyBudgetAmount.setTitle("tap to show", for: .normal)
        }
        
    }
    @IBAction func btnEarnedPressed(_ sender: Any) {
        let addexpenseVC = AddExpenseViewController(nibName: "AddExpenseViewController", bundle: nil)
        
        self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromTop(), forKey: kCATransition)
        
        addexpenseVC.isexpense = false
        self.navigationController?.pushViewController(addexpenseVC, animated: false)
    }
    
    @IBAction func btnSpentPressed(_ sender: Any) {
        let addexpenseVC = AddExpenseViewController(nibName: "AddExpenseViewController", bundle: nil)
        
        addexpenseVC.isexpense = true
        self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromTop(), forKey: kCATransition)
        
        self.navigationController?.pushViewController(addexpenseVC, animated: false)
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
    
    
    //MARK:-  Tableview DataSource Delegate 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ExpenseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExpenseTableViewCell") as! ExpenseTableViewCell
        let amountinDouble : Double = Double(responseArrayForTable[indexPath.row].expenseAmount) ?? 0.0
//        btnDailyBudgetAmount.setTitle("$ \(String(format:"%.2f", totalval))", for: .normal)
//        cell.lblAmount.text = "$\(responseArray[indexPath.row].expenseAmount)"
        cell.lblAmount.text = "$ \(String(format:"%.2f", amountinDouble))"
        cell.btnExpenseType.setTitle("\(responseArrayForTable[indexPath.row].expenseType)", for: .normal)
        cell.selectionStyle = .none
        Singleton.sharedSingleton.setCornerRadius(view: cell.btnExpenseType, radius: cell.btnExpenseType.frame.size.height / 2)
        cell.lblcategoryNameAndDate.text = "\(responseArrayForTable[indexPath.row].expenseCategoryName) | \(responseArrayForTable[indexPath.row].expenseDate)"
        cell.expensetitle.text = "\(responseArrayForTable[indexPath.row].expenseTitle)"
       
        if (responseArrayForTable[indexPath.row].isexpense == "1"){
            cell.lblAmount.textColor = UIColor(red: 244.0/255.0, green: 121.0/255.0, blue: 29.0/255.0, alpha: 1.0)
            cell.imgExpense.image = UIImage(named: "2")
        }else{
            cell.lblAmount.textColor = UIColor(red: 62.0/255.0, green: 188.0/255.0, blue: 165.0/255.0, alpha: 1.0)
            cell.imgExpense.image = UIImage(named: "1")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tblRecentActivityHeight.constant = CGFloat(responseArrayForTable.count > 4 ? 550 : ((responseArrayForTable.count + 1) * 100))
        return responseArrayForTable.count > 4 ? 5 : responseArrayForTable.count
//        return responseArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myview : UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 50.0))
        
        let newview : UIView = UIView(frame: CGRect(x: 10.0, y: 0.0, width: UIScreen.main.bounds.size.width - 20, height: 49.0))
        newview.backgroundColor = UIColor.white
        myview.backgroundColor = UIColor.clear
        Singleton.sharedSingleton.setCornerRadius(view: newview, radius: 5.0)
        myview.addSubview(newview)
        let lblRecent : UILabel = UILabel(frame: CGRect(x: 5.0, y: 0.0, width: UIScreen.main.bounds.size.width - 20, height: 50.0))
        lblRecent.text = "Recent Activity"
        newview.addSubview(lblRecent)
        return myview
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
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
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}


//
//  RecurrenceCycleViewController.swift
//  Rynn
//
//  Created by Govind Rakholiya on 15/10/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit

protocol selectRecurrenceCycleDelegate : class {
    func recurrenceSelected(cycle : Int, type : String)
}


class RecurrenceCycleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    weak var recurrenceDelegate:selectRecurrenceCycleDelegate?
    @IBOutlet weak var tblRecurrenceSelection: UITableView!
    
    var WeekArray : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
    var MonthArray  : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
     var biWeekArray  : [Int] = [1,2,3,4]
    var YearArray : [Int] = [1,2,3,4,5,6,7,8,9,10]
    
    var DailyArray  : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
    
    var recurrenceTypeSelected : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        
        let nib = UINib(nibName: "categoryTableViewCell", bundle: nil)
        tblRecurrenceSelection.register(nib, forCellReuseIdentifier: "categoryTableViewCell")
        
        Global.appDelegate.tabBarController.hideTabBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        tblRecurrenceSelection.layer.cornerRadius = 5.0
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:-  Tableview Datasource Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : categoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell") as! categoryTableViewCell
        cell.selectionStyle = .none
        
        if   (recurrenceTypeSelected == Global.RecurrenceType.daily){
            cell.lblCategoryName.text = "\(DailyArray[indexPath.row]) Days"
           
        }else if (recurrenceTypeSelected == Global.RecurrenceType.weekly){
           cell.lblCategoryName.text = "\(WeekArray[indexPath.row]) Week"
        }else if (recurrenceTypeSelected == Global.RecurrenceType.monthly){
             cell.lblCategoryName.text = "\(MonthArray[indexPath.row]) Month"
        }else if (recurrenceTypeSelected == Global.RecurrenceType.biweekly){
            cell.lblCategoryName.text = "\(biWeekArray[indexPath.row]) Bi-Week"
        }else{
            cell.lblCategoryName.text = "\(YearArray[indexPath.row]) Year"
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if   (recurrenceTypeSelected == Global.RecurrenceType.daily){
            return DailyArray.count
        }else if (recurrenceTypeSelected == Global.RecurrenceType.weekly){
             return WeekArray.count
        }else if (recurrenceTypeSelected == Global.RecurrenceType.monthly){
             return MonthArray.count
        }else if (recurrenceTypeSelected == Global.RecurrenceType.biweekly){
            return biWeekArray.count
        }else{
            return YearArray.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if   (recurrenceTypeSelected == Global.RecurrenceType.daily){
            recurrenceDelegate?.recurrenceSelected(cycle: DailyArray[indexPath.row], type: Global.RecurrenceType.daily)
            self.navigationController?.popViewController(animated: true)
            
            
        }else if (recurrenceTypeSelected == Global.RecurrenceType.weekly){
            recurrenceDelegate?.recurrenceSelected(cycle: WeekArray[indexPath.row], type: Global.RecurrenceType.weekly)
            self.navigationController?.popViewController(animated: true)
        }else if (recurrenceTypeSelected == Global.RecurrenceType.monthly){
            recurrenceDelegate?.recurrenceSelected(cycle: MonthArray[indexPath.row], type: Global.RecurrenceType.monthly)
            
            self.navigationController?.popViewController(animated: true)
        }else if (recurrenceTypeSelected == Global.RecurrenceType.biweekly){
            recurrenceDelegate?.recurrenceSelected(cycle: biWeekArray[indexPath.row], type: Global.RecurrenceType.biweekly)
            
            self.navigationController?.popViewController(animated: true)
        }else{
            recurrenceDelegate?.recurrenceSelected(cycle: YearArray[indexPath.row], type: Global.RecurrenceType.yearly)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  EarningListViewController.swift
//  Rynn
//
//  Created by Govind Rakholiya on 14/10/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit

class EarningListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var expenseArray = [expense]()
    var earnedArray = [expense]()
    var responseArray = [expense]()
    
    @IBOutlet weak var tblEarnings: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        let nib = UINib(nibName: "ExpenseTableViewCell", bundle: nil)
        tblEarnings.register(nib, forCellReuseIdentifier: "ExpenseTableViewCell")
        
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        
        responseArray = DBManager.shared.loadExpense()
        expenseArray = [expense]()
        earnedArray = [expense]()
        for response in responseArray {
            if (response.isexpense == "1"){
                expenseArray.append(response)
            }else{
                earnedArray.append(response)
            }
        }
        tblEarnings.reloadData()
        
        tblEarnings.separatorStyle = .none
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ExpenseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExpenseTableViewCell") as! ExpenseTableViewCell
        cell.selectionStyle = .none
        
        let amountinDouble : Double = Double(earnedArray[indexPath.row].expenseAmount)!
        //        btnDailyBudgetAmount.setTitle("$ \(String(format:"%.2f", totalval))", for: .normal)
        //        cell.lblAmount.text = "$\(responseArray[indexPath.row].expenseAmount)"
        cell.lblAmount.text = "$ \(String(format:"%.2f", amountinDouble))"
        
//        cell.lblAmount.text = "$\(earnedArray[indexPath.row].expenseAmount)"
        cell.btnExpenseType.setTitle("\(earnedArray[indexPath.row].expenseType)", for: .normal)
        Singleton.sharedSingleton.setCornerRadius(view: cell.btnExpenseType, radius: cell.btnExpenseType.frame.size.height / 2)
        cell.lblcategoryNameAndDate.text = "\(earnedArray[indexPath.row].expenseCategoryName) | \(earnedArray[indexPath.row].expenseDate)"
        cell.expensetitle.text = "\(earnedArray[indexPath.row].expenseTitle)"
        cell.imgExpense.image = UIImage(named: "1")
        
        cell.lblAmount.textColor = UIColor(red: 62.0/255.0, green: 188.0/255.0, blue: 165.0/255.0, alpha: 1.0)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earnedArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            DBManager.shared.deleteExpense(expenseIdChoosen: earnedArray[indexPath.row].id, onsucess: { (isSucess) in
                if (isSucess){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        
                        self.responseArray = DBManager.shared.loadExpense()
                        self.expenseArray = [expense]()
                        self.earnedArray = [expense]()
                        for response in self.responseArray {
                            if (response.isexpense == "1"){
                                self.expenseArray.append(response)
                            }else{
                                self.earnedArray.append(response)
                            }
                        }
                        
                        self.tblEarnings.reloadData()
                        
                    })
                    
                }
                
            })
            
            
        }
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

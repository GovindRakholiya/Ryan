//
//  ExpenseListViewController.swift
//  Rynn
//
//  Created by Govind Rakholiya on 20/09/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit

class ExpenseListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var expenseArray = [expense]()
    var earnedArray = [expense]()
    var responseArray = [expense]()
    @IBOutlet weak var tblExpense: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        let nib = UINib(nibName: "ExpenseTableViewCell", bundle: nil)
        tblExpense.register(nib, forCellReuseIdentifier: "ExpenseTableViewCell")
        
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
        
        tblExpense.reloadData()
        
        tblExpense.separatorStyle = .none
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ExpenseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExpenseTableViewCell") as! ExpenseTableViewCell
        
        let amountinDouble : Double = Double(expenseArray[indexPath.row].expenseAmount)!
        //        btnDailyBudgetAmount.setTitle("$ \(String(format:"%.2f", totalval))", for: .normal)
        //        cell.lblAmount.text = "$\(responseArray[indexPath.row].expenseAmount)"
        cell.lblAmount.text = "$ \(String(format:"%.2f", amountinDouble))"
        
//        cell.lblAmount.text = "$\(expenseArray[indexPath.row].expenseAmount)"
        cell.btnExpenseType.setTitle("\(expenseArray[indexPath.row].expenseType)", for: .normal)
        cell.selectionStyle = .none
        Singleton.sharedSingleton.setCornerRadius(view: cell.btnExpenseType, radius: cell.btnExpenseType.frame.size.height / 2)
        cell.lblcategoryNameAndDate.text = " \(expenseArray[indexPath.row].expenseDate)"
//        cell.lblcategoryNameAndDate.text = "\(expenseArray[indexPath.row].expenseCategoryName) | \(expenseArray[indexPath.row].expenseDate)"
        cell.expensetitle.text = "\(expenseArray[indexPath.row].expenseTitle)"
        
        cell.lblAmount.textColor = UIColor(red: 244.0/255.0, green: 121.0/255.0, blue: 29.0/255.0, alpha: 1.0)
        
            cell.imgExpense.image = UIImage(named: "2")
      
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            DBManager.shared.deleteExpense(expenseIdChoosen: expenseArray[indexPath.row].id, onsucess: { (isSucess) in
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
                        
                        self.tblExpense.reloadData()
                        
                    })
                    
                }

            })
            

        }
    }

}

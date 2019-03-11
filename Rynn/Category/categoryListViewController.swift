//
//  categoryListViewController.swift
//  Rynn
//
//  Created by Govind Rakholiya on 10/10/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit
protocol selectCategoryDelegate : class {
    func categorySelected(categoryId : Int, categoryName : String)
}

class categoryListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var isComingFrom : String = ""
    var selectedCategory = "1"
    var isexpense : Bool = true
    @IBOutlet weak var viewAddCategoryOptions: UIView!
    weak var catdelegate:selectCategoryDelegate?
    
    @IBOutlet weak var tblCategory: UITableView!
    var categoryArray : [Category] = [Category]()
    var selectedCategoryId : Int = 0
    var selectedCategoryName : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAddCategoryOptions.layer.cornerRadius = 1.0
        viewAddCategoryOptions.layer.borderWidth = 1.0
        viewAddCategoryOptions.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        Global.appDelegate.tabBarController.hideTabBar()
        let nib = UINib(nibName: "categoryTableViewCell", bundle: nil)
        tblCategory.register(nib, forCellReuseIdentifier: "categoryTableViewCell")
        
        viewAddCategoryOptions.isHidden = true
        if (isComingFrom == "MYACCOUNT"){
            categoryArray = DBManager.shared.loadAllCategories()
        }else{
            if (isexpense){
                categoryArray = DBManager.shared.loadCategories(categorytypeObj: "0")
            }else{
                categoryArray = DBManager.shared.loadCategories(categorytypeObj: "1")
            }
        }
        
        
        tblCategory.reloadData()
        
    }
    
    override func viewDidLayoutSubviews() {
        Singleton.sharedSingleton.setCornerRadius(view: tblCategory, radius: 5.0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnAddExpenseCategoryPressed(_ sender: Any) {
        viewAddCategoryOptions.isHidden = true
        selectedCategory = "0"
        
        
        let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Category Name"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            if (firstTextField.text == ""){
                Singleton.sharedSingleton.showWarningAlert(withMsg: "Please Enter CategoryName")
                return
            }
            DBManager.shared.AddCategory(categoryName: firstTextField.text!, categoryType: self.selectedCategory, onsucess: { (isSucess) in
                if isSucess{
                    if (self.isexpense){
                        self.categoryArray = DBManager.shared.loadCategories(categorytypeObj: "0")
                    }else{
                        self.categoryArray = DBManager.shared.loadCategories(categorytypeObj: "1")
                    }
                    
                    self.tblCategory.reloadData()
                }else{
                    Singleton.sharedSingleton.showWarningAlert(withMsg: "Something went wrong please try again later..")
                }
            })
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {
            (action : UIAlertAction!) -> Void in })
        //        alertController.addTextField { (textField : UITextField!) -> Void in
        //            textField.placeholder = "Enter First Name"
        //        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func btnAddEarningCategoryPressed(_ sender: Any) {
        viewAddCategoryOptions.isHidden = true
        selectedCategory = "1"
        
        let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Category Name"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            if (firstTextField.text == ""){
                Singleton.sharedSingleton.showWarningAlert(withMsg: "Please Enter CategoryName")
                return
            }
            DBManager.shared.AddCategory(categoryName: firstTextField.text!, categoryType: self.selectedCategory, onsucess: { (isSucess) in
                if isSucess{
                    if (self.isexpense){
                        self.categoryArray = DBManager.shared.loadCategories(categorytypeObj: "0")
                    }else{
                        self.categoryArray = DBManager.shared.loadCategories(categorytypeObj: "1")
                    }
                    
                    self.tblCategory.reloadData()
                }else{
                    Singleton.sharedSingleton.showWarningAlert(withMsg: "Something went wrong please try again later..")
                }
            })
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {
            (action : UIAlertAction!) -> Void in })
        //        alertController.addTextField { (textField : UITextField!) -> Void in
        //            textField.placeholder = "Enter First Name"
        //        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func btnAddCategoryPressed(_ sender: Any) {
        if (viewAddCategoryOptions.isHidden == true){
            viewAddCategoryOptions.isHidden = false
        }else{
            viewAddCategoryOptions.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : categoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell") as! categoryTableViewCell
        cell.selectionStyle = .none
        cell.lblCategoryName.text = categoryArray[indexPath.row].categoryName
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategoryId = categoryArray[indexPath.row].categoryId
        selectedCategoryName = categoryArray[indexPath.row].categoryName
        
        catdelegate?.categorySelected(categoryId: selectedCategoryId, categoryName: selectedCategoryName)
        
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
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

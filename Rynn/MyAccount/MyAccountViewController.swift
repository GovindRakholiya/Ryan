//
//  MyAccountViewController.swift
//  Rynn
//
//  Created by Govind Rakholiya on 17/09/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit
import SwiftyJSON
import MessageUI
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import FBSDKCoreKit

class JobListManager: NSObject {
    
    
    func GetDBCall(_ tokenStr:String,Complete:@escaping(AnyObject)->Void, failure:@escaping(_ is_email:Bool, _ is_Pass:Bool)->Void) -> Void  {
        
        
        var  paramer: [String: Any] = [:]
        paramer["token"] =  tokenStr
       
        AFAPIMaster.sharedAPIMaster.getDBApi_Completion(params: paramer, showLoader: true, enableInteraction: false, viewObj: (Global.appDelegate.navigation?.view)!, onSuccess: { (result) in
            Complete(result as AnyObject)
        }) {
            failure(false,false)
        }
        
        
    }
    
}

class MyAccountViewController: UIViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var viewAccountDown: UIView!
    @IBOutlet weak var viewAccountTop: UIView!
    var isEdit : Bool = false
    @IBOutlet weak var lblEditProfileText: UILabel!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        Global.appDelegate.tabBarController.showTabBar()
        txtUserName.isEnabled = false
        isEdit = false
    }
    
    @IBAction func btnExploreBarChartPressed(_ sender: Any) {
        let barChartVC = BarChartReportViewController(nibName: "BarChartReportViewController", bundle: nil)
        
        self.navigationController?.pushViewController(barChartVC, animated: false)
    }
    
    func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["info@thebuildapp.com"])
        mailComposeVC.setSubject("Support Team")
        mailComposeVC.setMessageBody("", isHTML: false)
        return mailComposeVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userName = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.User_Name){
            if (userName == "A"){
                txtUserName.text = ""
            }else{
                txtUserName.text = userName
            }
            
        }
        if let userEmail = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.User_Email){
            lblEmail.text = userEmail
        }
        
        Singleton.sharedSingleton.setCornerRadius(view: viewAccountTop, radius: 5.0)
        Singleton.sharedSingleton.setShadow(to: viewAccountTop)
        
        Singleton.sharedSingleton.setCornerRadius(view: viewAccountDown, radius: 5.0)
        Singleton.sharedSingleton.setShadow(to: viewAccountDown)
        // Do any additional setup after loading the view.
    }

    
    @IBAction func btnIntroductionVideoPressed(_ sender: Any) {
        let extractedExpr: introductionViewController = introductionViewController(nibName: "introductionViewController", bundle: nil)
        let introVC = extractedExpr
        introVC.isBackButtonNeeded = true
        self.navigationController?.pushViewController(introVC, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogoutPressed(_ sender: Any) {
       
        Global.appDelegate.logOutUser()
    }
    
    @IBAction func btnFAQPressed(_ sender: Any) {
        if let url = URL(string: "https://www.thebuildapp.com/faq") {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    
    @IBAction func btnPrivacyPloicyPressed(_ sender: Any) {
        
        if let url = URL(string: "https://termsfeed.com/privacy-policy/3f7a8ca145d3fa6bb420e18cb5a04a4b") {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    
    @IBAction func btnAboutUsPressed(_ sender: Any) {
        
        if let url = URL(string: "https://www.thebuildapp.com/faq-1") {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    
    @IBAction func btnChooseYourPlanPressed(_ sender: Any) {
        let planVC = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
        planVC.isBackButtonNeeded = true
        self.navigationController?.pushViewController(planVC, animated: false)
    }
    
    func getDBFromServer() {
        
       
        
       let deviceToken = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.DeviceToken) as? String ?? ""
        
        var  paramer: [String: Any] = [:]
        paramer["token"] = deviceToken
        
        
        JobListManager().GetDBCall(deviceToken, Complete: { (result) in
            print(result)
            let res = JSON(result)
            if let msg = res["message"].string{
                Singleton.sharedSingleton.showSuccessAlert(withMsg: msg)
            }
            if let data = res["data"] as? JSON{
                if let filepath : String = data["file"].string{
                    print(filepath)
                    DBManager.shared.copyDatabaseFromServer(sourcePath: filepath)
                }
            }
            
        }) { (isemail, ispass) in
           
        }
    }
    
    
    @IBAction func btnExploreYourDataPressed(_ sender: Any) {
        let chartsAndReportsVc = ChartsAndReportsViewController(nibName: "ChartsAndReportsViewController", bundle: nil)
        self.navigationController?.pushViewController(chartsAndReportsVc, animated: false)
    }
    
    @IBAction func btnMySupportPressed(_ sender: Any) {
        let mailComposeViewController = configureMailComposer()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            print("Can't send email")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func btnEraseDataPressed(_ sender: Any) {
        
        let alert : UIAlertController = UIAlertController(title: "Alert", message: "Are you sure you want to delete all your local and cloud data ?", preferredStyle: .alert)
        let YesAction : UIAlertAction = UIAlertAction(title: "YES", style: .default) { (action) in
            
            self.deleteDataAPICall()
//            DBManager.shared.clearExpenseTable { (issuccess) in
//                if (issuccess){
//                    Singleton.sharedSingleton.showSuccessAlert(withMsg: "Data Erased Sucessfully..")
//                }else{
//                    Singleton.sharedSingleton.showSuccessAlert(withMsg: "Something went wrong please try again later..")
//                }
//            }
        }
        let NoAction : UIAlertAction = UIAlertAction(title: "NO", style: .default) { (action) in
            
        }
        alert.addAction(YesAction)
        alert.addAction(NoAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func btnHelpAndFeedbackPressed(_ sender: Any) {
        if let url = URL(string: "https://www.thebuildapp.com/faq") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    @IBAction func InviteAFriendPressed(_ sender: Any) {
        let text = "https://itunes.apple.com/us/app/BUILD/id1438038539?ls=1&mt=8"
        let textShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    //MARK:-  API CALL
    func deleteDataAPICall()  {
        //user.isAbove18 = true //FOR TEMP USER ONLY
        
        
        var  paramer: [String: Any] = [:]
        let APIToken = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.DeviceToken)
        
        
        paramer["token"] = APIToken
        
        
        AFAPIMaster.sharedAPIMaster.postDeleteDataAPICall_Completion(params: paramer, showLoader: true, enableInteraction: false, viewObj: (Global.appDelegate.navigation?.view)!) { (result) in
            let res = JSON(result)
          //  print(res)
            if let Flag = res["status"].int,Flag == 200 {
                if let data = res["result"] as? JSON
                {
                    
                    DBManager.shared.clearExpenseTable { (issuccess) in
                        if (issuccess){
                            Singleton.sharedSingleton.showSuccessAlert(withMsg: "Data Erased Sucessfully..")
                        }else{
                            Singleton.sharedSingleton.showSuccessAlert(withMsg: "Something went wrong please try again later..")
                        }
                    }

                    
                }
            }
        }
        
    }
    
    
    @IBAction func btnEditProfilePressed(_ sender: Any) {
        isEdit = !isEdit
        if (isEdit){
            txtUserName.isEnabled = true
            lblEditProfileText.text = "Save Profile"
            txtUserName.becomeFirstResponder()
            
            
            
        }else{
            let strUserName = txtUserName.text!.trimmingCharacters(in: .whitespaces)
            guard strUserName.count > 0 else {
                Singleton.sharedSingleton.showWarningAlert(withMsg: "UserName Can not be empty")
                return
            }
            txtUserName.isEnabled = false
            lblEditProfileText.text = "Edit Profile"
            txtUserName.resignFirstResponder()
            EditProfileCall(UserName: txtUserName.text!)
           
            
        }
        
    }
    
    
    @IBAction func btnEditCategoryPressed(_ sender: Any) {
        let categoryListVC = categoryListViewController(nibName: "categoryListViewController", bundle: nil)
        categoryListVC.isComingFrom = "MYACCOUNT"
        self.navigationController?.pushViewController(categoryListVC, animated: true)
        
    }
    
    @IBAction func btnGetBackUpClick(_ sender: Any) {
        getDBFromServer()
    }
    @IBAction func btnExportDataClicked(_ sender: Any) {
        UploadDBCall()
    }
    
    //MARK:-  API CALL 
    
    
    func UploadDBCall()  {
        //user.isAbove18 = true //FOR TEMP USER ONLY
        let deviceToken = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.DeviceToken) as? String ?? ""
        
        let dataOfDB = DBManager.shared.getDatabase()
        var  paramer: [String: Any] = [:]
        paramer["token"] = deviceToken
        
        AFAPIMaster.sharedAPIMaster.post_DB_Upload_Completion(image: dataOfDB, params: paramer, showLoader: true, enableInteraction: false, viewObj: self.view, onSuccess: { (response) in
           
            let res = JSON(response)
            if let msg = res["message"].string{
                Singleton.sharedSingleton.showSuccessAlert(withMsg: msg)
            }
            
        }) {
            
        }
        
        
       
        
    }
    
    
    //MARK:-  API CALL 
    
    
    func EditProfileCall(UserName : String)  {
        //user.isAbove18 = true //FOR TEMP USER ONLY
        
        
        let token = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.DeviceToken) ?? ""
        var  paramer: [String: Any] = [:]
        paramer["token"] = token
        paramer["user_name"] = UserName
        
        
        AFAPIMaster.sharedAPIMaster.postEditProfileAPICall_Completion(params: paramer, showLoader: true, enableInteraction: false, viewObj: (Global.appDelegate.navigation?.view)!) { (result) in
            print(result)
            
            let res = JSON(result)
            // print(res)
            if let Flag = res["status"].int,Flag == 200 {
                Singleton.sharedSingleton.saveToUserDefaults(value: UserName, forKey: Global.g_UserDefaultKey.User_Name)
                if let userName = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.User_Name){
                    self.txtUserName.text = userName
                }
                Singleton.sharedSingleton.showSuccessAlert(withMsg: res["message"].string ?? "Users Data Updated Successfully.")
               
                
            }
            
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

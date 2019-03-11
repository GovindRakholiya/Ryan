//
//  LoginViewController.swift
//  Rynn
//
//  Created by Govind Rakholiya on 17/09/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase
import GoogleSignIn
import FacebookCore
import FacebookLogin
import StoreKit

class LoginViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var viewFacebook: UIView!
    @IBOutlet weak var viewGoogle: UIView!
    
    let loginManager = LoginManager()
    
     var FaceBookSigndata = ShareUser()
    //MARK:-  ViewControllers Native methods
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
       
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        Singleton.sharedSingleton.setCornerRadius(view: btnLogin, radius: btnLogin.frame.size.height / 2)
        Singleton.sharedSingleton.setShadow(to: viewFacebook)
        Singleton.sharedSingleton.setShadow(to: viewGoogle)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.isMovingToParentViewController {
            
            if (Global.kretriUserData().IsLoggedIn!.toBool())  {
                
                RazeFaceProducts.store.requestProducts { (isSucess, products) in
                    if (isSucess){
                        if (products?.count == 0){
                            let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                            
                            selctPlanVC.isBackButtonNeeded = false
                            
                            self.navigationController?.pushViewController(selctPlanVC, animated: false)
                        }
                        for pro : SKProduct in products!{
                            print(pro.productIdentifier)
                            if (RazeFaceProducts.store.isProductPurchased(pro.productIdentifier)){
                                Global.appDelegate.ConfigureTabbarAgent(animated: false)
                                return
                            }
                        }
                        let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                        
                        selctPlanVC.isBackButtonNeeded = false
                        
                        self.navigationController?.pushViewController(selctPlanVC, animated: false)
                        
                    }else{
                        let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                        
                        selctPlanVC.isBackButtonNeeded = false
                        
                        self.navigationController?.pushViewController(selctPlanVC, animated: false)
                    }
                    
                }
                
//                if RazeFaceProducts.store.isProductPurchased(RazeFaceProducts.MonthlyIAP){
//
//                    Global.appDelegate.ConfigureTabbarAgent(animated: false)
//                }else if RazeFaceProducts.store.isProductPurchased(RazeFaceProducts.YearlyIAP){
//                    Global.appDelegate.ConfigureTabbarAgent(animated: false)
//                }else{
//                    let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
//
//                    selctPlanVC.isBackButtonNeeded = false
//
//                    self.navigationController?.pushViewController(selctPlanVC, animated: false)
//
//                }
                
            }
            

        }else{
            print("LogOut")
        }
    }
    //MARK:-  Button Press Event 
    
    //MARK:-  Gmail Integration 
    @IBAction func btnViewGooglePressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    //MARK:-  Google Integration
    
    func sign(_: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
        //print("Sign in presented")
    }
    // Dismiss the "Sign in with Google" view
    func sign(_: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            
            let userId = user.userID                  // For client-side use only!
            
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            
            
            var  paramer: [String: Any] = [:]
           
            paramer["login_type"] =  Global.socialMediaUserType.google
            paramer["name"] = fullName
            paramer["login_id"] =  userId
            AFAPIMaster.sharedAPIMaster.postSocialSignUpCall_Completion(params: paramer, showLoader: true, enableInteraction: false, viewObj: self.view) { (response) in
                
                let res = JSON(response)
                
                if let Flag = res["status"].int,Flag == 200 {
                    if let data = res["result"] as? JSON
                    {
                        _ = userDetail(UserData: data)
                        Singleton.sharedSingleton.saveToUserDefaults(value: "true", forKey: Global.kLoggedInUserKey.IsLoggedIn)
                        
                        RazeFaceProducts.store.requestProducts { (isSucess, products) in
                            if (isSucess){
                                if (products?.count == 0){
                                    let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                                    
                                    selctPlanVC.isBackButtonNeeded = false
                                    
                                    self.navigationController?.pushViewController(selctPlanVC, animated: false)
                                }
                                for pro : SKProduct in products!{
                                    print(pro.productIdentifier)
                                    if (RazeFaceProducts.store.isProductPurchased(pro.productIdentifier)){
                                        Global.appDelegate.ConfigureTabbarAgent(animated: false)
                                        return
                                    }
                                }
                                let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                                
                                selctPlanVC.isBackButtonNeeded = false
                                
                                self.navigationController?.pushViewController(selctPlanVC, animated: false)
                                
                            }else{
                                let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                                
                                selctPlanVC.isBackButtonNeeded = false
                                
                                self.navigationController?.pushViewController(selctPlanVC, animated: false)
                            }
                            
                        }
//                        Global.appDelegate.ConfigureTabbarAgent(animated: false)
                        
                    }
                    
                }
                
                
            }
            
            
            
            
            // ...
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    //MARK:-  Facebook integration 
    @IBAction func btnViewFacebookPressed(_ sender: Any) {
        
        self.view.endEditing(true)
        
        loginManager.logOut()
        if let currentAccessToken = AccessToken.current, currentAccessToken.appId != SDKSettings.appId
        {
            loginManager.logOut()
        }
        
        Singleton.sharedSingleton.showLoader(viewObj: self.view)
        
       loginManager.loginBehavior = .web
        
        loginManager.logIn(readPermissions: [ReadPermission.email, .publicProfile], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                Singleton.sharedSingleton.hideLoader(viewObj: self.view)
                print(error)
            case .cancelled:
                print("User cancelled login.")
                Singleton.sharedSingleton.hideLoader(viewObj: self.view)
            case .success( _, _, _):
                print("Logged in!")
                
                
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email,age_range, updated_time, verified, birthday"]).start { (urlResponse, requestResult) in
                    switch requestResult {
                    case .success(let response):
                        
                        print("Custom Graph Request Succeeded: \(response)")
                        //                        let data = ShareUser()
                        
                        self.FaceBookSigndata.strFBId = response.dictionaryValue!["id"] as? String ?? ""
                        self.FaceBookSigndata.strFname = "\(response.dictionaryValue!["first_name"] as?  String ?? "")"
                        self.FaceBookSigndata.strLname = "\(response.dictionaryValue!["last_name"] as? String ?? "")"
                        
                        self.FaceBookSigndata.strEmailId = response.dictionaryValue!["email"] as? String ?? ""
                        if let dict = response.dictionaryValue!["picture"] as? NSDictionary {
                            self.FaceBookSigndata.strProfileImg = dict.value(forKeyPath: "data.url") as? String ?? ""
                        }
                        
                        Singleton.sharedSingleton.hideLoader(viewObj: self.view)
                        self.facebookLoginCall()
                        
                        
                    case .failed(let error):
                        Singleton.sharedSingleton.hideLoader(viewObj: self.view)
                        print("Custom Graph Request Failed: \(error)")
                    }
                }
            }
        }
    }
    
    
    func facebookLoginCall()  {
        //user.isAbove18 = true //FOR TEMP USER ONLY
        
        
        var  paramer: [String: Any] = [:]
        
        paramer["login_type"] = Global.socialMediaUserType.facebook
        paramer["name"] = "\(FaceBookSigndata.strFname) \(FaceBookSigndata.strLname)"
        paramer["login_id"] = FaceBookSigndata.strFBId
       
        AFAPIMaster.sharedAPIMaster.postSocialSignUpCall_Completion(params: paramer, showLoader: true, enableInteraction: false, viewObj: self.view) { (response) in
            
            let res = JSON(response)
            print(res)
            if let Flag = res["status"].int,Flag == 200 {
                if let data = res["result"] as? JSON
                {
                    _ = userDetail(UserData: data)
                    Singleton.sharedSingleton.saveToUserDefaults(value: "true", forKey: Global.kLoggedInUserKey.IsLoggedIn)
//                    Global.appDelegate.ConfigureTabbarAgent(animated: false)
//                    if RazeFaceProducts.store.isProductPurchased(RazeFaceProducts.MonthlyIAP){
//
//                        Global.appDelegate.ConfigureTabbarAgent(animated: false)
//                    }else if RazeFaceProducts.store.isProductPurchased(RazeFaceProducts.YearlyIAP){
//                        Global.appDelegate.ConfigureTabbarAgent(animated: false)
//                    }else{
//                        let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
//
//                        selctPlanVC.isBackButtonNeeded = false
//
//
//                        self.navigationController?.pushViewController(selctPlanVC, animated: false)
//
//                    }
                    
                    
                    
//                    if (Global.kretriUserData().IsLoggedIn!.toBool())  {
                    
                        RazeFaceProducts.store.requestProducts { (isSucess, products) in
                            if (isSucess){
                                if (products?.count == 0){
                                    let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                                    
                                    selctPlanVC.isBackButtonNeeded = false
                                    
                                    self.navigationController?.pushViewController(selctPlanVC, animated: false)
                                }
                                for pro : SKProduct in products!{
                                    print(pro.productIdentifier)
                                    if (RazeFaceProducts.store.isProductPurchased(pro.productIdentifier)){
                                        Global.appDelegate.ConfigureTabbarAgent(animated: false)
                                        return
                                    }
                                }
                                let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                                
                                selctPlanVC.isBackButtonNeeded = false
                                
                                self.navigationController?.pushViewController(selctPlanVC, animated: false)
                                
                            }else{
                                let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                                
                                selctPlanVC.isBackButtonNeeded = false
                                
                                self.navigationController?.pushViewController(selctPlanVC, animated: false)
                            }
                            
                        }
                        //                if RazeFaceProducts.store.isProductPurchased(RazeFaceProducts.MonthlyIAP){
                        //
                        //                    Global.appDelegate.ConfigureTabbarAgent(animated: false)
                        //                }else if RazeFaceProducts.store.isProductPurchased(RazeFaceProducts.YearlyIAP){
                        //                    Global.appDelegate.ConfigureTabbarAgent(animated: false)
                        //                }else{
                        //                    let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                        //
                        //                    selctPlanVC.isBackButtonNeeded = false
                        //
                        //                    self.navigationController?.pushViewController(selctPlanVC, animated: false)
                        //
                        //                }
                    
//                    }
                    
                }
                
            }
            
            
        }
        
    }
    
    
    @IBAction func btnLoginPressed(_ sender: Any) {
        
        let strEmail = txtEmail.text!.trimmingCharacters(in: .whitespaces)
        
        let strPassword = txtPassword.text!.trimmingCharacters(in: .whitespaces)
        
        
        
        guard strEmail.count > 0 else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.SignUpAlert.NO_EMAIL)
            return
        }
        guard strEmail.isEmail else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.GeneralAlert.VALID_EMAIL)
            return
        }
        
        guard strPassword.count > 0 else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.SignUpAlert.NO_PASSWORD)
            return
        }
       
        
        Loginall()
        
    }
    @IBAction func btnForgotPasswordPressed(_ sender: Any) {
        
        
        if let viewControllers = self.navigationController?.viewControllers
        {
            if viewControllers.contains(where: {
                return $0 is ForgotPasswordViewController
            })
            {
                
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: ForgotPasswordViewController.self) {
                        self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromRight(), forKey: kCATransition)
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
                
                //Write your code here
            }
            else
            {
                let forgotpasswordVC = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
                self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromRight(), forKey: kCATransition)
                self.navigationController?.pushViewController(forgotpasswordVC, animated: false)
            }
        }
        
    }
    @IBAction func btnSignUpPressed(_ sender: Any) {
        
        
        if let viewControllers = self.navigationController?.viewControllers
        {
            if viewControllers.contains(where: {
                return $0 is SignUpViewController
            })
            {
                
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: SignUpViewController.self) {
                        self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromRight(), forKey: kCATransition)
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
                
                //Write your code here
            }
            else
            {
                let signupVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
                self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromRight(), forKey: kCATransition)
                self.navigationController?.pushViewController(signupVC, animated: false)
            }
        }
        
    }
    
    
    //MARK:-  API Call 
    
    func Loginall()  {
        //user.isAbove18 = true //FOR TEMP USER ONLY
        
        
        var  paramer: [String: Any] = [:]
      
        paramer["email"] = txtEmail.text
        paramer["password"] = txtPassword.text
      
        AFAPIMaster.sharedAPIMaster.postLoginAPICall_Completion(params: paramer, showLoader: true, enableInteraction: false, viewObj: (Global.appDelegate.navigation?.view)!) { (result) in
            let res = JSON(result)
            print(res)
            if let Flag = res["status"].int,Flag == 200 {
                if let data = res["result"] as? JSON
                {
                    
                    let userObj : userDetail = userDetail(UserData: data)
                    
                        Singleton.sharedSingleton.saveToUserDefaults(value: "true", forKey: Global.kLoggedInUserKey.IsLoggedIn)
                    
                    
                    RazeFaceProducts.store.requestProducts { (isSucess, products) in
                        if (isSucess){
                            if (products?.count == 0){
                                let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                                
                                selctPlanVC.isBackButtonNeeded = false
                                
                                self.navigationController?.pushViewController(selctPlanVC, animated: false)
                            }
                            for pro : SKProduct in products!{
                                print(pro.productIdentifier)
                                if (RazeFaceProducts.store.isProductPurchased(pro.productIdentifier)){
                                    Global.appDelegate.ConfigureTabbarAgent(animated: false)
                                    return
                                }
                            }
                            let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                            
                            selctPlanVC.isBackButtonNeeded = false
                            
                            self.navigationController?.pushViewController(selctPlanVC, animated: false)
                            
                        }else{
                            let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
                            
                            selctPlanVC.isBackButtonNeeded = false
                            
                            self.navigationController?.pushViewController(selctPlanVC, animated: false)
                        }
                        
                    }
                    

//                        let planType = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.Plan_Type)
//                        let planStatus = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.plan_status)
//                        let subscriptionExpiryDate = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.subscription_expiry_date)
//
//                        let ExpiryDate : Date = self.convertStringToDate(dateFromAPI: subscriptionExpiryDate ?? "2000-01-01")
//
//
//
//
//                        print(subscriptionExpiryDate)
//                        print(ExpiryDate)
//                        print(self.getDateBfore5Days(dateOfExpiry: ExpiryDate))
//
//                        let FiveDayBeforeExpiryDate : Date = self.getDateBfore5Days(dateOfExpiry: ExpiryDate)
//
//                        if (subscriptionExpiryDate == "") || ( FiveDayBeforeExpiryDate < Date() ){
//
//                            let selctPlanVC : SelectPlanViewController = SelectPlanViewController(nibName: "SelectPlanViewController", bundle: nil)
//                            self.navigationController?.pushViewController(selctPlanVC, animated: false)
//                        }
//                        else{
//                            Global.appDelegate.ConfigureTabbarAgent(animated: false)
//                        }


                  
                    
                    
//                    Global.appDelegate.ConfigureTabbarAgent(animated: false)
                    
                }
            }
        }
        
    }
    
    
//
    
    func convertStringToDate(dateFromAPI : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = dateFormatter.date(from: dateFromAPI) else {
           
            return Date()
        }
        return date
    }
    
    
    func getDateBfore5Days(dateOfExpiry : Date) -> Date  {
        let DaysToAdd = -5
//        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = DaysToAdd
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: dateOfExpiry)
        
        
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatterGet.date(from: futureDate?.description ?? "0000-00-00 00:00:00 +000") {
            return date
//            return dateFormatterPrint.string(from: date)
//            print(dateFormatterPrint.string(from: date))
        } else {
            return Date()
//            return ""
//            print("There was an error decoding the string")
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        txtPassword.text = ""
        txtEmail.text = ""
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

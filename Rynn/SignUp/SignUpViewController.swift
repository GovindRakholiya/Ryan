//
//  SignUpViewController.swift
//  Rynn
//
//  Created by Govind Rakholiya on 20/09/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit
import SwiftyJSON

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var btnSignUp: UIButton!
    
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    @IBOutlet weak var txtUserName: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        Singleton.sharedSingleton.setCornerRadius(view: btnSignUp, radius: btnSignUp.frame.size.height / 2)
    }
    //MARK:-  API CALL 
    
    
    func Signupcall(UserName : String,UserEmail : String,UserPasswoprd : String)  {
        //user.isAbove18 = true //FOR TEMP USER ONLY
        
        
        var  paramer: [String: Any] = [:]
        
//        paramer["name"] =  UserName
        paramer["name"] =  "A"
        paramer["email"] = UserEmail
        paramer["password"] = UserPasswoprd
        
        AFAPIMaster.sharedAPIMaster.postRegistrationCall_Completion(params: paramer, showLoader: true, enableInteraction: false, viewObj: (Global.appDelegate.navigation?.view)!) { (result) in
            //   print(result)
            
            let res = JSON(result)
            
            if let Flag = res["status"].int,Flag == 200 {
                Singleton.sharedSingleton.showSuccessAlert(withMsg: res["message"].string ?? "Registration Successfull")
                
                self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromLeft(), forKey: kCATransition)
                self.navigationController?.popViewController(animated: false)
                
            }
            
        }
        
        
    }
    
    //MARK:-  Button Pressed
    @IBAction func btnSignUpPressed(_ sender: Any) {
        
        let strUserName = txtUserName.text!.trimmingCharacters(in: .whitespaces)
        
        let strEmail = txtEmailAddress.text!.trimmingCharacters(in: .whitespaces)
        let strPassword = txtPassword.text!.trimmingCharacters(in: .whitespaces)
        let strConfirmPassword = txtConfirmPassword.text!.trimmingCharacters(in: .whitespaces)
        
        guard strEmail.count > 0 else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.SignUpAlert.NO_EMAIL)
            return
        }
        guard strEmail.isEmail else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.GeneralAlert.VALID_EMAIL)
            return
        }
//        guard strUserName.count > 0 else {
//            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.SignUpAlert.NO_USERNAME)
//            return
//        }
        guard strPassword.count > 0 else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.SignUpAlert.NO_PASSWORD)
            return
        }
        guard Singleton.sharedSingleton.Passwordvalidate(password: strPassword) else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.GeneralAlert.VALID_PASSWORD)
            return
        }
        guard strPassword == strConfirmPassword else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.GeneralAlert.PASSWORD_NOT_MATCH)
            return
        }
        
        
        Signupcall(UserName: strUserName, UserEmail: strEmail, UserPasswoprd: strPassword)
        
        //        let dashboardVC = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
        //        self.navigationController?.pushViewController(dashboardVC, animated: false)
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
    @IBAction func btnLoginPressed(_ sender: Any) {
        
        if let viewControllers = self.navigationController?.viewControllers
        {
            if viewControllers.contains(where: {
                return $0 is LoginViewController
            })
            {
                
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: LoginViewController.self) {
                        self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromLeft(), forKey: kCATransition)
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
                
                //Write your code here
            }
            else
            {
                let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromLeft(), forKey: kCATransition)
                self.navigationController?.pushViewController(loginVC, animated: false)
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

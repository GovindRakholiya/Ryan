//
//  ForgotPasswordViewController.swift
//  Rynn
//
//  Created by Govind Rakholiya on 17/09/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit
import SwiftyJSON

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        Singleton.shared.setCornerRadius(view: btnUpdate, radius: btnUpdate.frame.size.height / 2)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnUpdatePressed(_ sender: Any) {
         let strEmail = txtEmail.text!.trimmingCharacters(in: .whitespaces)
        
        guard strEmail.count > 0 else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.SignUpAlert.NO_EMAIL)
            return
        }
        guard strEmail.isEmail else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: AlertStrings.GeneralAlert.VALID_EMAIL)
            return
        }
        ForgotPasswordCall()
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
    
    
    //MARK:-  API CALL 
    
    
    func ForgotPasswordCall()  {
        //user.isAbove18 = true //FOR TEMP USER ONLY
        
        
        var  paramer: [String: Any] = [:]
        paramer["email"] = txtEmail.text
        
        
        AFAPIMaster.sharedAPIMaster.postForgotPasswordAPICall_Completion(params: paramer, showLoader: true, enableInteraction: false, viewObj: (Global.appDelegate.navigation?.view)!) { (result) in
            print(result)
            
            let res = JSON(result)
            // print(res)
            if let Flag = res["status"].int,Flag == 200 {
                    Singleton.sharedSingleton.showSuccessAlert(withMsg: res["message"].string ?? "Password reset link has been sent to your registered email")
                self.navigationController!.view.layer.add(Singleton.sharedSingleton.TransitionFromLeft(), forKey: kCATransition)
                 self.navigationController?.popToRootViewController(animated: false)
                
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

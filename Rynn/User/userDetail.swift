//
//  userDetail.swift
//  3YApp
//
//  Created by Govind Rakholiya on 31/08/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit
import SwiftyJSON
class userDetail {
    init() {}
    var apiToken        = ""
    var birthDate       = ""
    var contactNumber   = ""
    var companyName     = ""
    var stripeToken     = ""
    var userProfilePic  = ""
    var useremail       = ""
    var userId          = ""
    var userMobile      = ""
    var userName        = ""
    var expire_date        = ""
    var subscriptionExpiryDate = ""
    var plan_type = ""
    var plan_status = ""
    var referralCode = ""
    var is_free = ""
    
    convenience init(UserData : JSON) {
        self.init()
        if let X = UserData["token"].string{
            apiToken = X
            Singleton.sharedSingleton.saveToUserDefaults(value: apiToken, forKey: Global.g_UserDefaultKey.DeviceToken)
            
        }
        
        if let X = UserData["is_free"].string{
            is_free = X
            Singleton.sharedSingleton.saveToUserDefaults(value: is_free, forKey: Global.g_UserDefaultKey.is_free)
            
        }
        
        if let X = UserData["expire_date"].string{
            subscriptionExpiryDate = X
            Singleton.sharedSingleton.saveToUserDefaults(value: subscriptionExpiryDate, forKey: Global.g_UserDefaultKey.subscription_expiry_date)
            
        }
        
        if let X = UserData["plan_type"].int{
            plan_type = X.description
            Singleton.sharedSingleton.saveToUserDefaults(value: plan_type, forKey: Global.g_UserDefaultKey.Plan_Type)
            
        }
        
        if let X = UserData["plan_status"].int{
            plan_status = X.description
            Singleton.sharedSingleton.saveToUserDefaults(value: plan_status, forKey: Global.g_UserDefaultKey.plan_status)
            
        }
        
        if let X = UserData["birth_date"].string{
            birthDate = X
            Singleton.sharedSingleton.saveToUserDefaults(value:birthDate, forKey: Global.g_UserDefaultKey.Birth_Date)
        }
        
        if let X = UserData["contact_no"].string{
            contactNumber = X
            Singleton.sharedSingleton.saveToUserDefaults(value:contactNumber, forKey: Global.g_UserDefaultKey.Contact_Number)
        }
        
        if let X = UserData["id"].int{
            userId = X.description
            Singleton.sharedSingleton.saveToUserDefaults(value:userId, forKey: Global.g_UserDefaultKey.User_Id)
            UserDefaults.standard.synchronize()
            
//            print(userId)
//            print(Global.userId)
        }
        
        if let X = UserData["company_name"].string{
            companyName = X
            Singleton.sharedSingleton.saveToUserDefaults(value:companyName , forKey: Global.g_UserDefaultKey.Compny_Name)
        }
        if let X = UserData["Stripe_Token"].string{
            stripeToken = X
            Singleton.sharedSingleton.saveToUserDefaults(value:stripeToken , forKey: Global.g_UserDefaultKey.Stripe_Token)
        }
        
        
        if let X = UserData["name"].string{
            userName = X
            Singleton.sharedSingleton.saveToUserDefaults(value:userName, forKey: Global.g_UserDefaultKey.User_Name)
        }
        
        if let X = UserData["expire_date"].string{
            expire_date = X
            Singleton.sharedSingleton.saveToUserDefaults(value:expire_date, forKey: Global.g_UserDefaultKey.subscription_expiry_date)
        }
        
        
        if let X = UserData["email"].string{
            useremail = X
            Singleton.sharedSingleton.saveToUserDefaults(value:useremail, forKey: Global.g_UserDefaultKey.User_Email)
        }
        
    }
}


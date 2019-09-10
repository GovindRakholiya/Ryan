//
//  AppDelegate.swift
//  Rynn
//
//  Created by Govind Rakholiya on 17/09/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SWRevealViewController
//import FBSDKLoginKit
//import FBSDKCoreKit
import FacebookLogin
import FacebookCore
import SwiftyJSON
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,SWRevealViewControllerDelegate,UITabBarControllerDelegate,GIDSignInDelegate {

    var window: UIWindow?
    var navigation : UINavigationController?
  //  var orientationLock = UIInterfaceOrientationMask.all

    var DashboardObj : DashboardViewController? // First Tab
    var ExpenseListObj : ExpenseListViewController? // Second Tab
    var ExpenseListOtherObj : EarningListViewController? // Third Tab
    var myAccountObj : MyAccountViewController? // Fourth Tab
    var tabBarController: UITabBarCustom!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if ((UserDefaults.standard.value(forKey: "FIRSTTIME")) != nil){
            print("Already There")
        }else{
            RazeFaceProducts.store.restorePurchases()
            UserDefaults.standard.set(1, forKey: "FIRSTTIME")
            
        }
       
        IQKeyboardManager.shared.enable = true
        
        FirebaseApp.configure() // FireBase Configuration
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
//        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
//        SDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        // Override point for customization after application launch.
        setNavigation()
        return true
    }

    
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        return self.orientationLock
//    }
    
    
    func logOutUser() {
        Singleton.sharedSingleton.saveToUserDefaults(value: "false", forKey: Global.kLoggedInUserKey.IsLoggedIn)
        
        Singleton.sharedSingleton.saveToUserDefaults(value:  "" , forKey: Global.g_UserDefaultKey.DeviceToken)
        
        
        Singleton.sharedSingleton.saveToUserDefaults(value:  "" , forKey: Global.g_UserDefaultKey.User_Name)
        
        Singleton.sharedSingleton.saveToUserDefaults(value: "" , forKey: Global.g_UserDefaultKey.User_Email)
        
        Singleton.sharedSingleton.saveToUserDefaults(value: "" , forKey: Global.g_UserDefaultKey.User_Profile_Pic)
        self.navigation?.popToRootViewController(animated: false)
    }
    
    
    func setNavigation() {
//        let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
        if (Global.kretriUserData().IsLoggedIn!.toBool())  {
            let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
            navigation = UINavigationController(rootViewController: login)
            navigation?.isNavigationBarHidden = true
            window?.rootViewController = navigation
            window?.makeKeyAndVisible()
        }else{
            let login = introductionViewController(nibName: "introductionViewController", bundle: nil)
            login.isBackButtonNeeded = false
            navigation = UINavigationController(rootViewController: login)
            navigation?.isNavigationBarHidden = true
            window?.rootViewController = navigation
            window?.makeKeyAndVisible()
        }
        
        
    }
    
    
    //MARK:-  Manage TabBar 
    
    func  ConfigureTabbarAgent(animated:Bool) -> Void {
        self.gotoDetailAppAgent(0)
        //Singleton.sharedSingleton.saveToUserDefaults(value: "true", forKey: Global.kLoggedInUserKey.IsAddAddress)
        self.navigation?.pushViewController(self.tabBarController!, animated: animated)
    }
    
    func gotoDetailAppAgent(_ pintTabId: Int) {
        self.setTabBarForAgent()
        self.tabBarController?.delegate = self
        self.tabBarController?.selectedIndex = pintTabId
        self.tabBarController?.selectTab(pintTabId)
    }
    
    func setTabBarForAgent() {
        
       
        
        self.tabBarController = UITabBarCustom()
        // first
        DashboardObj = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
        let navDashboard    = UINavigationController(rootViewController: DashboardObj!)
        
        //second
        ExpenseListObj = ExpenseListViewController(nibName: "ExpenseListViewController", bundle: nil)
        let navExpense = UINavigationController(rootViewController: ExpenseListObj!)
        
        //Third
        
        ExpenseListOtherObj = EarningListViewController(nibName: "EarningListViewController", bundle: nil)
        let navExpenseOther = UINavigationController(rootViewController: ExpenseListOtherObj!)
        //forth
        myAccountObj = MyAccountViewController(nibName: "MyAccountViewController", bundle: nil)
        let navMyAccount = UINavigationController(rootViewController: myAccountObj!)
        
        
        
        self.tabBarController?.viewControllers = [navDashboard,navExpense,navExpenseOther,navMyAccount]
        navDashboard.isNavigationBarHidden = true
        navExpense.isNavigationBarHidden = true
        navExpenseOther.isNavigationBarHidden = true
        navMyAccount.isNavigationBarHidden = true
        
    }
    
//    @available(iOS 9.0, *)
//    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
//        -> Bool {
//            return GIDSignIn.sharedInstance().handle(url,
//                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
//                                                     annotation: [:])
//    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if (url.scheme?.hasPrefix("fb"))! {
//            return FBSDKApplicationDelegate.sharedInstance().application(app, didFinishLaunchingWithOptions: options)
            
           
             return SDKApplicationDelegate.shared.application(app, open: url, options: options)
            
        }
        else
        {
            return GIDSignIn.sharedInstance().handle(url as URL?, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        }
        //        return GIDSignIn.sharedInstance().handle(url,
        //                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
        //                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
    }
    
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        return GIDSignIn.sharedInstance().handle(url,
//                                                 sourceApplication: sourceApplication,
//                                                 annotation: annotation)
//    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


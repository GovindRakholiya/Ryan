//
//  SelectPlanViewController.swift
//  Rynn
//
//  Created by Govind Rakholiya on 26/12/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyJSON
import SVProgressHUD

class SelectPlanViewController: UIViewController {
   
    @IBOutlet weak var lblOneTimePurchasedSucessfully: UILabel!
    @IBOutlet weak var lblOneTimePrice: UILabel!
    @IBOutlet weak var lblDailyBudget: UILabel!
    @IBOutlet weak var lblMinutesGetstarted: UILabel!
    @IBOutlet weak var lblSafeData: UILabel!
    @IBOutlet weak var lblFinancialDecision: UILabel!
    
    @IBOutlet weak var viewOneTime: UIView!
    
    
    @IBOutlet weak var btnBack: UIButton!
    var isBackButtonNeeded : Bool = false
    
    var selectedPlan : Int = 2 // 0-- Not Selected , 1-- Monthly , 2--Yearly
    @IBOutlet weak var lblMonthlyPurchasedStatus: UILabel!
    @IBOutlet weak var lblYearlyPrice: UILabel!
    @IBOutlet weak var lblMonthlyPrice: UILabel!
    @IBOutlet weak var lblPlanExpiryDate: UILabel!
    @IBOutlet weak var lblSave10Percent: UILabel!
    @IBOutlet weak var btnFreeFor30Days: UIButton!
    @IBOutlet weak var viewYearly: UIView!
    @IBOutlet weak var viewMonthly: UIView!
    
    //MARK:- In App Purchase
    var productsArray: [SKProduct] = []
    var isPurchased : Bool = false
    var priceOfProduct : String = ""
    
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    
    
    func priceStringForProduct(item: SKProduct) -> String? {
        let price = item.price
        if price == NSDecimalNumber(decimal: 0.00) {
            return "GET" //or whatever you like really... maybe 'Free'
        } else {
            let numberFormatter = NumberFormatter()
            let locale = item.priceLocale
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = locale
            return numberFormatter.string(from: price)
        }
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnTermsandconditionsPressed(_ sender: Any) {
        if let url = URL(string: "https://termsfeed.com/terms-conditions/94691551f7b46e735fc30bb9feb30766") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func fetchProductDetail() {
        var productArray: [SKProduct] = []
        RazeFaceProducts.store.requestProducts{ [weak self] success, products in
            
            if success {
                productArray = products!
                self?.productsArray = productArray
                print(productArray)
                
                for pro in productArray{
                    
                    if (pro.productIdentifier == RazeFaceProducts.MonthlyIAP){
//                        let price : String = SelectPlanViewController.priceFormatter.string(from: pro.price)!
                        let price : String = self!.priceStringForProduct(item: pro) ?? "0.0"
                        
                        DispatchQueue.main.async {
                            self?.lblMonthlyPrice.text = price
                        }
                        
                        if RazeFaceProducts.store.isProductPurchased(pro.productIdentifier) {
                            DispatchQueue.main.async {
                                self?.lblMonthlyPurchasedStatus.text = "Purchased"
                            }
                            
                            self?.selectMonthView()
                        }else{
                            DispatchQueue.main.async {
                                self?.lblMonthlyPurchasedStatus.text = "Buy"
                            }
                            
                            
                        }
                    }
                    
                    
                    if (pro.productIdentifier == RazeFaceProducts.YearlyIAP){
//                        let price : String = SelectPlanViewController.priceFormatter.string(from: pro.price)!
                        let price : String = self!.priceStringForProduct(item: pro) ?? "0.0"
                        DispatchQueue.main.async {
                            self?.lblOneTimePrice.text = price
                        }
                        
                        if RazeFaceProducts.store.isProductPurchased(pro.productIdentifier) {
                            DispatchQueue.main.async {
                                self?.lblOneTimePurchasedSucessfully.text = "Purchased"
                            }
                            
                            self?.selectYearView()
                        }else{
                            DispatchQueue.main.async {
                                self?.lblOneTimePurchasedSucessfully.text = "Buy"
                            }
                            
                        }
                    }
                    
//                    if RazeFaceProducts.store.isProductPurchased(pro.productIdentifier) {
//                        print(pro.price)
//                        self?.isPurchased = true
//                        SelectPlanViewController.priceFormatter.locale = pro.priceLocale
//                        let price : String = SelectPlanViewController.priceFormatter.string(from: pro.price)!
//
//                        self?.priceOfProduct = price
//
//                        self?.lblSave10Percent.text = "\(price) Purchased"
//                    }else{
//                        self?.isPurchased = false
//                        print(pro.price)
//                    }

                }
//                if (productArray.count > 0){
//                    let pro : SKProduct = productArray[0]
//                    if RazeFaceProducts.store.isProductPurchased(pro.productIdentifier) {
//                        print(pro.price)
//                        self?.isPurchased = true
//                        SelectPlanViewController.priceFormatter.locale = pro.priceLocale
//                        let price : String = SelectPlanViewController.priceFormatter.string(from: pro.price)!
//
//                        self?.priceOfProduct = price
//
//                        self?.lblSave10Percent.text = "\(price) Purchased"
//                    }else{
//                        self?.isPurchased = false
//                        print(pro.price)
//                    }
//
//                }
                
            }else{
                if (productArray.count > 0){
                    let pro : SKProduct = productArray[0]
                    SelectPlanViewController.priceFormatter.locale = pro.priceLocale
//                    let price : String = SelectPlanViewController.priceFormatter.string(from: pro.price)!
                    let price : String = self!.priceStringForProduct(item: pro) ?? "0.0"
                    self?.priceOfProduct = price
                    
                    self?.isPurchased = false
                    
                    self?.lblSave10Percent.text = "\(price) Not Purchased"
                }
                
            }
            
        }
    }
    
    
    @IBAction func btnPrivacyPolicyPressed(_ sender: Any) {
        if let url = URL(string: "https://termsfeed.com/privacy-policy/3f7a8ca145d3fa6bb420e18cb5a04a4b") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        fetchProductDetail()
    }
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        lblDailyBudget.text = "\u{2022} Live for today with your daily budget"
        lblDailyBudget.text = "If you want to be bombarded by reminders, annoyed by account syncing errors, and share all your personal data with a large corporation, you are in the wrong spot!"
        lblMinutesGetstarted.text = "Our Promise"
        lblSafeData.text = "You experience positive financial change by using the app daily for 1 month. If not, let us know and we donate the profit to charity."
//        lblFinancialDecision.text = "\u{2022} A simple,powerful,rewarding way to track your financial decisions"
        lblFinancialDecision.text = ""
        
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        Singleton.sharedSingleton.setCornerRadius(view: viewYearly, radius: 5.0)
        Singleton.sharedSingleton.setCornerRadius(view: btnFreeFor30Days, radius: btnFreeFor30Days.frame.size.height / 2)
        
        if (btnBack.isHidden == true){
            if (selectedPlan == 1){
                selectMonthView()
            }else{
                selectYearView()
            }
        }
        
//        Singleton.sharedSingleton.setCornerRadius(view: viewMonthly, radius: 5.0)
//        viewMonthly.layer.borderColor = UIColor.darkGray.cgColor
//        viewMonthly.layer.borderWidth = 2.0
//
//        Singleton.sharedSingleton.setCornerRadius(view: viewOneTime, radius: 5.0)
//        viewOneTime.layer.borderColor = UIColor.darkGray.cgColor
//        viewOneTime.layer.borderWidth = 2.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            if (self.isBackButtonNeeded == true){
                self.btnBack.isHidden = false
            }else{
                self.btnBack.isHidden = true
                self.selectNormalView()
            }
        }
      
    }
    
    
    func convertStringToDate(dateFromAPI : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = dateFormatter.date(from: dateFromAPI) else {
            
            return Date()
        }
        return date
    }
    
    func selectMonthView() {
        
        DispatchQueue.main.async {
            Singleton.sharedSingleton.setCornerRadius(view: self.viewMonthly, radius: 5.0)
            self.viewMonthly.layer.borderColor = UIColor.darkGray.cgColor
            self.viewMonthly.layer.borderWidth = 2.0
            
            Singleton.sharedSingleton.setCornerRadius(view: self.viewOneTime, radius: 5.0)
            self.viewOneTime.layer.borderColor = UIColor.clear.cgColor
            self.viewOneTime.layer.borderWidth = 2.0
        }
        
        

    }
    func selectYearView() {

        DispatchQueue.main.async {
            Singleton.sharedSingleton.setCornerRadius(view: self.viewMonthly, radius: 5.0)
            self.viewMonthly.layer.borderColor = UIColor.clear.cgColor
            self.viewMonthly.layer.borderWidth = 2.0
            
            Singleton.sharedSingleton.setCornerRadius(view: self.viewOneTime, radius: 5.0)
            self.viewOneTime.layer.borderColor = UIColor.darkGray.cgColor
            self.viewOneTime.layer.borderWidth = 2.0
        }
        
    }
    
    
    func selectNormalView() {
        DispatchQueue.main.async {
            Singleton.sharedSingleton.setCornerRadius(view: self.viewMonthly, radius: 5.0)
            self.viewMonthly.layer.borderColor = UIColor.clear.cgColor
            self.viewMonthly.layer.borderWidth = 2.0
            
            Singleton.sharedSingleton.setCornerRadius(view: self.viewOneTime, radius: 5.0)
            self.viewOneTime.layer.borderColor = UIColor.clear.cgColor
            self.viewOneTime.layer.borderWidth = 2.0
        }
        
    }
    
    @IBAction func btnMonthlyPayPressed(_ sender: Any) {
        
        selectedPlan = 1
        DispatchQueue.main.async {
            self.selectMonthView()
        }
        
        
        
        
//         let subscriptionExpiryDate = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.subscription_expiry_date)
//
//        let ExpiryDate : Date = self.convertStringToDate(dateFromAPI: subscriptionExpiryDate ?? "2000-01-01")
//        if (ExpiryDate > Date()){
//           Singleton.sharedSingleton.showSuccessAlert(withMsg: "You are using Free Trial Please press button Of Free Trial and enjoy Free Trial")
//        }else{
//            if (Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.is_free) == "1"){
//                for pro in productsArray {
//                    if (pro.productIdentifier == RazeFaceProducts.MonthlyIAP){
//                        RazeFaceProducts.store.buyProduct(pro)
//                    }
//                }
//            }else{
//                subscribeFreePlan()
//            }
//        }
//
    }
    @IBAction func btnYearlyPayPressed(_ sender: Any) {
        selectedPlan = 2
        DispatchQueue.main.async {
            self.selectYearView()
        }
       
        
    }
    
    @IBAction func btnTryFor30DayPressed(_ sender: Any) {
       
        
        if (selectedPlan == 0){
            Singleton.sharedSingleton.showWarningAlert(withMsg: "Please select a plan")
            return
        }else if (selectedPlan == 1){
            SVProgressHUD.show()
            for pro in productsArray {
                if (pro.productIdentifier == RazeFaceProducts.MonthlyIAP){
                    RazeFaceProducts.store.buyProduct(pro)
                }
            }
        }else if (selectedPlan == 2){
            SVProgressHUD.dismiss()
            for pro in productsArray {
                if (pro.productIdentifier == RazeFaceProducts.YearlyIAP){
                    RazeFaceProducts.store.buyProduct(pro)
                }
            }
        }
//        let subscriptionExpiryDate = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.subscription_expiry_date)
//
//        let ExpiryDate : Date = self.convertStringToDate(dateFromAPI: subscriptionExpiryDate ?? "2000-01-01")
//
//        lblPlanExpiryDate.text = " Your Subscription Expiry Date is \(String(describing: subscriptionExpiryDate!))"
//        if (subscriptionExpiryDate != ""){
//            if (ExpiryDate > Date()){
//                Global.appDelegate.ConfigureTabbarAgent(animated: false)
//            }
//            else{
//                Singleton.sharedSingleton.showWarningAlert(withMsg: "Your plan is already expired.. please do payment")
//            }
//        }else{
//             subscribeFreePlan()
//        }
//
    }
    
    @IBAction func btnRestorePurchasePressed(_ sender: Any) {
        SVProgressHUD.show()
        RazeFaceProducts.store.restorePurchases()
    }
    func subscribeFreePlan()  {
        //user.isAbove18 = true //FOR TEMP USER ONLY
        
        
        var  paramer: [String: Any] = [:]
        
        let deviceToken = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.DeviceToken) as? String ?? ""
        
        let userId = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.User_Id) as? String ?? ""
        
        
        paramer["token"] = deviceToken
        paramer["user_id"] = userId
        paramer["expire_date"] = getDateAfterMonth()
        paramer["plan_status"] = "1"
        paramer["plan_type"] = "3"
        paramer["is_free"] = "1"
        
        AFAPIMaster.sharedAPIMaster.postSubscriptionAPICall_Completion(params: paramer, showLoader: true, enableInteraction: false, viewObj: (Global.appDelegate.navigation?.view)!) { (result) in
            
            let res = JSON(result)
            if let Flag = res["status"].int,Flag == 200 {
                if let data = res["result"] as? JSON
                {
                    if let isFreeObj : String = data["is_free"].string{
                        Singleton.sharedSingleton.saveToUserDefaults(value: isFreeObj, forKey: Global.g_UserDefaultKey.is_free)
                    }
                    if let planStatusObj : String = data["plan_status"].string{
                        Singleton.sharedSingleton.saveToUserDefaults(value: planStatusObj, forKey: Global.g_UserDefaultKey.plan_status)
                    }
                    if let planTypeObj : String = data["plan_type"].string{
                        Singleton.sharedSingleton.saveToUserDefaults(value: planTypeObj, forKey: Global.g_UserDefaultKey.Plan_Type)
                    }
                    if let expiryDateObj : String = data["expire_date"].string{
                        Singleton.sharedSingleton.saveToUserDefaults(value: expiryDateObj, forKey: Global.g_UserDefaultKey.subscription_expiry_date)
                    }
                    
                    Global.appDelegate.ConfigureTabbarAgent(animated: false)
                    
                }
            }
        }
        
    }

    
    func getDateAfterMonth() -> String  {
        let monthsToAdd = 1
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.month = monthsToAdd
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
       
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatterGet.date(from: futureDate?.description ?? "0000-00-00 00:00:00 +000") {
            return dateFormatterPrint.string(from: date)
            print(dateFormatterPrint.string(from: date))
        } else {
            return ""
            print("There was an error decoding the string")
        }
        
    }
    
    
    //MARK:-  Delegate Of SKProduct
    
    // MARK:- IAP PAYMENT QUEUE
    
    
    
    
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        for transaction:AnyObject in transactions {
//            if let trans = transaction as? SKPaymentTransaction {
//                switch trans.transactionState {
//
//                case .purchased:
//                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
//
//                    print("Purchased")
//
//                    // The Consumable product (10 coins) has been purchased -> gain 10 extra coins!
////                    if productID == COINS_PRODUCT_ID {
////
////                        // Add 10 coins and save their total amount
////                        coins += 10
////                        UserDefaults.standard.set(coins, forKey: "coins")
////                        coinsLabel.text = "COINS: \(coins)"
////
////                        UIAlertView(title: "IAP Tutorial",
////                                    message: "You've successfully bought 10 extra coins!",
////                                    delegate: nil,
////                                    cancelButtonTitle: "OK").show()
////
////
////
////                        // The Non-Consumable product (Premium) has been purchased!
////                    } else if productID == RazeFaceProducts.MonthlyIAP {
////
////                        // Save your purchase locally (needed only for Non-Consumable IAP)
////                        nonConsumablePurchaseMade = true
////                        UserDefaults.standard.set(nonConsumablePurchaseMade, forKey: "nonConsumablePurchaseMade")
////
////                        premiumLabel.text = "Premium version PURCHASED!"
////
////                        UIAlertView(title: "IAP Tutorial",
////                                    message: "You've successfully unlocked the Premium version!",
////                                    delegate: nil,
////                                    cancelButtonTitle: "OK").show()
////                    }
//
//                    break
//
//                case .failed:
//                    print("Failed")
//                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
//                    break
//                case .restored:
//                     print("Restored")
//                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
//                    break
//
//                default: break
//                }}}
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

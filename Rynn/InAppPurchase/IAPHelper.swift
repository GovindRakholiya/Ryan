/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import StoreKit
import SwiftyJSON
import SVProgressHUD

public typealias ProductIdentifier = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> Void

extension Notification.Name {
  static let IAPHelperPurchaseNotification = Notification.Name("IAPHelperPurchaseNotification")
}

open class IAPHelper: NSObject  {
  
  private let productIdentifiers: Set<ProductIdentifier>
  private var purchasedProductIdentifiers: Set<ProductIdentifier> = []
  private var productsRequest: SKProductsRequest?
  private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
  
  public init(productIds: Set<ProductIdentifier>) {
    productIdentifiers = productIds
    for productIdentifier in productIds {
      let purchased = UserDefaults.standard.bool(forKey: productIdentifier)
      if purchased {
        purchasedProductIdentifiers.insert(productIdentifier)
        print("Previously purchased: \(productIdentifier)")
      } else {
        print("Not purchased: \(productIdentifier)")
      }
    }
    super.init()

    SKPaymentQueue.default().add(self)
  }
}

// MARK: - StoreKit API

extension IAPHelper {
  
  public func requestProducts(_ completionHandler: @escaping ProductsRequestCompletionHandler) {
    productsRequest?.cancel()
    productsRequestCompletionHandler = completionHandler

    productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
    productsRequest!.delegate = self
    productsRequest!.start()
  }

  public func buyProduct(_ product: SKProduct) {
    print("Buying \(product.productIdentifier)...")
    SVProgressHUD.show()
    let payment = SKPayment(product: product)
    SKPaymentQueue.default().add(payment)
  }

  public func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
    return purchasedProductIdentifiers.contains(productIdentifier)
  }
  
  public class func canMakePayments() -> Bool {
    return SKPaymentQueue.canMakePayments()
  }
  
  public func restorePurchases() {
    SKPaymentQueue.default().restoreCompletedTransactions()
    
    
  }
}

// MARK: - SKProductsRequestDelegate

extension IAPHelper: SKProductsRequestDelegate {

  public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    print("Loaded list of products...")
    let products = response.products
    productsRequestCompletionHandler?(true, products)
    clearRequestAndHandler()

    for p in products {
      print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
    }
  }

  public func request(_ request: SKRequest, didFailWithError error: Error) {
    print("Failed to load list of products.")
    print("Error: \(error.localizedDescription)")
    productsRequestCompletionHandler?(false, nil)
    clearRequestAndHandler()
  }

  private func clearRequestAndHandler() {
    productsRequest = nil
    productsRequestCompletionHandler = nil
  }
}

// MARK: - SKPaymentTransactionObserver

extension IAPHelper: SKPaymentTransactionObserver {

  public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
      switch (transaction.transactionState) {
      case .purchased:
        complete(transaction: transaction)
       
        break
      case .failed:
        fail(transaction: transaction)
       
        break
      case .restored:
        restore(transaction: transaction)
        
        break
      case .deferred:
        
        break
      case .purchasing:
        break
      }
    }
  }

    
  private func complete(transaction: SKPaymentTransaction) {
    print("complete...")
   
    
    deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
    SKPaymentQueue.default().finishTransaction(transaction)
//    Global.appDelegate.ConfigureTabbarAgent(animated: false)
    if (Global.kretriUserData().IsLoggedIn!.toBool())  {
        
        RazeFaceProducts.store.requestProducts { (isSucess, products) in
            if (isSucess){
                for pro : SKProduct in products!{
                    if (RazeFaceProducts.store.isProductPurchased(pro.productIdentifier)){
                        Global.appDelegate.ConfigureTabbarAgent(animated: false)
                        
                        return
                    }
                }
            }
            
        }
    }
    
    SVProgressHUD.dismiss()
    
  }

    
//    func GetlogCall(_ invoiceID:String,Complete:@escaping(AnyObject)->Void, failure:@escaping(_ is_email:Bool, _ is_Pass:Bool)->Void) -> Void  {
//
//        let userId = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.User_Id) ?? ""
//
//        let accessTokn = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.g_UserDefaultKey.DeviceToken) ?? ""
//
//
//        var  paramer: [String: Any] = [:]
//
//        paramer["log"] =  invoiceID
//        paramer["user_id"] = userId
//
//
//
//        AFAPIMaster.sharedAPIMaster.getMesageApi_Completion(params: paramer, showLoader: false, enableInteraction: false, viewObj: (Global.appDelegate.navigation?.view)!, onSuccess: { (result) in
//            Complete(result as AnyObject)
//        }) {
//            failure(false,false)
//        }
//
//
//    }
    
    
  private func restore(transaction: SKPaymentTransaction) {
    guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }

    print("restore... \(productIdentifier)")
    deliverPurchaseNotificationFor(identifier: productIdentifier)
    
    if (Global.kretriUserData().IsLoggedIn!.toBool())  {
        SKPaymentQueue.default().finishTransaction(transaction)
        SVProgressHUD.dismiss()
        RazeFaceProducts.store.requestProducts { (isSucess, products) in
            for pro : SKProduct in products!{
                if (RazeFaceProducts.store.isProductPurchased(pro.productIdentifier)){
                    Global.appDelegate.ConfigureTabbarAgent(animated: false)
                    
                   
                    
                    
                    return
                }
            }
        }
//        if RazeFaceProducts.store.isProductPurchased(RazeFaceProducts.MonthlyIAP){
//
//            Global.appDelegate.ConfigureTabbarAgent(animated: false)
//
//        }else if RazeFaceProducts.store.isProductPurchased(RazeFaceProducts.YearlyIAP){
//            Global.appDelegate.ConfigureTabbarAgent(animated: false)
//        }else{
//            Singleton.sharedSingleton.showSuccessAlert(withMsg: "Something went wrong.")
//        }
    }
    
    
  }

  private func fail(transaction: SKPaymentTransaction) {
   
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        print("fail...")
        if (Global.kretriUserData().IsLoggedIn!.toBool())  {
            
            RazeFaceProducts.store.requestProducts { (isSucess, products) in
                for pro : SKProduct in products!{
                    if (RazeFaceProducts.store.isProductPurchased(pro.productIdentifier)){
                        Global.appDelegate.ConfigureTabbarAgent(animated: false)
                        
                        
                        
                        return
                    }
                }
            }
        }
    }
   
    SVProgressHUD.dismiss()
    
    if let transactionError = transaction.error as NSError?,
      let localizedDescription = transaction.error?.localizedDescription,
        transactionError.code != SKError.paymentCancelled.rawValue {
//        Singleton.sharedSingleton.showWarningAlert(withMsg: "Transaction Error: \(localizedDescription) Please Login In itunes Account")
        
        print("Transaction Error: \(localizedDescription)")
      }

   
    
    SKPaymentQueue.default().finishTransaction(transaction)
  }

  private func deliverPurchaseNotificationFor(identifier: String?) {
    guard let identifier = identifier else { return }

    purchasedProductIdentifiers.insert(identifier)
    UserDefaults.standard.set(true, forKey: identifier)
    NotificationCenter.default.post(name: .IAPHelperPurchaseNotification, object: identifier)
  }
}

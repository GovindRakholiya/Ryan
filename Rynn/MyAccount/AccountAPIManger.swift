//
//  AccountAPIManger.swift
//  Rynn
//
//  Created by Govind Rakholiya on 29/09/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit

class AccountAPIManger: NSObject {
    func GetEditProfileCall(params: [String:Any]?,Complete:@escaping(AnyObject)->Void, failure:@escaping(_ is_email:Bool, _ is_Pass:Bool)->Void) -> Void  {
        
       
        AFAPIMaster.sharedAPIMaster.getEditProfileApi_Completion(params: params, showLoader: true, enableInteraction: false, viewObj: (Global.appDelegate.navigation?.view)!, onSuccess: { (result) in
            Complete(result as AnyObject)
        }) {
            failure(false,false)
        }
        
    }
}

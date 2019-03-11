//
//  ShareUser.swift
//  Alcohol
//
//  Created by Tops on 1/10/18.
//  Copyright © 2018 Self. All rights reserved.
//

import UIKit
import SwiftyJSON

class ShareUser {
    var strId:String = ""
    var strLoginType = ""
    var strFBId:String = ""
    var strGoogleId:String = ""
    var strFname:String = ""
    var strLname:String = ""
    var strPhone:String = ""
    var isAbove18:Bool = false
    var strState:String = ""
    var strHouse:String = ""
    var strStreet:String = ""
    var strCity:String = ""
    var strHomeNo:String = ""
    var strUserName:String = ""
    var strFollowerCount:String = ""
    var strFollowingCount:String = ""
    var strCountry:String = ""
    //var strAddress:String = ""
    var strIsCurrent:String = ""
    var strPostCode:String = ""
    var strGender:String = ""
    var strDob:String = ""
    var strAge:String = ""
    var strIsDefault:String = ""
//    var strAgeCalc:String {
//        get{
//            if strDob != "" {
//                if let date = Singleton.sharedSingleton.dateFormatterYYYYMMDD().date(from: strDob){
//                    let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
//                    let now = Date()
//                    let calcAge = calendar.components(.year, from: date, to: now, options: [])
//                    return String(calcAge.year!)
//                }else{
//                    return "0"
//                }
//            }else{
//                return "0"
//            }
//        }
//    }
    var strEmailId:String = ""
    var strContact_no:String = ""
    var strPassword:String = ""
    var strProfileImg:String = ""
//    var location:SharedLocation = SharedLocation()
    
    
    init() {}
    
    convenience init(UserJSON : JSON) {
        self.init()
        if let X = UserJSON["contact_no"].string{
            self.strPhone = X
        }
        if let X = UserJSON["email"].string{
            self.strEmailId = X
        }
        if let X = UserJSON["id"].string{
            self.strId = X
        }
        if let X = UserJSON["lgn_type"].string{
            self.strLoginType = X
        }
        if let X = UserJSON["name"].string{
            self.strFname = X
        }
    }
}

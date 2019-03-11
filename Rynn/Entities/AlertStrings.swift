//
//  AlertStrings.swift
//  Alamaaree
//
//  Created by Tops on 2/15/18.
//  Copyright © 2018 Tops. All rights reserved.
//

import UIKit

class AlertStrings: NSObject {

    static let sharedobject = AlertStrings()
    
    struct GeneralAlert {
        static let VALID_EMAIL : String             = "Please Enter valid Email"
        static let VALID_PASSWORD : String          = "Please enter atleast 6 characters including 1 upper case, 1 lowercase & 1 number."
        static let CONFIRM_PASSWORD : String        = "Please Confirm Your Password"
        static let PASSWORD_NOT_MATCH : String      = "Your Password and Confirm Password Did not match"
        static let NO_USERNAME : String             = "Please Enter username"
        static let NO_PASSWORD : String             = "Please Enter Password"
        static let NO_OLD_PASSWORD : String             = "Please Enter Old Password"
    }
    struct OtherAlerts {
        static let NO_AMOUNT : String                = "Please Enter Amount"
         static let NO_TITLE : String                = "Please Enter Title"
         static let NO_DATE : String                = "Please Select Date"
        static let NO_CATEGORY : String                = "Please Select Category"
        static let NO_EXPENSE_TYPE : String                = "Please Select Expense Duration"
        
    }
    //MARK: -  SignUp Alerts 
    struct SignUpAlert {
        static let NO_NOTES : String                = "Please Enter Note"
        
        
        static let ADD_CAPTION : String                = "Please Add Caption"
        static let NO_EMAIL : String                = "Please Enter Your Email"
        static let NO_PASSWORD : String             = "Please Enter Your Password"
        static let CONFIRM_PASSWORD : String        = "Please Confirm Your Password"
        static let PASSWORD_NOT_MATCH : String      = "Your Password and Confirm Password Did not match"
        static let NO_USERNAME : String             = "Please Enter username"
        
        static let NO_OLD_PASSWORD : String   = "Please Enter Old Password"
        static let NO_NEW_PASSWORD : String   = "Please Enter New Password"
        static let NO_CONFIRM_PASSWORD : String   = "Please Enter Confirm Password"
        
        static let NO_PHONENO : String             = "Please Enter Phone Number"
        
        static let NO_FIRSTNAME : String             = "Please Enter FirstName"
        
        static let NO_LASTNAME : String             = "Please Enter LastName"
        
        static let NO_BIRTH_DATE : String             = "Please Select BirthDate"
        
        static let NO_DESCRIPTION : String             = "Please Enter description"
        
        static let NO_PROFILE_IMAGE : String        = "Please choose Profile image"
    }
}

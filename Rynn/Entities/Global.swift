//
//  Global.swift
//  QWALL
//
//  Created by Tops on 6/13/17.
//  Copyright © 2017 Tops. All rights reserved.
//  Update New branch for M4Dev

import UIKit
class Global {
    
    
    //address xml
    static let DeviceUUID = UIDevice.current.identifierForVendor!.uuidString
    static let PhoneDigitLimit = 11
    static let NameDigitLimit = 25
    static let UserNameDigitLimit = 50
    static let StreetNODigitLimit = 20
    static let StreetNameDigitLimit = 60

    static var IsOffline:Bool = false
    
    
    //MARK: - API BASE URL

    static let baseURLPath = "http://13.127.235.254/dev/laravel/ryan/public/api/"
//    static let baseURLPath = "http://18.224.168.149/ryan/public/api/"
    
    static let userId : String = UserDefaults.standard.value(forKey: Global.g_UserDefaultKey.User_Id) as! String
    struct socialMediaUserType {
        static let google = "google"
        static let facebook = "facebook"
    }
    
    struct g_ws {
        static let Device_type: String! = "2"
    }
    
    struct SDKKeys {
        struct Twilio {
            static let Id = ""
            static let Secret = ""
            static let FromNumber = ""
            static let MsgURL = "https://api.twilio.com/2010-04-01/Accounts/" + Global.SDKKeys.Twilio.Id + "/Messages.json"
        }
        struct Adobe {
            static let ClientId = ""
            static let Secret = ""
        }
    }
    static var lastPhone:String = ""
    static var lastpass:String = ""
    static var lastrepass:String = ""
    
    struct Platform {
        static let isSimulator: Bool = {
            #if arch(i386) || arch(x86_64)
                return true
            #endif
                return false
        }()
    }
    
    //Device Compatibility
    struct is_Device {
        static let _iPhone = (UIDevice.current.model as String).isEqual("iPhone") ? true : false
        static let _iPad = (UIDevice.current.model as String).isEqual("iPad") ? true : false
        static let _iPod = (UIDevice.current.model as String).isEqual("iPod touch") ? true : false
    }
    
    struct navigation_for{
        static let _editProfile    = "EP"
        static let _changePassword = "CP"
        static let _Home           = "HM"
    }
    
    //Display Size Compatibility
    struct is_iPhone {
        static let _X = (UIScreen.main.bounds.size.height == 2436 ) ? true : false
        static let _6p = (UIScreen.main.bounds.size.height >= 736.0 ) ? true : false
        static let _6 = (UIScreen.main.bounds.size.height <= 667.0 && UIScreen.main.bounds.size.height > 568.0) ? true : false
        static let _5 = (UIScreen.main.bounds.size.height <= 568.0 && UIScreen.main.bounds.size.height > 480.0) ? true : false
        static let _4 = (UIScreen.main.bounds.size.height <= 480.0) ? true : false
    }
    
    //IOS Version Compatibility
    struct is_iOS {
        static let _11 = ((Float(UIDevice.current.systemVersion as String))! >= Float(11.0)) ? true : false
        static let _10 = ((Float(UIDevice.current.systemVersion as String))! >= Float(10.0)) ? true : false
        static let _9 = ((Float(UIDevice.current.systemVersion as String))! >= Float(9.0) && (Float(UIDevice.current.systemVersion as String))! < Float(10.0)) ? true : false
        static let _8 = ((Float(UIDevice.current.systemVersion as String))! >= Float(8.0) && (Float(UIDevice.current.systemVersion as String))! < Float(9.0)) ? true : false
    }
    
    struct RecurrenceType {
        static let daily    = "One Time"
        static let monthly  = "Monthly"
        static let yearly   = "Yearly"
        static let weekly   = "Weekly"
        static let biweekly   = "Bi-Weekly"
    }
    
    // MARK: -  Shared classes
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let singleton = Singleton.sharedSingleton

    
    // MARK: -  Screen size
    static let screenWidth : CGFloat = (Global.appDelegate.window!.frame.size.width)
    static let screenHeight : CGFloat = (Global.appDelegate.window!.frame.size.height)
    
    // MARK: -  Get UIColor from RGB
    public func RGB(r: Float, g: Float, b: Float, a: Float) -> UIColor {
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: CGFloat(a))
    }
    
    // MARK: -  Dispatch Delay
    func delay(delay: Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }

   // MARK: -  Application Colors
   struct kAppColor {
        static let NavigationAndButtonColor =  #colorLiteral(red: 0.2432638109, green: 0.7360189557, blue: 0.6471245885, alpha: 1)   //Global().RGB(r: 47.0, g: 128.0, b: 209.0, a: 1.0)
        static let BackgroundThemeColor =  #colorLiteral(red: 0.9332318306, green: 0.9333917499, blue: 0.933221817, alpha: 1)
    
        static let PrimaryBlack =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)   //Global().RGB(r: 47.0, g: 128.0, b: 209.0, a: 1.0)
        static let PrimaryPink =  #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    
        static let SecondaryGrey =  #colorLiteral(red: 0.8499533534, green: 0.8820863366, blue: 0.9070737958, alpha: 1)
        static let SecondaryWhite =  #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        static let SecondaryLightGrey =  #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        static let White =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        static let SecondaryWightF7 =  #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
//        static let SecondaryWightF1E =  #colorLiteral(red: 0.9450980392, green: 0.937254902, blue: 0.9411764706, alpha: 0.796403104) // for place holder
//        static let SecondaryCopyWightF1E =  #colorLiteral(red: 0.9450980392, green: 0.937254902, blue: 0.9411764706, alpha: 1)
//        static let SecondaryRed =  #colorLiteral(red: 0.862745098, green: 0.3058823529, blue: 0.2549019608, alpha: 1)
    
   }

    // MARK: - Application Fonts
    struct kFont {
        static let System_Semibold = "System-Semibold"
        static let System_Bold = "HelveticaNeue-Bold"
        static let System_Regular = "HelveticaNeue-Regular"
        static let Proxima_Regular = "ProximaNova-Regular"
        static let AlcoholFont = "Alcohol_TOPS"
    }

    struct kFontSize {
        static let  TextFieldSmallSize_8:CGFloat = 8
        static let  TextFieldSize:CGFloat = 12
        static let  ButtonSize:CGFloat = 15
        static let  LabelSize:CGFloat = 14
    }
    
   
    struct g_UserDefaultKey {
        static let DeviceToken: String! = "DEVICE_TOKEN"
        static let State_Array: String! = "STATE_ARRAY"
        static let Birth_Date: String! = "BIRTH_DATE"
        static let Compny_Name : String! = "COMPANY_NAME"
        static let Stripe_Token : String! = "STRIPE_TOKEN"
        static let Contact_Number: String! = "CONTACT_NUMBER"
        
        static let Priority_Array: String! = "PRIORITY_ARRAY"
        static let Experience_Array: String! = "EXPERIENCE_ARRAY"
        static let Profession_Array: String! = "PROFESSION_ARRAY"
        static let Degree_Array: String! = "DEGREE_ARRAY"
        
        static let Shift_Array: String! = "SHIFT_ARRAY"
        static let EDVolume_Array: String! = "EDVOLUME_ARRAY"
        static let isSoical : String = "IS_SOCIAL"
        static let User_Profile_Pic: String! = "USER_PROFILE_PIC"
        
        static let User_Email: String! = "USER_EMAIL"
        static let User_Id: String! = "USER_ID"
        static let User_Mobile: String! = "USER_MOBILE"
        static let User_Name: String! = "USER_NAME"
        static let subscription_expiry_date: String! = "sUBSCRPTION_EXPIRY_DATE"
        
        static let referral_code: String! = "REFERRALCODE"
        
        static let Plan_Type: String! = "PLAN_TYPE"
        static let is_free: String! = "IS_FREE"
        static let plan_status: String! = "PLAN_STATUS"
    }
    
    struct kAddActivity {
        static let  SelectLifeEvents = "Select Life Events"
        
    }
    func getDeviceSpecificFontSize(_ fontsize: CGFloat) -> CGFloat {
        return ((Global.screenWidth) * fontsize) / 320
    }
    
    struct is_Reachablity {
        var isNetwork = Global.singleton.isConnectivityChecked()
    }
    
//    func getLocalizeStr(key: String) -> String {
//        return LocalizeHelper.sharedLocalSystem().localizedString(forKey: key)
//    }

    // MARK: -  User Data
    struct kLoggedInUserKey {
        static let IsLoggedIn: String! = "ALUserIsLoggedIn"
        static let UserName: String! = "AL_UserName"
        static let User_id: String! = "AL_UserId"
        static let FirstName: String! = "AL_UserfName"
        static let LastName: String! = "AL_UserlName"
        static let user_roles:String = "AL_isuser_roles"
        static let user_type:String = "AL_isuser_type"
        static let user_Image:String = "user_profile_image"
        static let user_ThumbImage:String = "user_Thumb_image"
        static let Email: String! = "AL_UserEmail"
        static let phone: String! = "AL_UserMobileNumber"
        static let zipCode: String! = "AL_UserZipCode"
        static let documentStatus: String! = "AL_UserDocumentStatus"
        static let latitude: String! = "AL_Userlatitude"
        static let longitude:String = "AL_Userlongitude"
        static let address:String = "AL_UserCurrentAddress"
        static let is_delivered:String = "AL_Delivered"
        static let AccessToken:String = "AL_UserAccessToken"
        
        // NOTIFICATION FLAG
        static let is_email_Noti:String = "email_noti"
        static let is_email_Subscription:String = "email_subscribe"
        static let is_push_noti:String = "push_noti"
        static let is_Registertype:String = "registered_type"        
    }
    
    struct kretriUserData {
        var IsLoggedIn: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.IsLoggedIn)
        var User_id: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.User_id)
        var Email: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.Email)
        var strFname: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.FirstName)
        var strLname: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.LastName)
        //var strFullName: String? = "\(kretriUserData().strFname) \(kretriUserData().strLname)"
        var strPhone: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.phone)
        var strZipcode: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.zipCode)
        var strDocStatus: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.documentStatus)
        var strLat: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.latitude)
        var strLont: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.longitude)
        var strAddress: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.address)
        var strProfile: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.user_Image)
        var strThumbeProfile: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.user_ThumbImage)
        
        //NOTIFICATION METHODS
        var is_EmailNoti: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.is_email_Noti)
        var is_PushNoti: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.is_push_noti)
        var user_roles: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.user_roles)
        var user_type: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.user_type)
        var registered_type: String? = Global.singleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.is_Registertype)
    }
    
    // MARK: -  String Type for Validation
    enum kStringType : Int {
        case AlphaNumeric
        case AlphabetOnly
        case NumberOnly
        case Fullname
        case Username
        case Email
        case PhoneNumber
    }
    
    struct PhoneType {
        static let mobile: String = "mobile"
        static let home: String = "home"
        static let work: String = "work"
        static let fax: String = "fax"
        static let other: String = "other"
    }
    
    struct AddressType {
        static let home: String = "home"
        static let work: String = "work"
        static let billing: String = "billing"
        static let shipping: String = "shipping"
        static let other: String = "other"
        
    }
    
    // MARK: -  Post Media Type
    struct kGoogleApiKey {
        static let strPlaceAPIKey = "AIzaSyAMN4uvXHW9IHQ1peHEgiIpU2IIXEvbPz0"
    }
    
    struct kGoogleApis {
        static let strContactApi = "https://www.googleapis.com/auth/contacts.readonly"
    }
    
    struct SocialKeys {
        static let facebook: String = "facebook"
        static let twitter: String  = "twitter"
        static let google: String = "google"
        static let skype: String = "skype"
        static let linkedin: String = "linkedin"
        static let website: String = "website"
    }
    
    struct DatesName {
        static let BirthDay: String = "birthday"
    }
    
    
    struct G_APP_BACKGROUNDCOLOR{
        static let AppBackgroundColor = UIColor(red: 12.0/255.0, green: 92.0/255.0, blue: 70.0/255.0, alpha: 1.0)
    }
    
    struct G_APP_FONT_COLOR {
        static let yellowFontColor = UIColor(red: 240.0/255.0, green: 156.0/255.0, blue: 65.0/255.0, alpha: 1.0)
        static let lightFontColor = UIColor(red: 12.0/255.0, green: 92.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        static let darkFontColor = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    }
    
    
    
    // MARK: -  Create Post: Text Theme Colors
    struct kTextThemeColor {
        static let Start_1 = Global().RGB(r: 248, g: 248, b: 141, a: 1).cgColor
        static let End_1 = Global().RGB(r: 248, g: 248, b: 141, a: 1).cgColor
        
        static let Start_2 = Global().RGB(r: 86, g: 229, b: 159, a: 1).cgColor
        static let End_2 = Global().RGB(r: 40, g: 187, b: 230, a: 1).cgColor
        
        static let Start_3 = Global().RGB(r: 74, g: 144, b: 226, a: 1).cgColor
        static let End_3 = Global().RGB(r: 74, g: 144, b: 226, a: 1).cgColor
        
        static let Start_4 = Global().RGB(r: 220, g: 56, b: 246, a: 1).cgColor
        static let End_4 = Global().RGB(r: 97, g: 63, b: 219, a: 1).cgColor
        
        static let Start_5 = Global().RGB(r: 243, g: 83, b: 105, a: 1).cgColor
        static let End_5 = Global().RGB(r: 243,g: 83, b: 105, a: 1).cgColor
        
        static let Start_6 = Global().RGB(r: 252, g: 209, b: 114, a: 1).cgColor
        static let End_6 = Global().RGB(r: 244, g: 89, b: 106, a: 1).cgColor
        
        static let Start_7 = Global().RGB(r: 137, g: 250, b: 147, a: 1).cgColor
        static let End_7 = Global().RGB(r: 137, g: 250, b: 147, a: 1).cgColor
        
        static let Start_8 = Global().RGB(r: 255, g: 150, b: 225, a: 1).cgColor
        static let End_8 = Global().RGB(r: 255, g: 150, b: 225, a: 1).cgColor
    }
}

extension Date {
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension Date{
    
    func generateDatesArrayBetweenTwoDates(startDate: Date , endDate:Date) ->[Date]
    {
        var datesArray: [Date] =  [Date]()
        var startDate = startDate
        let calendar = Calendar.current
        
        let fmt = DateFormatter()
        fmt.dateFormat = "MM-dd-yyyy"
        
        while startDate <= endDate {
            datesArray.append(startDate)
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
            
        }
        return datesArray
    }
}

extension StringProtocol {
    var double: Double? {
        return Double(self)
    }
    var float: Float? {
        return Float(self)
    }
    var integer: Int? {
        return Int(self)
    }
}

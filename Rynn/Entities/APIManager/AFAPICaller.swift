//
//  AFAPICaller.swift
//
//
//  Created by Tops on 6/15/17.
//  Copyright © 2017 Tops. All rights reserved.
//  Ilesh Commited :18/07

import UIKit
import SpinKit
import Alamofire

class AFAPICaller: NSObject {
    
    typealias AFAPICallerSuccess = (_ responseData: Any, _ success: Bool) -> Void
    typealias AFAPIGoogleSuccess = (_ success: Bool) -> Void
    
    typealias AFAPICallerFailure = () -> Void
    typealias AFAPICallerFailedCall = (_ Error:String, _ Flag:Bool) -> Void
    static let shared = AFAPICaller()
    
    //let afManagerSearch = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
    
    // MARK: -  Add loader in view
    func addShowLoaderInView(viewObj: UIView, boolShow: Bool, enableInteraction: Bool) -> UIView? {
        let width : CGFloat = (34 * Global.screenWidth)/320
        let viewSpinnerBg = UIView(frame: CGRect(x: (Global.screenWidth - width) / 2.0 - 10, y: (Global.screenHeight - width) / 2.0, width: width, height: width))
        viewSpinnerBg.backgroundColor = #colorLiteral(red: 0.2432638109, green: 0.7360189557, blue: 0.6471245885, alpha: 1).withAlphaComponent(0.9)  //Global().RGB(r: 240, g: 240, b: 240, a: 0.4)
        
        viewSpinnerBg.layer.masksToBounds = true
        viewSpinnerBg.layer.cornerRadius = 5.0
        viewObj.addSubview(viewSpinnerBg)
        
        if boolShow {
            viewSpinnerBg.isHidden = false
        }
        else {
            viewSpinnerBg.isHidden = true
        }
        
        if !enableInteraction {
            viewObj.isUserInteractionEnabled = false
        }
        //add spinner in view
        let rtSpinKitspinner: RTSpinKitView = RTSpinKitView(style: RTSpinKitViewStyle.styleArcAlt , color: UIColor.clear)
        rtSpinKitspinner.center = CGPoint(x: (width) / 2.0, y: (width ) / 2.0)
        rtSpinKitspinner.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        rtSpinKitspinner.startAnimating()
        viewSpinnerBg.addSubview(rtSpinKitspinner)
        return viewSpinnerBg
    }
    
    func addShowLoaderInViewSmallLoader(viewObj: UIView, boolShow: Bool, enableInteraction: Bool) -> UIView? {
        let viewSpinnerBg = UIView(frame: CGRect(x: (Global.screenWidth - 54.0) / 2.0, y: (Global.screenHeight - 54.0) / 2.0, width: 20.0, height: 20.0))
        viewSpinnerBg.backgroundColor = Global().RGB(r: 240, g: 240, b: 240, a: 4.0)
        viewSpinnerBg.layer.masksToBounds = true
        viewSpinnerBg.layer.cornerRadius = 5.0
        viewObj.addSubview(viewSpinnerBg)
        
        if boolShow {
            viewSpinnerBg.isHidden = false
        }
        else {
            viewSpinnerBg.isHidden = true
        }
        
        if !enableInteraction {
            viewObj.isUserInteractionEnabled = false
        }
        //add spinner in view
        let rtSpinKitspinner: RTSpinKitView = RTSpinKitView(style: RTSpinKitViewStyle.styleArcAlt , color: UIColor.white)
        rtSpinKitspinner.center = CGPoint(x: (viewSpinnerBg.frame.size.width) / 2.0, y: (viewSpinnerBg.frame.size.height ) / 2.0)
        rtSpinKitspinner.color = #colorLiteral(red: 0.2179464698, green: 0.5849778652, blue: 0.8532606959, alpha: 1)
        rtSpinKitspinner.startAnimating()
        viewSpinnerBg.addSubview(rtSpinKitspinner)
        return viewSpinnerBg
    }
    
    /*func callAPIUsingGETGoogleConnection(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPIGoogleSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = filePath;
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        afManager.get(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            
            onSuccess(true)
        }) { (task: URLSessionDataTask?, error: Error) in
            onFailure()
        }
    }*/
    
    // MARK: -  Hide and remove loader from view
    func hideRemoveLoaderFromView(removableView: UIView, mainView: UIView) {
        removableView.isHidden = true
        removableView.removeFromSuperview()
        mainView.isUserInteractionEnabled = true
    }
    
    // MARK: -  Call web service with GET method
   /* func callAPIUsingGETSearchHIP(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = Global.baseURLPath + filePath;
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        afManagerSearch.operationQueue.cancelAllOperations()
        print("URL = \(strPath) \n Param: \(String(describing: params))")
        afManagerSearch.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        afManagerSearch.get(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if (showLoader) {
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            if let dictResponse = responseObject as? [String : AnyObject]
            {
                onSuccess(dictResponse, true)
            }
            else
            {
                onSuccess([], true)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }
            if (showLoader) {
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            print(error.localizedDescription)
            onFailure()
        }
    }*/
    
    
    // MARK: -  Call web service with GET method
    
    func callAPI_GET(filePath: String, params: [String: Any]?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        
        guard Global.is_Reachablity().isNetwork else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
            return
        }
        
        
        let strPath = Global.baseURLPath + filePath;
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        
      
        
        print("URL:- \(strPath) \nPARAM:- \(String(describing: params))")

        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        
        
        request(strPath, method: .get, parameters: params, encoding: URLEncoding() as ParameterEncoding, headers:headers).responseJSON { (response:DataResponse<Any>) in
            print(response.result.value)
            if (showLoader) {
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            if response.result.isSuccess {
                if let dictResponse = response.result.value  as? [AnyObject] {
                    onSuccess(dictResponse, true)
                }else if let dictResponse = response.result.value  as? [String:AnyObject] {
                    if let msg = dictResponse["status"] as? Int, msg == 422 || msg == 500 || msg == 400 || msg == 404{
                        if let msg123 = dictResponse["message"] as? String{
                            Singleton.sharedSingleton.showWarningAlert(withMsg: msg123 )
                            onFailure()
                        }
                        onFailure()
                    }else{
                        if let str = dictResponse["status"] as? Int, str == 200 {
                            if let status = dictResponse["success"] as? String, status == "1"
                            {
                                onSuccess(dictResponse, true)
                            }
                            
                        }
                        if let msgstatus = dictResponse["success"] as? Int, msgstatus == 1
                        {
                            onSuccess(dictResponse, true)
                        }
                        
                    }
                }
            }else{
                print("Error:- \(String(describing: response.result.error?.localizedDescription))")
                if (showLoader) {
                    self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                    //Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
                }
                onFailure()
            }
        }
    }
    
    func callAPI_POST(filePath: String,  params: [String: Any]?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        
        guard Global.is_Reachablity().isNetwork else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
            return
        }
        
        let strPath = Global.baseURLPath + filePath;
        print("URL:- \(strPath) \nPARAM:- \(String(describing: params))")
        
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        

        
        request(strPath, method: .post, parameters: params, encoding: URLEncoding() as ParameterEncoding, headers: headers).responseJSON { (response:DataResponse<Any>) in
            print(response)
            if (showLoader) {
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            
            if response.result.isSuccess {
                if let dictResponse = response.result.value  as? [AnyObject] {
                    onSuccess(dictResponse, true)
                }else if let dictResponse = response.result.value  as? [String:AnyObject] {
                    print(dictResponse)
                    if let msg = dictResponse["status"] as? Int, msg != 200 && msg != 201  {

                            if let message = dictResponse["message"] as? String
                            {
                                Singleton.sharedSingleton.showWarningAlert(withMsg: message )
                                onFailure()
                            }
                            
//                        }
                        onFailure()
                    }else{
//                        if let str = dictResponse["FLAG"] as? Int, str == 1 {
                        
                                onSuccess(dictResponse, true)
//
//
//                        }
                        
                    }
                }
            }
            
            else{
                print("Error:- \(String(describing: response.result.error?.localizedDescription))")
                if (showLoader) {
                    self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                }
                onFailure()
            }
        }
    }
    
    
    
    
    
    func callAPI_POST_Without_User(filePath: String,  params: [String: Any]?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        
        guard Global.is_Reachablity().isNetwork else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
            return
        }
        
        let strPath = Global.baseURLPath + filePath;
        print("URL:- \(strPath) \nPARAM:- \(String(describing: params))")
        
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        //        var headers : [String:String] = [:]
        //        if (Global.kretriUserData().IsLoggedIn!.toBool()){
        //            let token = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.AccessToken)!
        //            headers = [
        //                "Authorization": "\(token)"
        //            ]
        //        } else  {
        //            headers = [
        //                "Authorization": ""
        //            ]
        //        }
        
        request(strPath, method: .post, parameters: params, encoding: URLEncoding() as ParameterEncoding, headers: headers).responseJSON { (response:DataResponse<Any>) in
            print(response)
            if (showLoader) {
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            if response.result.isSuccess {
                if let dictResponse = response.result.value  as? [AnyObject] {
                    onSuccess(dictResponse, true)
                }else if let dictResponse = response.result.value  as? [String:AnyObject] {
                    if let msg = dictResponse["code"] as? Int, msg == 422 || msg == 500 || msg == 400 || msg == 404{
                        if let msg123 = dictResponse["message"] as? String{
                            Singleton.sharedSingleton.showWarningAlert(withMsg: msg123 )
                            onFailure()
                        }
                        onFailure()
                    }else{
                        if let str = dictResponse["code"] as? Int, str == 200 {
                            if let status = dictResponse["status"] as? String, status == "true"
                            {
                                onSuccess(dictResponse, true)
                                return
                            }
                            if let status = dictResponse["status"] as? Int, status == 1
                            {
                                onSuccess(dictResponse, true)
                                return
                            }
                            
                        }
                        if let msg = dictResponse["FLAG"] as? Int, msg == 1
                        {
                            onSuccess(dictResponse, true)
                        }
                        else{
                            //                            if let errorDic = dictResponse["errors"] as? NSDictionary {
                            //                                if let arrMsg = errorDic.allValues as? [String] {
                            //                                    let strMsg = arrMsg.joined(separator: ",")
                            //                                    Singleton.sharedSingleton.showWarningAlert(withMsg: strMsg )
                            //                                }
                            //                                onFailure()
                            //                            }
                            
                            //                            if let msg = dictResponse["message"] as? String{
                            //                               Singleton.sharedSingleton.showWarningAlert(withMsg: msg )
                            //                                onFailure()
                            //                            }
                            //                            else{
                            //                                Singleton.sharedSingleton.showWarningAlert(withMsg:  dictResponse["MESSAGE"] as? String ?? "")
                            //                                onFailure()
                            //                            }
                        }
                    }
                }
            }else{
                print("Error:- \(String(describing: response.result.error?.localizedDescription))")
                if (showLoader) {
                    self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                }
                onFailure()
            }
        }
    }
    
    
    
    
    //for Address before login not in used now
    func callAPI_POST_ForWithOutLoginToken(filePath: String,  params: [String: Any]?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        
        guard Global.is_Reachablity().isNetwork else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
            return
        }
        
        let strPath = Global.baseURLPath + filePath;
        print("URL:- \(strPath) \nPARAM:- \(String(describing: params))")
        
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        
        
        var headers : [String:String] = [:]
        if (Global.kretriUserData().IsLoggedIn!.toBool()){
            let token = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.AccessToken)!
            headers = [
                "Authorization": "\(token)"
            ]
        }
        request(strPath, method: .post, parameters: params, encoding: URLEncoding() as ParameterEncoding, headers: headers).responseJSON { (response:DataResponse<Any>) in
            print(response)
            if (showLoader) {
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            if response.result.isSuccess {
                if let dictResponse = response.result.value  as? [AnyObject] {
                    onSuccess(dictResponse, true)
                }else if let dictResponse = response.result.value  as? [String:AnyObject] {
                    if let msg = dictResponse["status_code"] as? Int, msg == 401 || msg == 500 {
                        self.alertLogout()
                        onFailure()
                    }else{
                        if let str = dictResponse["status"] as? String , str.toBool() {
                            onSuccess(dictResponse, true)
                        }else{
                            if let errorDic = dictResponse["errors"] as? NSDictionary {
                                if let arrMsg = errorDic.allValues as? [String] {
                                    let strMsg = arrMsg.joined(separator: ",")
                                    Singleton.sharedSingleton.showWarningAlert(withMsg: strMsg )
                                }
                                onFailure()
                            }else{
                                Singleton.sharedSingleton.showWarningAlert(withMsg:  dictResponse["msg"] as? String ?? "")
                                onFailure()
                            }
                        }
                    }
                }
            } else {
                print("Error:- \(String(describing: response.result.error?.localizedDescription))")
                if (showLoader) {
                    self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                    //Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
                }
                onFailure()
            }
        }
    }
    
    func call_API_POST_WithOutErrors(filePath: String, params: [String: Any]?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        
        guard Global.is_Reachablity().isNetwork else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
            return
        }
        
        
        let strPath = Global.baseURLPath + filePath;
        print("URL:- \(strPath) \nPARAM:- \(String(describing: params))")
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
//        var headers : [String:String] = [:]
//        if (Global.kretriUserData().IsLoggedIn!.toBool()){
//            let token = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.AccessToken)!
//            headers = [
//                "Authorization": "\(token)"
//            ]
//        }
        request(strPath, method: .post, parameters: params, encoding: URLEncoding() as ParameterEncoding, headers: headers).responseJSON { (response:DataResponse<Any>) in
            print(response)
            if (showLoader) {
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            if response.result.isSuccess {
                if let dictResponse = response.result.value  as? [AnyObject] {
                    onSuccess(dictResponse, true)
                }else if let dictResponse = response.result.value  as? [String:AnyObject] {
                    if let msg = dictResponse["status_code"] as? Int, msg == 401 || msg == 500 {
                        self.alertLogout()
                        onFailure()
                    }else{
                        onSuccess(dictResponse, true)
                    }
                }
            }else{
                print("Error:- \(String(describing: response.result.error?.localizedDescription))")
                if (showLoader) {
                    self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                    //Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
                }
                onFailure()
            }
        }
    }
    
    //MARK:-  Video Upload
    
    
    func callAPI_VideoUpload_Sign(filePath: String,image:Data?, params: [String: Any]?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        
        guard Global.is_Reachablity().isNetwork else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: "Your internet is off. Please Turn it on.")
            return
        }
        
        let strPath = Global.baseURLPath + filePath;
        print("URL:- \(strPath) \nPARAM:- \(String(describing: params))")
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        
        
//        var imgData:Data?
//        if image != nil {
//            imgData = UIImageJPEGRepresentation(image!, 1)
//            print("Image Size: %f KB", imgData)
//
//            let imageSize: Int = imgData!.count
//            if Double(imageSize) / 1024.0 > 1.0 {
//                imgData = UIImageJPEGRepresentation(image!, 0.1)
//                print("Image Size: %f KB", imgData)
//            }
//        } else {
//            imgData = Data()
//        }
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            if image != nil {
                multipartFormData.append(image!, withName: "video",fileName: "profile_image.mp4", mimeType: "video/mp4")
            }
            for (key, value) in params! {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }}
            ,usingThreshold:UInt64.init(),to:strPath,
             method:.post,
             headers:headers,
             encodingCompletion: { result in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        debugPrint(response)
                        if (showLoader) {
                            self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                        }
                      
                        if response.result.isSuccess {
                            if let dictResponse = response.result.value  as? [AnyObject] {
                                onSuccess(dictResponse, true)
                            }else if let dictResponse = response.result.value  as? [String:AnyObject] {
                                if let msg = dictResponse["code"] as? Int, msg == 422 || msg == 500 || msg == 400 || msg == 404{
                                    if let msg123 = dictResponse["message"] as? String{
                                        Singleton.sharedSingleton.showWarningAlert(withMsg: msg123 )
                                        onFailure()
                                    }
                                    onFailure()
                                }else{
                                    if let str = dictResponse["code"] as? Int, str == 200 {
                                        if let status = dictResponse["status"] as? String, status == "true"
                                        {
                                            onSuccess(dictResponse, true)
                                        }
                                        
                                    }
                                    if let msgstatus = dictResponse["status"] as? Int, msgstatus == 1
                                    {
                                        onSuccess(dictResponse, true)
                                    }
                                    if let msg = dictResponse["FLAG"] as? Int, msg == 1
                                    {
                                        onSuccess(dictResponse, true)
                                    }
                                    else{
                                        
                                    }
                                }
                            }
                        }
                        else{
                            print("Error:- \(String(describing: response.result.error?.localizedDescription))")
                            if (showLoader) {
                                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                                //Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
                            }
                            onFailure()
                        }
                        
                     
                        
                        
                    }
                case .failure(let encodingError):
                    if (showLoader) {
                        self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                        //Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
                    }
                    print("Error:- \(encodingError)")
                    onFailure()
                }
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK:-  Document Upload
    
    
    func callAPI_DocumentUpload_Sign(filePath: String,image:Data?, params: [String: Any]?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        
        guard Global.is_Reachablity().isNetwork else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: "Your internet is off. Please Turn it on.")
            return
        }
        
        let strPath = Global.baseURLPath + filePath;
        print("URL:- \(strPath) \nPARAM:- \(String(describing: params))")
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        
        
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            if image != nil {
                multipartFormData.append(image!, withName: "image",fileName: "profile_image.pdf", mimeType: "application/pdf")
            }
            for (key, value) in params! {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }}
            ,usingThreshold:UInt64.init(),to:strPath,
             method:.post,
             headers:headers,
             encodingCompletion: { result in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        debugPrint(response)
                        if (showLoader) {
                            self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                        }
                        
                        if response.result.isSuccess {
                            if let dictResponse = response.result.value  as? [AnyObject] {
                                onSuccess(dictResponse, true)
                            }else if let dictResponse = response.result.value  as? [String:AnyObject] {
                                if let msg = dictResponse["code"] as? Int, msg == 422 || msg == 500 || msg == 400 || msg == 404{
                                    if let msg123 = dictResponse["message"] as? String{
                                        Singleton.sharedSingleton.showWarningAlert(withMsg: msg123 )
                                        onFailure()
                                    }
                                    onFailure()
                                }else{
                                    if let str = dictResponse["code"] as? Int, str == 200 {
                                        if let status = dictResponse["status"] as? String, status == "true"
                                        {
                                            onSuccess(dictResponse, true)
                                        }
                                        
                                    }
                                    if let msgstatus = dictResponse["status"] as? Int, msgstatus == 1
                                    {
                                        onSuccess(dictResponse, true)
                                    }
                                    if let msg = dictResponse["FLAG"] as? Int, msg == 1
                                    {
                                        onSuccess(dictResponse, true)
                                    }
                                    else{
                                        
                                    }
                                }
                            }
                        }
                        else{
                            print("Error:- \(String(describing: response.result.error?.localizedDescription))")
                            if (showLoader) {
                                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                                //Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
                            }
                            onFailure()
                        }
                        
                        
                        
                        
                    }
                case .failure(let encodingError):
                    if (showLoader) {
                        self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                        //Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
                    }
                    print("Error:- \(encodingError)")
                    onFailure()
                }
        })
    }
    
    
    
    
    
    
    //MARK:-  Upload DB File 
    
    func callAPI_Upload_DB(filePath: String,image:Data?, params: [String: Any]?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        
        guard Global.is_Reachablity().isNetwork else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: "Your internet is off. Please Turn it on.")
            return
        }
        
        let strPath = Global.baseURLPath + filePath;
        print("URL:- \(strPath) \nPARAM:- \(String(describing: params))")
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        
        
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            if image != nil {
                multipartFormData.append(image!, withName: "file",fileName: "Rynn.db", mimeType: "db")
            }
            for (key, value) in params! {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }}
            ,usingThreshold:UInt64.init(),to:strPath,
             method:.post,
             headers:headers,
             encodingCompletion: { result in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        debugPrint(response)
                        if (showLoader) {
                            self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                        }
                        
                        
                        
                        
                        
                        
                        
                        if response.result.isSuccess {
                            if let dictResponse = response.result.value  as? [AnyObject] {
                                onSuccess(dictResponse, true)
                            }else if let dictResponse = response.result.value  as? [String:AnyObject] {
                                if let msg = dictResponse["status"] as? Int, msg == 422 || msg == 500 || msg == 400 || msg == 404{
                                    if let msg123 = dictResponse["message"] as? String{
                                        Singleton.sharedSingleton.showWarningAlert(withMsg: msg123 )
                                        onFailure()
                                    }
                                    onFailure()
                                }else{
                                    if let str = dictResponse["status"] as? Int, str == 200 {
                                        if let status = dictResponse["success"] as? String, status == "1"
                                        {
                                            onSuccess(dictResponse, true)
                                        }
                                        
                                    }
                                    if let msgstatus = dictResponse["success"] as? Int, msgstatus == 1
                                    {
                                        onSuccess(dictResponse, true)
                                    }
                                    
                                }
                            }
                        }
                        else{
                            print("Error:- \(String(describing: response.result.error?.localizedDescription))")
                            if (showLoader) {
                                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                                //Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
                            }
                            onFailure()
                        }
                        
                        
                    }
                case .failure(let encodingError):
                    if (showLoader) {
                        self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                        //Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
                    }
                    print("Error:- \(encodingError)")
                    onFailure()
                }
        })
    }
    
    
    
    //MARK:-  Create JOb Card
    func callAPI_ImageUpload_Sign(filePath: String,image:UIImage?, params: [String: Any]?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        
        guard Global.is_Reachablity().isNetwork else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: "Your internet is off. Please Turn it on.")
            return
        }
        
        let strPath = Global.baseURLPath + filePath;
        print("URL:- \(strPath) \nPARAM:- \(String(describing: params))")
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        
        
        var imgData:Data?
        if image != nil {
            imgData = UIImageJPEGRepresentation(image!, 1)
            print("Image Size: %f KB", imgData)
            
            let imageSize: Int = imgData!.count
            if Double(imageSize) / 1024.0 > 1.0 {
                imgData = UIImageJPEGRepresentation(image!, 0.1)
                print("Image Size: %f KB", imgData)
            }
        } else {
            imgData = Data()
        }
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            if image != nil {
                multipartFormData.append(imgData!, withName: "profile_pic",fileName: "profile_image.png", mimeType: "image/jpg")
            }
            for (key, value) in params! {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }}
            ,usingThreshold:UInt64.init(),to:strPath,
             method:.post,
             headers:headers,
             encodingCompletion: { result in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        debugPrint(response)
                        if (showLoader) {
                            self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                        }
                        
                        
                        
                        
                        
                        
                        
                        if response.result.isSuccess {
                            if let dictResponse = response.result.value  as? [AnyObject] {
                                onSuccess(dictResponse, true)
                            }else if let dictResponse = response.result.value  as? [String:AnyObject] {
                                if let msg = dictResponse["code"] as? Int, msg == 422 || msg == 500 || msg == 400 || msg == 404{
                                    if let msg123 = dictResponse["message"] as? String{
                                        Singleton.sharedSingleton.showWarningAlert(withMsg: msg123 )
                                        onFailure()
                                    }
                                    onFailure()
                                }else{
                                    if let str = dictResponse["code"] as? Int, str == 200 {
                                        if let status = dictResponse["status"] as? String, status == "true"
                                        {
                                            onSuccess(dictResponse, true)
                                        }
                                        
                                    }
                                    if let msgstatus = dictResponse["status"] as? Int, msgstatus == 1
                                    {
                                        onSuccess(dictResponse, true)
                                    }
                                    if let msg = dictResponse["FLAG"] as? Int, msg == 1
                                    {
                                        onSuccess(dictResponse, true)
                                    }
                                    else{
                                        
                                    }
                                }
                            }
                        }
                        else{
                            print("Error:- \(String(describing: response.result.error?.localizedDescription))")
                            if (showLoader) {
                                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                                //Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
                            }
                            onFailure()
                        }
                        
                        
                    }
                case .failure(let encodingError):
                    if (showLoader) {
                        self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                        //Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
                    }
                    print("Error:- \(encodingError)")
                    onFailure()
                }
        })
    }
    
    
    
    
    
    
    
    
    func callAPI_ImageUpload(filePath: String,image:UIImage?, params: [String: Any]?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        
        guard Global.is_Reachablity().isNetwork else {
            Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
            return
        }
        
        let strPath = Global.baseURLPath + filePath;
        print("URL:- \(strPath) \nPARAM:- \(String(describing: params))")
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
//        var headers : [String:String] = [:]
//        if (Global.kretriUserData().IsLoggedIn!.toBool()){
//            let token = Singleton.sharedSingleton.retriveFromUserDefaults(key: Global.kLoggedInUserKey.AccessToken)!
//            headers = [
//                "Authorization": "\(token)"
//            ]
//        }
        
        
        var imgData:Data?
        if image != nil {
            imgData = UIImageJPEGRepresentation(image!, 1)
            print("Image Size: %f KB", imgData)

            let imageSize: Int = imgData!.count
            if Double(imageSize) / 1024.0 > 1.0 {
                imgData = UIImageJPEGRepresentation(image!, 0.1)
                print("Image Size: %f KB", imgData)
            }
        } else {
            imgData = Data()
        }
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            if image != nil {
                multipartFormData.append(imgData!, withName: "profile_image",fileName: "profile_image.png", mimeType: "image/jpg")
            }
            for (key, value) in params! {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }}
            ,usingThreshold:UInt64.init(),to:strPath,
                         method:.post,
                         headers:headers,
                         encodingCompletion: { result in
                            switch result {
                            case .success(let upload, _, _):
                                
                                upload.uploadProgress(closure: { (progress) in
                                    print("Upload Progress: \(progress.fractionCompleted)")
                                })
                                
                                upload.responseJSON { response in
                                    debugPrint(response)
                                    if (showLoader) {
                                        self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                                    }
                                    if let dictResponse = response.result.value  as? [AnyObject] {
                                        onSuccess(dictResponse, true)
                                    }else if let dictResponse = response.result.value  as? [String:AnyObject] {
                                        if let msg = dictResponse["FLAG"] as? Int, msg == 0 || msg == 0 {
//                                            self.alertLogout() //Global.appDelegate.logoutUser()
                                            onFailure()
                                        }else{
                                            print("Response Image \(dictResponse)")
                                            if let msg = dictResponse["FLAG"] as? Int, msg == 1
                                            {
                                                 onSuccess(dictResponse, true)
                                            }
                                            if let str = dictResponse["FLAG"] as? String , str.toBool() {
                                                onSuccess(dictResponse, true)
                                            }
                                            else{
                                                if let errorDic = dictResponse["errors"] as? NSDictionary {
                                                    if let arrMsg = errorDic.allValues as? [String] {
                                                        let strMsg = arrMsg.joined(separator: ",")
                                                        Singleton.sharedSingleton.showWarningAlert(withMsg: strMsg )
                                                    }
                                                    onFailure()
                                                }else{
                                                    Singleton.sharedSingleton.showWarningAlert(withMsg:  dictResponse["msg"] as? String ?? "")
                                                    onFailure()
                                                }
                                            }
                                        }
                                    }
                                }
                            case .failure(let encodingError):
                                if (showLoader) {
                                    self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
                                    //Singleton.sharedSingleton.showWarningAlert(withMsg: LocalizeHelper.sharedInstance.localizedString(forKey: "ERROR_CALL"))
                                }
                                print("Error:- \(encodingError)")
                                onFailure()
             }
        })
    }
    
    //MARK: FORCE LOGOUT
    func alertLogout()
    {
        DispatchQueue.main.async {
            let alert:UIAlertController=UIAlertController(title: nil, message: nil , preferredStyle: UIAlertControllerStyle.actionSheet)
            let Action = UIAlertAction(title: "Logout", style: UIAlertActionStyle.default){ UIAlertAction in
//                Global.appDelegate.logoutUser()
            }
            // Add the actions
            alert.addAction(Action)
//            Global.appDelegate.navController?.present(alert, animated: true, completion: nil)
        }
    }
    
    /*func callAPIUsingGET(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = Global.baseURLPath + filePath;
        var viewSpinner: UIView?
        if (showLoader) {
             viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        
        
        
        
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        print("URL = \(strPath) \n Param: \(String(describing: params))")
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        afManager.get(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if (showLoader) {
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            let dictResponse = responseObject as? [AnyObject] ?? []
            onSuccess(dictResponse, true)
            
//            if (dictResponse.object(forKey: "flag") as! Bool == true) { //no error
//                
//            }
//            else { //with error
//                if (showLoader) {
//                    Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "response") as! String)
//                }
//                onSuccess(dictResponse, false)
//            }
        }) { (task: URLSessionDataTask?, error: Error) in
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }
            if (showLoader) {
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            print(error.localizedDescription)
            onFailure()
        }
    }*/
    
    /*func callAPIUsingGETForProfile(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = Global.baseURLPath + filePath;
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        print("URL = \(strPath) \n Param: \(String(describing: params))")
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        afManager.get(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            print(responseObject ?? "--")
            if (showLoader) {
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            if let dictResponse = responseObject as? NSDictionary{
                if (dictResponse.object(forKey: "flag") as! Bool == true) { //no error
                    onSuccess(dictResponse, true)
                }
                else { //with error
                    if (showLoader) {
                        if ((dictResponse.object(forKey: "flag") as? String) != nil){
                            Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "response") as! String)
                        }
                    }
                    onSuccess(dictResponse, false)
                }
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }
            if (showLoader) {
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            print(error.localizedDescription)
            onFailure()
        }
    }*/
    
    /*func callAPIUsingPOSTAny(filePath: String, params: String?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = Global.baseURLPath + filePath;
        var viewSpinner: UIView!
        if showLoader{
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        //print(params ?? "")
        afManager.post(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if showLoader{
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
            if let dictResponse = responseObject as? NSDictionary{
                print(dictResponse)
                if (dictResponse.object(forKey: "flag") as! Bool == true) { //no error
                    onSuccess(dictResponse, true)
                }
                else { //with error
                    if (showLoader) {
                        if ((dictResponse.object(forKey: "flag") as? String) != nil){
                            Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "response") as! String)
                        }
                    }
                    onSuccess(dictResponse, false)
                }
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            onFailure()
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }
            if (showLoader) {
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
        }
    }*/
    
    // MARK: -  Call web service with POST method
   /* func callAPIUsingPOSTRawJson(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = Global.baseURLPath + filePath;
        var viewSpinner: UIView!
        if showLoader{
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        
        afManager.requestSerializer = AFJSONRequestSerializer()
        afManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        
       // print(params)
        afManager.post(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if showLoader{
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
            if let dictResponse = responseObject as? NSDictionary
            {
                
            
           // print(dictResponse)
            if (dictResponse.object(forKey: "flag") as! Bool == true) { //no error
                onSuccess(dictResponse, true)
            }
            else { //with error
                if (showLoader) {
                    if ((dictResponse.object(forKey: "flag") as? String) != nil){
                        Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "response") as! String)
                    }
                }
                onSuccess(dictResponse, false)
            }
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            
            print(error.localizedDescription)
            onFailure()
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }
            if (showLoader) {
                if (Global.kLoggedInUserData().IsLoggedIn == "true"){
                    Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
                    self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
                }
            }
        }
    }*/
    
    /*func callAPIUsingPOSTJSON(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = Global.baseURLPath + filePath;
        if (params != nil) {
            params?.setValue("1", forKey: "is_device")
        }
        print("URL = \(strPath) \n Param: \(String(describing: params))")
        var viewSpinner: UIView!
        if showLoader{
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        afManager.requestSerializer = AFJSONRequestSerializer()
        afManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        //print(params ?? "")
        afManager.post(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            print(" return Responsessss : \(responseObject)")
            if showLoader{
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
            let dictResponse = responseObject as! NSDictionary
            print(dictResponse)
            if (dictResponse.object(forKey: "flag") as! Bool == true) { //no error
                print(dictResponse)
                onSuccess(dictResponse, true)
                
            }
            else { //with error
                if (showLoader) {
                    if ((dictResponse.object(forKey: "flag") as? String) != nil){
                        print(dictResponse)
                        Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "response") as! String)
                    }
                }
                onSuccess(dictResponse, false)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            onFailure()
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }
            if (showLoader) {
                print(error.localizedDescription)
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
        }
    }*/
    
    /*func callAPIUsingPOSTImageInBasewithParameter(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = Global.baseURLPath + filePath;
        if (params != nil) {
            params?.setValue("1", forKey: "is_device")
        }
        print("URL = \(strPath) \n Param: \(String(describing: params))")
        var viewSpinner: UIView!
        if showLoader{
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        afManager.requestSerializer = AFJSONRequestSerializer()
        afManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        
        //print(params ?? "")
        afManager.post(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            
            if showLoader{
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
            let dictResponse = responseObject as! NSDictionary
            print(dictResponse)
            if (dictResponse.object(forKey: "flag") as! Bool == true) { //no error
                print(dictResponse)
                onSuccess(dictResponse, true)
                
            }
            else { //with error
                if (showLoader) {
                    if ((dictResponse.object(forKey: "flag") as? String) != nil){
                        print(dictResponse)
                        Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "response") as! String)
                    }
                }
                onSuccess(dictResponse, false)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            onFailure()
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }
            if (showLoader) {
                print(error.localizedDescription)
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
        }
    }*/
    
    
    /*func callAPIUsingPOSTSmallLoader(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = Global.baseURLPath + filePath;
        if (params != nil) {
            params?.setValue("1", forKey: "is_device")
        }
        print("URL = \(strPath) \n Param: \(String(describing: params))")
        var viewSpinner: UIView!
        if showLoader{
            viewSpinner = self.addShowLoaderInViewSmallLoader(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        
        //print(params ?? "")
        afManager.post(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            
            if showLoader{
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
            let dictResponse = responseObject as! NSDictionary
            print(dictResponse)
            if (dictResponse.object(forKey: "flag") as! Bool == true) { //no error
                print(dictResponse)
                onSuccess(dictResponse, true)
                
            }
            else { //with error
                if (showLoader) {
                    if ((dictResponse.object(forKey: "flag") as? String) != nil){
                        print(dictResponse)
                        Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "response") as! String)
                    }
                }
                onSuccess(dictResponse, false)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            onFailure()
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }
            if (showLoader) {
                print(error.localizedDescription)
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
        }
    }*/
    
    /*func callAPIUsingGETGoogle(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = filePath
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        print("URL = \(strPath) \n Param: \(String(describing: params))")
    afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        afManager.get(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            print(responseObject)
            if (showLoader) {
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            let dictResponse = responseObject as? [String : AnyObject] ?? [:]
            onSuccess(dictResponse, true)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            
            if (showLoader) {
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            print(error.localizedDescription)
            onFailure()
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }
        }
    }*/
    
    /*func callPOSTGoogleApiCall(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = filePath;
        print("URL = \(strPath) \n Param: \(String(describing: params))")
        var viewSpinner: UIView!
        if showLoader{
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        //print(params ?? "")
        afManager.post(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            
            if showLoader{
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
            let dictResponse = responseObject as! NSDictionary
            print(dictResponse)
            if (dictResponse.object(forKey: "flag") as! Bool == true) { //no error
                print(dictResponse)
                onSuccess(dictResponse, true)
                
            }
            else { //with error
                if (showLoader) {
                    if ((dictResponse.object(forKey: "flag") as? String) != nil){
                        print(dictResponse)
                        Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "response") as! String)
                    }
                }
                onSuccess(dictResponse, false)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            onFailure()
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }
            if (showLoader) {
                print(error.localizedDescription)
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
        }
    }
    
    
    func callAPIUsingPOST(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = Global.baseURLPath + filePath;
        
        print("URL = \(strPath) \n Param: \(String(describing: params))")
        var viewSpinner: UIView!
        if showLoader{
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
    
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
                
        //print(params ?? "")
        afManager.post(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            
            if showLoader{
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
            let dictResponse = responseObject as! NSDictionary
            print(dictResponse)
            if (dictResponse.object(forKey: "code") as! String == "200") { //no error
                Global.singleton.showSuccessAlert(withMsg: dictResponse.object(forKey: "MESSAGE") as? String ?? "")
                onSuccess(dictResponse, true)
                
            }
            else { //with error
                if (showLoader) {
                    if ((dictResponse.object(forKey: "code") as? String) != nil){
                        Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "MESSAGE") as? String ?? "")
                    }
                }
                onSuccess(dictResponse, false)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            onFailure()
            
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    
                }
            }
            if (showLoader) {
                print(error.localizedDescription)
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
            
        }
    }
    
    func callAPIUsingPOSTContentType(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = Global.baseURLPath + filePath;
        
        print("URL = \(strPath) \n Param: \(String(describing: params))")
        var viewSpinner: UIView!
        if showLoader{
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        afManager.requestSerializer = AFJSONRequestSerializer()
        afManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        
        //print(params ?? "")
        afManager.post(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            
            if showLoader{
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
            let dictResponse = responseObject as! NSDictionary
            print(dictResponse)
            if (dictResponse.object(forKey: "flag") as! Bool == true) { //no error
                print(dictResponse)
                onSuccess(dictResponse, true)
                
            }
            else { //with error
                if (showLoader) {
                    if ((dictResponse.object(forKey: "flag") as? String) != nil){
                        print(dictResponse)
                        Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "response") as! String)
                    }
                }
                onSuccess(dictResponse, false)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            onFailure()
            
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }

            if (showLoader) {
                print(error.localizedDescription)
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
        }
    }
    
    // MARK: -  Call web service with one image
    func callAPIWithImage(filePath: String, params: NSMutableDictionary?, image: UIImage?, imageParamName: String, enableInteraction: Bool, showLoader: Bool, viewObj: UIView, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailedCall)) {
        let strPath = Global.baseURLPath + filePath;
        var viewSpinner: UIView?
        if showLoader{
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
    afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        afManager.post(strPath, parameters: params, constructingBodyWith: { (Data) in
            if (image != nil) {
                let imageData: Data = UIImagePNGRepresentation(image!)!
                
                Data.appendPart(withFileData: imageData, name: imageParamName, fileName: "photo.png", mimeType: "image/png")
            }
        }, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if showLoader{
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj)
            }
            
            let dictResponse = responseObject as! NSDictionary
            if (dictResponse.object(forKey: "flag") as! Bool == true) { //no error
                onSuccess(dictResponse, true)
            }
            else { //with error
                if (showLoader) {
                    Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "response") as! String)
                }
                onSuccess(dictResponse, false)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    
                }
            }
            if (showLoader) {
                self.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj)
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
            }
            onFailure(error.localizedDescription, false)
        }
    }
    
    // MARK: -  Call web service with multi image
    func callAPIWithMultiImage(filePath: String, params: NSMutableDictionary?, images: [UIImage], imageParamNames: [String], enableInteraction: Bool, showLoader: Bool, viewObj: UIView, onSuccess: @escaping (AFAPICallerSuccess), onFailure: (AFAPICallerFailure)) {
        let strPath = Global.baseURLPath + filePath;
        
        let viewSpinner: UIView = self.addShowLoaderInView(viewObj: viewObj, boolShow: showLoader, enableInteraction: enableInteraction)!
        
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
        afManager.post(strPath, parameters: params, constructingBodyWith: { (Data) in
            var i: Int = 0
            for image in images {
                let imageData: Data = UIImagePNGRepresentation(image)!
                Data.appendPart(withFileData: imageData, name: imageParamNames[i], fileName: "photo.png", mimeType: "image/png")
                i = i+1;
            }
        }, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            
            self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj)
            
            let dictResponse = responseObject as! NSDictionary
            if (dictResponse.object(forKey: "flag") as! Bool == true) { //no error
                onSuccess(dictResponse, true)
            }
            else { //with error
                if (showLoader) {
                    Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "response") as! String)
                }
                onSuccess(dictResponse, false)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }
            self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj)
            if (showLoader) {
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keyInternetMsg"))
            }
        }
    }
    
    // MARK: -  Call web service with POST method and Fix URL
    func callAPIUsingPOSTForTwilio(filePath: String, params: NSMutableDictionary?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView, onSuccess: @escaping (AFAPICallerSuccess), onFailure: (AFAPICallerFailure)) {
        let viewSpinner: UIView = self.addShowLoaderInView(viewObj: viewObj, boolShow: showLoader, enableInteraction: enableInteraction)!
        
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername(Global.SDKKeys.Twilio.Id, password: Global.SDKKeys.Twilio.Secret)
        
        afManager.post(filePath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            
            self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj)
            
            let dictResponse = responseObject as! NSDictionary
            onSuccess(dictResponse, true)
        }) { (task: URLSessionDataTask?, error: Error) in
            if let response = task?.response as? HTTPURLResponse {
                print(response.statusCode)
                if response.statusCode == 401 {
                    AFAPICaller().callAPIUsingTOKEN_Refresh_POST(enableInteraction: true, showLoader: false, viewObj: nil, onSuccess: { (_, _) in
                        
                    }, onFailure: {
                        
                    })
                }
            }
            self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj)
            if (showLoader) {
                Global.singleton.showWarningAlert(withMsg: LocalizeHelper().localizedString(forKey: "keySUMobileMsg3"))
            }
        }
    }
    
    //MARK:- TOKEN REFRESH METHODS
    func callAPIUsingTOKEN_Refresh_POST(enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (AFAPICallerSuccess), onFailure: @escaping (AFAPICallerFailure)) {
        let strPath = Global.baseURLPath + "user/refresh_token"
        let params = NSMutableDictionary()
        params.setValue(Global.kLoggedInUserData().refresh_token, forKey: "refresh_token")
        print("URL = \(strPath) \n Param: \(String(describing: params))")
        
        var viewSpinner: UIView!
        if showLoader{
            viewSpinner = self.addShowLoaderInView(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        let afManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        afManager.requestSerializer.setAuthorizationHeaderFieldWithUsername("admin", password: "1234")
       
        
        //print(params ?? "")
        afManager.post(strPath, parameters: params, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if showLoader{
                self.hideRemoveLoaderFromView(removableView: viewSpinner, mainView: viewObj!)
            }
            let dictResponse = responseObject as! NSDictionary
            print(dictResponse)
            if let token = dictResponse["token"] as? String {
               Global.singleton.saveToUserDefaults(value:token, forKey: Global.kLoggedInUserKey.AccessToken)
            }
            if (dictResponse.object(forKey: "flag") as! Bool == true) { //no error
                onSuccess(dictResponse, true)
                
            }
            else { //with error
                if (showLoader) {
                    if ((dictResponse.object(forKey: "flag") as? String) != nil){
                        print(dictResponse)
                        Global.singleton.showWarningAlert(withMsg: dictResponse.object(forKey: "response") as! String)
                    }
                }
                onSuccess(dictResponse, false)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            onFailure()
        }
    }*/
}

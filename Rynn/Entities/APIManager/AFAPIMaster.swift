//
//  AFAPIMaster.swift
//  chilax74-16
//
//  Created by Tops on 6/15/17.
//  Copyright © 2017 Tops. All rights reserved.
//  Ilesh Commited :18/07

import UIKit

class AFAPIMaster: AFAPICaller {
    static let sharedAPIMaster = AFAPIMaster()
    
    typealias AFAPIMasterSuccess = (_ returnData: Any) -> Void
    typealias AFAPIMasterFailure = () -> Void
    
    // MARK: -  Get Application Current Version API
    /*func getAppCurrentVersionData_Completion(params: NSMutableDictionary?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
     self.callAPIUsingGET(filePath: "apiVersionNew?", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict: Any, success: Bool) in
     if (success) {
     onSuccess(responseDict)
     }
     }, onFailure: { () in
     })
     }*/
    
    
    // MARK:-  LOGIN SCREEN
    func postLogin_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "login", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    
    //MARK:- Get DB
    func getDBApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure : @escaping (AFAPIMasterFailure)) {
        
        self.callAPI_GET(filePath:"get-last-file", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            onFailure()
        })
    }
    
    
    // MARK:-  ChangePasswordCall
    func postchangePasswordCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "changepassword", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    // MARK:-  ProfileUpdate
    func postProfileUpdateCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "update", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
//
    // MARK:-  LOGOUT
    func postLoginCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "login", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in

        })

    }
    
    // MARK:-  REGISTER
    func postRegisterCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "registration", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    // MARK:-  LOGIN SCREEN
    func postLogoutCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "logout", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    
    // MARK:-  Forgot password SCREEN
    func postForgotPasswordCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "forgot", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    
    //MARK:-  Get Theme color 
    
    func getEditProfileApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure: @escaping (AFAPIMasterFailure)) {
        
        self.callAPI_GET(filePath:"edit_profile", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            onFailure()
        })
    }
    //MARK:-  Get Category List 
    
    func getCategoryListApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure: @escaping (AFAPIMasterFailure)) {
        
        self.callAPI_GET(filePath:"master/category", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            onFailure()
        })
    }
    
    
    func getMesageApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure: @escaping (AFAPIMasterFailure)) {
        
        self.callAPI_GET(filePath:"log", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            onFailure()
        })
    }
    
    
    
    //MARK:-  Get HashTag List 
    
    func getCountryListApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure: @escaping (AFAPIMasterFailure)) {
        
        self.callAPI_GET(filePath:"countrylist", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            onFailure()
        })
    }
    
    // MARK:-  Create Note Screen
    func post_Create_Notes_Call_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST_Without_User(filePath: "jobs/addnotes", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    
    
    
    // MARK:-  Edit Note Screen
    func post_Edit_Notes_Call_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST_Without_User(filePath: "jobs/editnotes", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    
    // MARK:-  Delete Note Screen
    func post_Delete_Notes_Call_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST_Without_User(filePath: "jobs/deletenotes", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    
    
    // MARK:-  Product inquiry Screen
    func post_Product_inquiry_Call_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST_Without_User(filePath: "products/productinquiry", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    
    // MARK:-  JobMark As Done Click SCREEN
    func post_Job_cliked_Call_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST_Without_User(filePath: "jobs/markasdone", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    // MARK:-  PROFILE SCREEN
    func postProfileCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "profile_details", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
  
    
    // MARK:-  FORGOT SCREEN
    func postForgotPwdWithMobileCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "secure/do_forgot_password", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
    }
    
    // MARK:-  LOGIN SCREEN
    func postSignUpWithEmailCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "secure/do_register", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    func post_SignUP_User_Completion(image:UIImage?, params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure: @escaping (AFAPIMasterFailure)) {
        self.callAPI_ImageUpload_Sign(filePath: "user/socialmedialogin", image:image , params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }) {
            onFailure()
        }
    }
    
    func post_DB_Upload_Completion(image:Data?, params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure: @escaping (AFAPIMasterFailure)) {
        self.callAPI_Upload_DB(filePath: "file-upload", image:image , params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }) {
            onFailure()
        }
    }
    
    //MARK:-  Video Upload 
    func post_Video_Upload_User_Completion(image:Data?, params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure: @escaping (AFAPIMasterFailure)) {
        self.callAPI_VideoUpload_Sign(filePath: "jobs/addvideo", image:image , params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }) {
            onFailure()
        }
    }
    
    
    
    //MARK:-  Document Upload 
    func post_Document_Upload_User_Completion(image:Data?, params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure: @escaping (AFAPIMasterFailure)) {
        self.callAPI_DocumentUpload_Sign(filePath: "jobs/adddocument", image:image , params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }) {
            onFailure()
        }
    }
    
    //MARK:-  Rynn 
    
    
    func postRegistrationCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "register", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    func postSocialSignUpCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "social_login", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    //MARK:-  Forgot Password
    func postForgotPasswordAPICall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "forgot_password", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    //MARK:-  Forgot Password
    func postEditProfileAPICall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "edit_profile", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    func postLoginAPICall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "login", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    func postSubscriptionAPICall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "subscription", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    
    func postDeleteDataAPICall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "file-delete", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    //MARK:-  Change Password API Call 
    func postChangePasswordAPICall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "user/changepassword", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    //MARK:-  Get CommentList 
    func postCommentListAPICall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "/post/post_comment_list", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    //MARK:-  Add Comment 
    func addCommentAPICall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "/post/post_comment", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    //MARK:-  Get HomeFeed List 
    func postGetHomeFeedListAPICall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "dashboard/feeds", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    //MARK:-  Add Post 
    
    func postCreatePostAPICall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "post/add_post", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    func postSocial_LoginRegistration_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.call_API_POST_WithOutErrors(filePath: "social_login", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    //MARK:- MY ADDRESS
    func postADDLocationCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "rest_api/add_edit_address", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    func post_DELETE_LocationCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "rest_api/delete_address", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
        
    }
    
    func postNotifyMECall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        
        self.callAPI_POST(filePath: "secure/notify", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
    }
    //MARK:- CHANGE PASSWORD WS
    func post_ChangePass_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "rest_api/customer_change_password", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
    }
    
    //MARK:- CMS PAGE API
    func get_CMSPAGE_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        let strUserId =  Global.kretriUserData().User_id!

        self.callAPI_GET(filePath:"rest_api/cms_page?device_uuid=\(Global.DeviceUUID)&customer_id=\(strUserId)" , params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }) {
            
        }        
    }
    
    //MARK:- CHANGE PASSWORD WS
    func post_Notification_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure: @escaping (AFAPIMasterFailure)) {
        self.callAPI_POST(filePath: "rest_api/settings", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            onFailure()
        })
    }
    
    //MARK:- EDIT PROFILE IMAGE UPLOAD
    func post_EDIT_Profile_Completion(image:UIImage?, params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure: @escaping (AFAPIMasterFailure)) {
        self.callAPI_ImageUpload(filePath: "secure/customer_edit_profile", image:image , params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }) {
            onFailure()
        }
    }
    
    
    // MARK:-  FORGOT SCREEN
    func post_LogOutCall_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "secure/logout", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
    }
    
    
    
    
    //MARK: -  JobCardDetail
    
    
    func getJobCardListApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        
        self.callAPI_GET(filePath:"jobs/jobcardlist?api_token=\(params!["api_token"]!)&job_id=\(params!["Job_id"]!)&user_id=\(params!["user_id"]!)", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    //MARK: -  JobFolderDetail
    
    
    func getJobFolderDetailApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        
        self.callAPI_GET(filePath:"jobs/jobfolderlist?api_token=\(params!["api_token"]!)&job_id=\(params!["Job_id"]!)&user_id=\(params!["user_id"]!)", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    
    
    //MARK: -  JobNotesList
    
    
    func getJobNotesApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        
        self.callAPI_GET(filePath:"jobs/noteslist?api_token=\(params!["api_token"]!)&job_id=\(params!["Job_id"]!)&user_id=\(params!["user_id"]!)", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    
    //MARK: -  ProductList
    
    
    func getJobProductListApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        
        self.callAPI_GET(filePath:"products/productlist?api_token=\(params!["api_token"]!)&user_id=\(params!["user_id"]!)", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    
    
    //MARK: -  JobTaskFolderList
    
    
    func getJobTaskFolderListApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        
        self.callAPI_GET(filePath:"jobs/jobtaskfolderlist?api_token=\(params!["api_token"]!)&job_id=\(params!["Job_id"]!)&user_id=\(params!["user_id"]!)", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    
    //MARK: -  JobTaskDetail
    
    
    func getJobTaskDetailApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        
        self.callAPI_GET(filePath:"jobs/jobtasklist?api_token=\(params!["api_token"]!)&job_id=\(params!["Job_id"]!)&user_id=\(params!["user_id"]!)&folder_id=\(params!["folder_id"]!)", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    
    
    //MARK: -  VideoList
    
    
    func getVideoListApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        
        self.callAPI_GET(filePath:"jobs/foldervideodetail?api_token=\(params!["api_token"]!)&job_id=\(params!["Job_id"]!)&folder_id=\(params!["folder_id"]!)&user_id=\(params!["user_id"]!)", params: nil, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    
    //MARK: -  DocumentList
    
    
    func getDocumentListApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        
        self.callAPI_GET(filePath:"jobs/folderdocumentdetail?api_token=\(params!["api_token"]!)&job_id=\(params!["Job_id"]!)&folder_id=\(params!["folder_id"]!)&user_id=\(params!["user_id"]!)", params: nil, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    //MARK: -  JobDetail
    
    
    func getJobDetailApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        
        self.callAPI_GET(filePath:"jobs/jobdetail?api_token=\(params!["api_token"]!)&job_id=\(params!["Job_id"]!)&user_id=\(params!["user_id"]!)", params: nil, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
 
    //MARK: -  JobList
    
    
    func getAllJobListApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure : @escaping (AFAPIMasterFailure)) {
        
        self.callAPI_GET(filePath:"jobs/joblist", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            onFailure()
        })
    }
    
    
    func getAllArchieveJobListApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess), onFailure : @escaping (AFAPIMasterFailure)) {
        
        self.callAPI_GET(filePath:"jobs/archievejoblist", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            onFailure()
        })
    }
    
    // MARK: -  Forgot Password API
    func getAllCategoryListApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        let strUserId =  Global.kretriUserData().User_id!
        self.callAPI_GET(filePath:"rest_api/categories?panel=app&device_uuid=\(Global.DeviceUUID)&customer_id=\(strUserId)", params: nil, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    // MARK: -  CustomerAddress API
    func getAllLocationAddressDetailListApi_Completion(strApiUrl:String,params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_GET(filePath:strApiUrl, params: nil, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    
    // MARK: -  Edit Customer Address API
    func postEditCustomerAddress_Api_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        let strUserId =  Global.kretriUserData().User_id!

        self.callAPI_POST(filePath: "rest_api/add_edit_address?device_uuid=\(Global.DeviceUUID)&customer_id=\(strUserId)", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
    }
    
    
    // MARK: -  Get Pramotional List API
    func getAllPramotionalListApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        let strUserId =  Global.kretriUserData().User_id!

        self.callAPI_GET(filePath:"rest_api/promotional?device_uuid=\(Global.DeviceUUID)&customer_id=\(strUserId)", params: nil, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    
    // MARK: -  FAQ API Call
    func getFAQListApi_Completion(params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        let strUserId =  Global.kretriUserData().User_id!
        var strFaqLoginURl = ""
        if (Global.kretriUserData().IsLoggedIn!.toBool()) {
          strFaqLoginURl = "rest_api/faqs?panel=app&device_uuid=\(Global.DeviceUUID)&customer_id=\(strUserId)"
        } else  {
          strFaqLoginURl = "rest_api/faqs?panel=app&device_uuid=\(Global.DeviceUUID)"
        }

        self.callAPI_GET(filePath:strFaqLoginURl, params: nil, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    
    // MARK: -  Get Pramotional List API
    func getUserProfileDetailApi_Completion(strApiUrl:String,params: [String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_GET(filePath:strApiUrl, params: nil, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responceObj:Any, success:Bool) in
            onSuccess(responceObj)
        }, onFailure: {()  in
            
        })
    }
    
    // MARK: -  Edit Customer Address API
    func postEditCustomerProfile_Api_Completion(params:[String:Any]?, showLoader: Bool, enableInteraction: Bool, viewObj: UIView, onSuccess: @escaping (AFAPIMasterSuccess)) {
        self.callAPI_POST(filePath: "secure/customer_edit_profile", params: params, enableInteraction: enableInteraction, showLoader: showLoader, viewObj: viewObj, onSuccess: { (responseDict:Any, success:Bool) in
            if (success){
                onSuccess(responseDict)
            }
        }, onFailure:{ () in
            
        })
    }
    

   
    
}

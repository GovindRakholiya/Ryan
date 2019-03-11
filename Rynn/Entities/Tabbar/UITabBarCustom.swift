////
////  UITabBarCustom.swift
////  chilax
////
////  Created by Tops on 6/27/17.
////  Copyright © 2017 Tops. All rights reserved.
////
//
//import UIKit
//
//class UITabBarCustom: UITabBarController, UITabBarControllerDelegate {
//
//    var lblShadowLine: UILabel?
//    var btnTab1: UIButton?
//    var btnTab2: UIButton?
//    var btnTab3: UIButton?
//    var btnTab4: UIButton?
//    var btnTab5: UIButton?
//
//    var floatTabAspRatio: CGFloat?
//    var numberOfTabs:CGFloat = 5.0
//
//    // MARK: -  View Life Cycle Start Method
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.hideOriginalTabBar()
//        self.addCustomElements()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
//
//    // MARK: -  Hide Original Add Custom elements Method
//    func hideOriginalTabBar() {
//        for view in self.tabBar.subviews {
//            view.isHidden = true
//        }
//
//        for view in self.view.subviews {
//            if view is UITabBar {
//                view.isHidden = true
//                view.removeFromSuperview()
//                break;
//            }
//        }
//    }
//
//    func addCustomElements() {
//        floatTabAspRatio = Global.screenWidth/CGFloat(320)
//        self.removeAllOldElements()
//    }
//
//    func removeAllOldElements() {
//        if (btnTab1 != nil) {
//            btnTab1?.removeFromSuperview()
//        }
//        if (btnTab2 != nil) {
//            btnTab2?.removeFromSuperview()
//        }
//        if (btnTab3 != nil) {
//            btnTab3?.removeFromSuperview()
//        }
//        if (btnTab4 != nil) {
//            btnTab4?.removeFromSuperview()
//        }
//        if (btnTab5 != nil) {
//            btnTab5?.removeFromSuperview()
//        }
//        self.addAllElements()
//    }
//
//    func addAllElements() {
//        lblShadowLine = UILabel(frame: CGRect(x: 0, y: Global.screenHeight - (42 * floatTabAspRatio!), width: Global.screenWidth, height: 1))
//        lblShadowLine?.layer.shadowColor = UIColor.darkGray.cgColor
//        lblShadowLine?.layer.shadowOpacity = 0.3
//        lblShadowLine?.layer.shadowOffset = CGSize.zero
//        lblShadowLine?.layer.shadowRadius = 1
//        lblShadowLine?.layer.shadowPath = UIBezierPath(rect: (lblShadowLine?.bounds)!).cgPath
//        self.view.addSubview(lblShadowLine!)
//
//        if (Singleton.sharedSingleton.UserType == Global.userType.doctor)
//        {
//            btnTab1 = self.generateTabButton(0, isSelected: true)
//            //self.setShadow(to: btnTab1!)
//            btnTab2 = self.generateTabButton(1, isSelected: false)
//            //self.setShadow(to: btnTab2!)
//            btnTab3 = self.generateTabButton(2, isSelected: false)
//            //self.setShadow(to: btnTab3!)
//            btnTab4 = self.generateTabButton(3, isSelected: false)
//            //self.setShadow(to: btnTab4!)
//            btnTab5 = self.generateTabButton(4, isSelected: false)
//
//
//            self.view.addSubview(btnTab1!)
//            self.view.addSubview(btnTab2!)
//            self.view.addSubview(btnTab3!)
//            self.view.addSubview(btnTab4!)
//            self.view.addSubview(btnTab5!)
//
//            btnTab1?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
//            btnTab1?.tag = 1
//            btnTab2?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
//            btnTab2?.tag = 2
//            btnTab3?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
//            btnTab3?.tag = 3
//            btnTab4?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
//            btnTab4?.tag = 4
//            btnTab5?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
//            btnTab5?.tag = 5
//        }
//        else
//        {
//            btnTab1 = self.generateTabButton(0, isSelected: true)
//            //self.setShadow(to: btnTab1!)
//            btnTab2 = self.generateTabButton(1, isSelected: false)
//            //self.setShadow(to: btnTab2!)
//            btnTab3 = self.generateTabButton(2, isSelected: false)
//            //self.setShadow(to: btnTab3!)
//            btnTab4 = self.generateTabButton(3, isSelected: false)
//
//
//
//            self.view.addSubview(btnTab1!)
//            self.view.addSubview(btnTab2!)
//            self.view.addSubview(btnTab3!)
//            self.view.addSubview(btnTab4!)
////            self.view.addSubview(btnTab5!)
//
//            btnTab1?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
//            btnTab1?.tag = 1
//            btnTab2?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
//            btnTab2?.tag = 2
//            btnTab3?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
//            btnTab3?.tag = 3
//            btnTab4?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
//            btnTab4?.tag = 4
////            btnTab5?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
////            btnTab5?.tag = 5
//
//
//            //self.setShadow(to: btnTab4!)
////            btnTab5 = self.generateTabButton(4, isSelected: false)
//        }
//
//
//        let rect: CGRect = UIApplication.shared.statusBarFrame
//        if (rect.size.height > 20) {
//            self.changeFrameOfAllCustomElementForStatusBarHeightChange(2)
//        }
//    }
//
//    func generateTabButton(_ intTag: Int, isSelected boolSel: Bool) -> UIButton {
//        let btn = UIButton(type: .custom)
//        btn.tag = intTag
//        btn.isSelected = boolSel
//        //btn.titleLabel?.font = UIFont(name: Global.kFont.QwallFont, size: Global.singleton.getDeviceSpecificFontSize(18))
//
//        btn.setTitleColor(UIColor.lightGray, for: .normal)
//        btn.setTitleColor(UIColor.black, for: .highlighted)
//        btn.setTitleColor(UIColor.black, for: .selected)
//
//        let tempY: CGFloat = Global.screenHeight - (42 * floatTabAspRatio!)
//        let tempBtnHeight: CGFloat = 42 * floatTabAspRatio!
//        let tempBtnWidth: CGFloat = Global.screenWidth / numberOfTabs
//
//        switch intTag {
//        case 0: //Tab-1
//            //btn.setTitle("", for: .normal) // ADD
//            btn.frame = CGRect(x: 0 + (tempBtnWidth * 0), y: tempY, width: tempBtnWidth, height: tempBtnHeight)
//            btn.backgroundColor = UIColor.white
//            btn.setTitleColor(UIColor.white, for: .selected)
////            btn.titleLabel?.font = UIFont(name: "Alamaaree_TOPS", size: 30.0   )
////            btn.setTitle("", for: .normal)
////            if (btn.isSelected == true)
////            {
////                btn.backgroundColor = Global.kAppColor.PrimaryPink
////            }
////            else
////            {
////                btn.backgroundColor = Global.kAppColor.SecondaryWhite
////            }
//            btn.setImage(#imageLiteral(resourceName: "Home_tabbar"), for: .normal)
////            btn.setImage(#imageLiteral(resourceName: "login_logo"), for: .selected)
//        case 1: //Tab-2
//
//            //btn.setTitle("", for: .normal) // List
////            btn.setImage(#imageLiteral(resourceName: "unselectedtabbarsecondicon"), for: .normal)
////            btn.setImage(#imageLiteral(resourceName: "selectedtabbarsecondicon"), for: .selected)
//
////            btn.titleLabel?.font = UIFont(name: "Alamaaree_TOPS", size: 30.0)
////            btn.setTitle("", for: .normal)
////            if (btn.isSelected == true)
////            {
////                btn.backgroundColor = Global.kAppColor.PrimaryPink
////            }
////            else
////            {
////                btn.backgroundColor = Global.kAppColor.SecondaryWhite
////            }
////             btn.setTitle("", for: .normal)
//            btn.setImage(#imageLiteral(resourceName: "search_tabbar"), for: .normal)
//            btn.frame = CGRect(x: 0 + (tempBtnWidth * 1), y: tempY, width: tempBtnWidth, height: tempBtnHeight)
//            btn.backgroundColor = UIColor.white
//            btn.setTitleColor(UIColor.white, for: .selected)
//        case 2: //Tab-3
//
//            //btn.setTitle("", for: .normal) //Camera
////            btn.titleLabel?.font = UIFont(name: "Alamaaree_TOPS", size: 30.0)
////            btn.setTitle("", for: .normal)
////            if (btn.isSelected == true)
////            {
////                btn.backgroundColor = Global.kAppColor.PrimaryPink
////            }
////            else
////            {
////                btn.backgroundColor = Global.kAppColor.SecondaryWhite
////            }
////            btn.setImage(#imageLiteral(resourceName: "login_logo"), for: .normal)
////            btn.setImage(#imageLiteral(resourceName: "login_logo"), for: .selected)
//            if (Singleton.sharedSingleton.UserType == Global.userType.doctor)
//            {
//                btn.setImage(#imageLiteral(resourceName: "favourite_tabbar"), for: .normal)
//            }
//            else
//            {
//                btn.setImage(#imageLiteral(resourceName: "Job_tabbar"), for: .normal)
//            }
//
//            btn.frame = CGRect(x: 0 + (tempBtnWidth * 2), y: tempY, width: tempBtnWidth, height: tempBtnHeight)
//            btn.backgroundColor = UIColor.white
//            btn.setTitleColor(UIColor.white, for: .selected)
//        case 3: //Tab-4
//
//            //btn.setTitle("", for: .normal) //Profile
////            btn.titleLabel?.font = UIFont(name: "Alamaaree_TOPS", size: 30.0)
////            btn.setTitle("", for: .normal)
////            if (btn.isSelected == true)
////            {
////                btn.backgroundColor = Global.kAppColor.PrimaryPink
////            }
////            else
////            {
////                btn.backgroundColor = Global.kAppColor.SecondaryWhite
////            }
////            btn.setImage(#imageLiteral(resourceName: "login_logo"), for: .normal)
////            btn.setImage(#imageLiteral(resourceName: "login_logo"), for: .selected)
//
//            btn.setImage(#imageLiteral(resourceName: "Wishes_tabbar"), for: .normal)
//            btn.frame = CGRect(x: 0 + (tempBtnWidth * 3), y: tempY, width: tempBtnWidth, height: tempBtnHeight)
//            btn.backgroundColor = UIColor.white
//            btn.setTitleColor(UIColor.white, for: .selected)
//
//        case 4: //Tab-5
//            //btn.setTitle("", for: .normal) //Profile
////            btn.titleLabel?.font = UIFont(name: "Alamaaree_TOPS", size: 30.0)
////            btn.setTitle("", for: .normal)
////            if (btn.isSelected == true)
////            {
////                btn.backgroundColor = Global.kAppColor.PrimaryPink
////            }
////            else
////            {
////                btn.backgroundColor = Global.kAppColor.SecondaryWhite
////            }
////            btn.setImage(#imageLiteral(resourceName: "login_logo"), for: .normal)
////            btn.setImage(#imageLiteral(resourceName: "login_logo"), for: .selected)
//            btn.setImage(#imageLiteral(resourceName: "chat_tabbar"), for: .normal)
//            btn.frame = CGRect(x: 0 + (tempBtnWidth * 4), y: tempY, width: tempBtnWidth, height: tempBtnHeight)
//            btn.backgroundColor = UIColor.white
//            btn.setTitleColor(UIColor.white, for: .selected)
//        default:
//            break
//        }
//        return btn;
//    }
//
//    // MARK: -  Button Click Methods
//    @objc func buttonClicked (_ sender: UIButton) {
//        switch sender.tag {
//        case 1:
//            self.selectTab(0)
//
//        case 2:
//            self.selectTab(1)
//
//        case 3:
//            self.selectTab(2)
//
//        case 4:
//            self.selectTab(3)
//
//        case 5:
//            self.selectTab(4)
//        default:
//            break
//        }
//    }
//
//    func setTabbaritemColor(index:Int, newcolorIndex:Int)
//    {
//        btnTab1?.isSelected = false
//        btnTab2?.isSelected = false
//        btnTab3?.isSelected = false
//        btnTab4?.isSelected = false
//        btnTab5?.isSelected = false
//
//        if index == 0
//        {
//            btnTab1?.isSelected = true
//            btnTab1?.backgroundColor = Global.kAppColor.PrimaryPink
//            btnTab2?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab3?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab4?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab5?.backgroundColor = Global.kAppColor.SecondaryWhite
//        }
//        else if index == 1
//        {
//            btnTab1?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab2?.backgroundColor = Global.kAppColor.PrimaryPink
//            btnTab3?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab4?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab5?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab2?.isSelected = true
//        }
//        else if index == 2
//        {
//            btnTab1?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab2?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab3?.backgroundColor = Global.kAppColor.PrimaryPink
//            btnTab4?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab5?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab3?.isSelected = true
//        }
//        else if index == 3
//        {
//            btnTab1?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab2?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab3?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab4?.backgroundColor = Global.kAppColor.PrimaryPink
//            btnTab5?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab4?.isSelected = true
//        }
//        else{
//            btnTab1?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab2?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab3?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab4?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab5?.backgroundColor = Global.kAppColor.PrimaryPink
//            btnTab5?.isSelected = true
//        }
//    }
//
//    // MARK: -  Tab bar selection
//    func selectTab (_ intSelTabId: Int) {
//        if (self.selectedIndex == intSelTabId) {
//            let navController: UINavigationController = (self.selectedViewController as? UINavigationController)!
//            btnTab1?.isSelected = true
//            btnTab1?.backgroundColor = Global.kAppColor.PrimaryPink
//            btnTab2?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab3?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab4?.backgroundColor = Global.kAppColor.SecondaryWhite
//            btnTab5?.backgroundColor = Global.kAppColor.SecondaryWhite
//            navController.popToRootViewController(animated: true)
//        }
//        else {
//            self.setTabbaritemColor(index: intSelTabId, newcolorIndex:intSelTabId)
//            self.selectedIndex = intSelTabId
//        }
//    }
//
//    // MARK: -  Hide Show Tabbar
//    func showTabBar() {
//        lblShadowLine?.isHidden = false
//        btnTab1?.isHidden = false
//        btnTab2?.isHidden = false
//        btnTab3?.isHidden = false
//        btnTab4?.isHidden = false
//        btnTab5?.isHidden = false
//        btnTab1?.isUserInteractionEnabled = true
//        btnTab2?.isUserInteractionEnabled = true
//        btnTab3?.isUserInteractionEnabled = true
//        btnTab4?.isUserInteractionEnabled = true
//        btnTab5?.isUserInteractionEnabled = true
//    }
//
//    func hideTabBar() {
//        lblShadowLine?.isHidden = true
//        btnTab1?.isHidden = true
//        btnTab2?.isHidden = true
//        btnTab3?.isHidden = true
//        btnTab4?.isHidden = true
//        btnTab5?.isHidden = true
//
//        btnTab1?.isUserInteractionEnabled = false
//        btnTab2?.isUserInteractionEnabled = false
//        btnTab3?.isUserInteractionEnabled = false
//        btnTab4?.isUserInteractionEnabled = false
//        btnTab5?.isUserInteractionEnabled = false
//    }
//
//    func changeFrameOfAllCustomElementForStatusBarHeightChange(_ flag:Int) {
//        var tempIncDec: CGFloat = 0;
//        if (flag == 1) {
//            tempIncDec = 20
//        }
//        else if (flag == 2) {
//            tempIncDec = -20;
//        }
//
//        self.btnTab1?.frame = CGRect(x: btnTab1!.frame.origin.x, y: btnTab1!.frame.origin.y + tempIncDec, width: self.btnTab1!.frame.size.width, height: self.btnTab1!.frame.size.height)
//        self.btnTab1?.backgroundColor = UIColor.white
//
//        self.btnTab2?.frame = CGRect(x: btnTab2!.frame.origin.x, y: btnTab2!.frame.origin.y + tempIncDec, width: self.btnTab2!.frame.size.width, height: self.btnTab2!.frame.size.height)
//        self.btnTab2?.backgroundColor = UIColor.white
//
//        self.btnTab3?.frame = CGRect(x: btnTab3!.frame.origin.x, y: btnTab3!.frame.origin.y + tempIncDec, width: self.btnTab3!.frame.size.width, height: self.btnTab3!.frame.size.height)
//        self.btnTab3?.backgroundColor = UIColor.white
//
//        self.btnTab4?.frame = CGRect(x: btnTab4!.frame.origin.x, y: btnTab4!.frame.origin.y + tempIncDec, width: self.btnTab4!.frame.size.width, height: self.btnTab4!.frame.size.height)
//        self.btnTab4?.backgroundColor = UIColor.white
//
//        self.btnTab5?.frame = CGRect(x: btnTab5!.frame.origin.x, y: btnTab5!.frame.origin.y + tempIncDec, width: self.btnTab5!.frame.size.width, height: self.btnTab5!.frame.size.height)
//        self.btnTab5?.backgroundColor = UIColor.white
//    }
//
//    func setShadow(to view:UIView) {
//        //let shadowSize : CGFloat = 2.0
//        //view.layer.frame = view.bounds
//        view.layer.masksToBounds = false
//        view.layer.shadowColor = UIColor.gray.cgColor
//        view.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
//        view.layer.shadowOpacity = 0.5
//        //view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
//    }
//}
//
//  UITabBarCustom.swift
//  chilax
//
//  Created by Tops on 6/27/17.
//  Copyright © 2017 Tops. All rights reserved.
//

import UIKit

class UITabBarCustom: UITabBarController, UITabBarControllerDelegate {
    
    var lblShadowLine: UILabel?
    var btnTab1: UIButton?
    var btnTab2: UIButton?
    var btnTab3: UIButton?
    var btnTab4: UIButton?
    var btnTab5: UIButton?
    

    
    var floatTabAspRatio: CGFloat?
    var numberOfTabs:CGFloat = 4.0
    
    // MARK: -  View Life Cycle Start Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideOriginalTabBar()
        self.addCustomElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: -  Hide Original Add Custom elements Method
    func hideOriginalTabBar() {
        for view in self.tabBar.subviews {
            view.isHidden = true
        }
        
        for view in self.view.subviews {
            if view is UITabBar {
                view.isHidden = true
                view.removeFromSuperview()
                break;
            }
        }
    }
    
    func addCustomElements() {
        floatTabAspRatio = Global.screenWidth/CGFloat(320)
        self.removeAllOldElements()
    }
    
    func removeAllOldElements() {
        if (btnTab1 != nil) {
            btnTab1?.removeFromSuperview()
        }
        if (btnTab2 != nil) {
            btnTab2?.removeFromSuperview()
        }
        if (btnTab3 != nil) {
            btnTab3?.removeFromSuperview()
        }
        if (btnTab4 != nil) {
            btnTab4?.removeFromSuperview()
        }
        if (btnTab5 != nil) {
            btnTab5?.removeFromSuperview()
        }
       
        self.addAllElements()
    }
    
    func addAllElements() {
        lblShadowLine = UILabel(frame: CGRect(x: 0, y: Global.screenHeight - (42 * floatTabAspRatio!), width: Global.screenWidth, height: 1))
        lblShadowLine?.layer.shadowColor = UIColor.darkGray.cgColor
        lblShadowLine?.layer.shadowOpacity = 0.3
        lblShadowLine?.layer.shadowOffset = CGSize.zero
        lblShadowLine?.layer.shadowRadius = 1
        lblShadowLine?.layer.shadowPath = UIBezierPath(rect: (lblShadowLine?.bounds)!).cgPath
        self.view.addSubview(lblShadowLine!)
        
        btnTab1 = self.generateTabButton(0, isSelected: true)
        //self.setShadow(to: btnTab1!)
        btnTab2 = self.generateTabButton(1, isSelected: false)
        //self.setShadow(to: btnTab2!)
        btnTab3 = self.generateTabButton(2, isSelected: false)
        //self.setShadow(to: btnTab3!)
        btnTab4 = self.generateTabButton(3, isSelected: false)
        //self.setShadow(to: btnTab4!)
        btnTab5 = self.generateTabButton(4, isSelected: false)
        
        self.view.addSubview(btnTab1!)
        self.view.addSubview(btnTab2!)
        self.view.addSubview(btnTab3!)
        self.view.addSubview(btnTab4!)
        self.view.addSubview(btnTab5!)
        
        
        btnTab1?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
        btnTab1?.tag = 1
        btnTab2?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
        btnTab2?.tag = 2
        btnTab3?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
        btnTab3?.tag = 3
        btnTab4?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
        btnTab4?.tag = 4
        btnTab5?.addTarget(self, action: #selector(UITabBarCustom.buttonClicked(_:)), for: .touchUpInside)
        btnTab5?.tag = 5
        let rect: CGRect = UIApplication.shared.statusBarFrame
        if (rect.size.height > 20) {
            self.changeFrameOfAllCustomElementForStatusBarHeightChange(2)
        }
    }
    
    func generateTabButton(_ intTag: Int, isSelected boolSel: Bool) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.tag = intTag
        btn.isSelected = boolSel
        //btn.titleLabel?.font = UIFont(name: Global.kFont.QwallFont, size: Global.singleton.getDeviceSpecificFontSize(18))
        
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.setTitleColor(UIColor.black, for: .highlighted)
        btn.setTitleColor(UIColor.black, for: .selected)
        
        let tempY: CGFloat = Global.screenHeight - (48 * floatTabAspRatio!)
        let tempBtnHeight: CGFloat = 48 * floatTabAspRatio!
        let tempBtnWidth: CGFloat = Global.screenWidth / numberOfTabs
        
        switch intTag {
        case 0: //Tab-1
            //btn.setTitle("", for: .normal) // ADD
            btn.frame = CGRect(x: 0 + (tempBtnWidth * 0), y: tempY, width: tempBtnWidth, height: tempBtnHeight)
            btn.backgroundColor = UIColor.white
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.titleLabel?.font = UIFont(name: "Alamaaree_TOPS", size: 26.0)
            btn.clipsToBounds = true
            //            btn.setTitle("", for: .normal)
            btn.titleEdgeInsets = UIEdgeInsetsMake(-07, 0,0, 0)
           
            
            //elf.lblHome.bringSubview(toFront: btn)
            
            //            if (btn.isSelected == true)
            //            {
            //                btn.backgroundColor = Global.kAppColor.PrimaryPink
            //            }
            //            else
            //            {
            //                btn.backgroundColor = Global.kAppColor.SecondaryWhite
            //            }
            btn.setImage(#imageLiteral(resourceName: "tabHomeNotSelected"), for: .normal)
            btn.setImage(#imageLiteral(resourceName: "tabHomeSelected"), for: .selected)
        case 1: //Tab-2
            
            //btn.setTitle("", for: .normal) // List
            btn.setImage(#imageLiteral(resourceName: "tabExpenseListUnselected"), for: .normal)
            btn.setImage(#imageLiteral(resourceName: "tabExpenseListSelected"), for: .selected)
            
            //            btn.titleLabel?.font = UIFont(name: "Alamaaree_TOPS", size: 26.0)
            //            btn.setTitle("", for: .normal)
            //            btn.titleEdgeInsets = UIEdgeInsetsMake(-07, 0,0, 0)
            //            if (btn.isSelected == true)
            //            {
            //                btn.backgroundColor = Global.kAppColor.PrimaryPink
            //            }
            //            else
            //            {
            //                btn.backgroundColor = Global.kAppColor.SecondaryWhite
            //            }
            //             btn.setTitle("", for: .normal)
            btn.frame = CGRect(x: 0 + (tempBtnWidth * 1), y: tempY, width: tempBtnWidth, height: tempBtnHeight)
            btn.backgroundColor = UIColor.white
            btn.setTitleColor(UIColor.white, for: .selected)
            
           
            
        case 2: //Tab-3
            
            //btn.setTitle("", for: .normal) //Camera
            //            btn.titleLabel?.font = UIFont(name: "Alamaaree_TOPS", size: 26.0)
            //            btn.setTitle("", for: .normal)
            btn.titleEdgeInsets = UIEdgeInsetsMake(-07, 0,0, 0)
            //            if (btn.isSelected == true)
            //            {
            //                btn.backgroundColor = Global.kAppColor.PrimaryPink
            //            }
            //            else
            //            {
            //                btn.backgroundColor = Global.kAppColor.SecondaryWhite
            //            }
            btn.setImage(#imageLiteral(resourceName: "tabReportUnselected"), for: .normal)
            btn.setImage(#imageLiteral(resourceName: "tabExpenseListSelected"), for: .selected)
            btn.frame = CGRect(x: 0 + (tempBtnWidth * 2), y: tempY, width: tempBtnWidth, height: tempBtnHeight)
            btn.backgroundColor = UIColor.white
            btn.setTitleColor(UIColor.white, for: .selected)
           
        case 3: //Tab-4
            
            //btn.setTitle("", for: .normal) //Profile
            //            btn.titleLabel?.font = UIFont(name: "Alamaaree_TOPS", size: 26.0)
            //            btn.setTitle("", for: .normal)
            btn.titleEdgeInsets = UIEdgeInsetsMake(-07, 0,0, 0)
//                        if (btn.isSelected == true)
//                        {
//                            btn.backgroundColor = Global.kAppColor.PrimaryPink
//                        }
//                        else
//                        {
//                            btn.backgroundColor = Global.kAppColor.SecondaryWhite
//                        }
            btn.setImage(#imageLiteral(resourceName: "tabUserNotselected"), for: .normal)
            btn.setImage(#imageLiteral(resourceName: "tabUserSelected"), for: .selected)
            btn.frame = CGRect(x: 0 + (tempBtnWidth * 3), y: tempY, width: tempBtnWidth, height: tempBtnHeight)
            btn.backgroundColor = UIColor.white
            btn.setTitleColor(UIColor.white, for: .selected)
           
            
//        case 4: //Tab-5
//            //btn.setTitle("", for: .normal) //Profile
//            //            btn.titleLabel?.font = UIFont(name: "Alamaaree_TOPS", size: 26.0)
//            //            btn.setTitle("", for: .normal)
//            btn.titleEdgeInsets = UIEdgeInsetsMake(-07, 0,0, 0)
//            //            if (btn.isSelected == true)
//            //            {
//            //                btn.backgroundColor = Global.kAppColor.PrimaryPink
//            //            }
//            //            else
//            //            {
//            //                btn.backgroundColor = Global.kAppColor.SecondaryWhite
//            //            }
//            btn.setImage(#imageLiteral(resourceName: "comments_gray"), for: .normal)
//            btn.setImage(#imageLiteral(resourceName: "comments_red"), for: .selected)
//            btn.frame = CGRect(x: 0 + (tempBtnWidth * 4), y: tempY, width: tempBtnWidth, height: tempBtnHeight)
//            btn.backgroundColor = UIColor.white
//            btn.setTitleColor(UIColor.white, for: .selected)
//
//            if (UIDevice.isIphoneX)
//            {
//                self.lblProfile.frame = CGRect(x: 0 + (tempBtnWidth * 4), y: self.view.frame.size.height - 34, width: tempBtnWidth, height: 10)
//            }
//            else
//            {
//                self.lblProfile.frame = CGRect(x: 0 + (tempBtnWidth * 4), y: self.view.frame.size.height - 14, width: tempBtnWidth, height: 10)
//            }
//
//            self.lblProfile.backgroundColor = UIColor.clear
//            self.lblProfile.textColor = UIColor.white
//            self.lblProfile.font = self.lblProfile.font.withSize(9)
//
//            self.lblProfile.textAlignment = .center
//            self.lblProfile.text = "Chat"
//
        default:
            break
        }
        return btn;
    }
    
    // MARK: -  Button Click Methods
    @objc func buttonClicked (_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.selectTab(0)
            
        case 2:
            self.selectTab(1)
            
        case 3:
            self.selectTab(2)
            
        case 4:
            self.selectTab(3)
            
        default:
            break
        }
    }
    
    func setTabbaritemColor(index:Int, newcolorIndex:Int)
    {
        btnTab1?.isSelected = false
        btnTab2?.isSelected = false
        btnTab3?.isSelected = false
        btnTab4?.isSelected = false
        btnTab5?.isSelected = false
        
        if index == 0
        {
            btnTab1?.isSelected = true
            btnTab1?.backgroundColor = Global.kAppColor.White
            btnTab2?.backgroundColor = Global.kAppColor.SecondaryWhite
            btnTab3?.backgroundColor = Global.kAppColor.SecondaryWhite
            btnTab4?.backgroundColor = Global.kAppColor.SecondaryWhite
            btnTab5?.backgroundColor = Global.kAppColor.SecondaryWhite
            
        }
        else if index == 1
        {
                        btnTab1?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab2?.backgroundColor = Global.kAppColor.White
                        btnTab3?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab4?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab5?.backgroundColor = Global.kAppColor.SecondaryWhite
            btnTab2?.isSelected = true
         
        }
        else if index == 2
        {
                        btnTab1?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab2?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab3?.backgroundColor = Global.kAppColor.White
                        btnTab4?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab5?.backgroundColor = Global.kAppColor.SecondaryWhite
            btnTab3?.isSelected = true
          
        }
        else if index == 3
        {
                        btnTab1?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab2?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab3?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab4?.backgroundColor = Global.kAppColor.White
                        btnTab5?.backgroundColor = Global.kAppColor.SecondaryWhite
            btnTab4?.isSelected = true
            
            
        }
        else{
                        btnTab1?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab2?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab3?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab4?.backgroundColor = Global.kAppColor.SecondaryWhite
                        btnTab5?.backgroundColor = Global.kAppColor.White
            btnTab5?.isSelected = true
            
           
        }
    }
    
    // MARK: -  Tab bar selection
    func selectTab (_ intSelTabId: Int) {
        //        print(intSelTabId)
        //        print(self.selectedIndex)
        if (self.selectedIndex == intSelTabId) {
            self.setTabbaritemColor(index: intSelTabId, newcolorIndex:intSelTabId)
            self.selectedIndex = intSelTabId
            //            let navController: UINavigationController = (self.selectedViewController as? UINavigationController)!
            //            btnTab1?.isSelected = true
            //            btnTab1?.backgroundColor = Global.kAppColor.PrimaryPink
            //            btnTab2?.backgroundColor = Global.kAppColor.SecondaryWhite
            //            btnTab3?.backgroundColor = Global.kAppColor.SecondaryWhite
            //            btnTab4?.backgroundColor = Global.kAppColor.SecondaryWhite
            //            btnTab5?.backgroundColor = Global.kAppColor.SecondaryWhite
            //            navController.popToRootViewController(animated: true)
        }
        else {
            self.setTabbaritemColor(index: intSelTabId, newcolorIndex:intSelTabId)
            self.selectedIndex = intSelTabId
        }
    }
    
    // MARK: -  Hide Show Tabbar
    func showTabBar() {
        lblShadowLine?.isHidden = false
        btnTab1?.isHidden = false
        btnTab2?.isHidden = false
        btnTab3?.isHidden = false
        btnTab4?.isHidden = false
        btnTab5?.isHidden = false
     
        
        btnTab1?.isUserInteractionEnabled = true
        btnTab2?.isUserInteractionEnabled = true
        btnTab3?.isUserInteractionEnabled = true
        btnTab4?.isUserInteractionEnabled = true
        btnTab5?.isUserInteractionEnabled = true
    }
    
    func hideTabBar() {
        lblShadowLine?.isHidden = true
        btnTab1?.isHidden = true
        btnTab2?.isHidden = true
        btnTab3?.isHidden = true
        btnTab4?.isHidden = true
        btnTab5?.isHidden = true
        
     
        btnTab1?.isUserInteractionEnabled = false
        btnTab2?.isUserInteractionEnabled = false
        btnTab3?.isUserInteractionEnabled = false
        btnTab4?.isUserInteractionEnabled = false
        btnTab5?.isUserInteractionEnabled = false
    }
    
    func changeFrameOfAllCustomElementForStatusBarHeightChange(_ flag:Int) {
        var tempIncDec: CGFloat = 0;
        if (flag == 1) {
            tempIncDec = 20
        }
        else if (flag == 2) {
            tempIncDec = -20;
        }
        
        self.btnTab1?.frame = CGRect(x: btnTab1!.frame.origin.x, y: btnTab1!.frame.origin.y + tempIncDec, width: self.btnTab1!.frame.size.width, height: self.btnTab1!.frame.size.height)
        self.btnTab1?.backgroundColor = UIColor.white
        
        self.btnTab2?.frame = CGRect(x: btnTab2!.frame.origin.x, y: btnTab2!.frame.origin.y + tempIncDec, width: self.btnTab2!.frame.size.width, height: self.btnTab2!.frame.size.height)
        self.btnTab2?.backgroundColor = UIColor.white
        
        self.btnTab3?.frame = CGRect(x: btnTab3!.frame.origin.x, y: btnTab3!.frame.origin.y + tempIncDec, width: self.btnTab3!.frame.size.width, height: self.btnTab3!.frame.size.height)
        self.btnTab3?.backgroundColor = UIColor.white
        
        self.btnTab4?.frame = CGRect(x: btnTab4!.frame.origin.x, y: btnTab4!.frame.origin.y + tempIncDec, width: self.btnTab4!.frame.size.width, height: self.btnTab4!.frame.size.height)
        self.btnTab4?.backgroundColor = UIColor.white
        
        self.btnTab5?.frame = CGRect(x: btnTab5!.frame.origin.x, y: btnTab5!.frame.origin.y + tempIncDec, width: self.btnTab5!.frame.size.width, height: self.btnTab5!.frame.size.height)
        self.btnTab5?.backgroundColor = UIColor.white
    }
    
    func setShadow(to view:UIView) {
        //let shadowSize : CGFloat = 2.0
        //view.layer.frame = view.bounds
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        view.layer.shadowOpacity = 0.5
        //view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    }
}




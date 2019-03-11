//
//  ViewSort.swift
//  Club_Mobile
//
//  Created by Tops on 12/24/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit
class ViewSort: UIView  {
    

    @IBOutlet weak var lblSortby: UILabel!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var lblOrderd: UILabel!
    @IBOutlet weak var btnOrderd: UIButton!
    @IBOutlet weak var btnSort: UIButton!
    
    
    var is_Date = false
    var arrDate = ["Obj1", "Obj2", "Obj3", "Obj4", "Obj5"]
    var arrOrderd = ["Obj1", "Obj2", "Obj3", "Obj4", "Obj5"]
    override func awakeFromNib() {

    }
    
    @IBAction func btnDateClick(_ sender: Any) {
        
    }
    @IBAction func btnOrderClick(_ sender: Any) {

    }
    @IBAction func btnSortClick(_ sender: Any) {
        
    }
}

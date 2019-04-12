//
//  DailyExpenseTableViewCell.swift
//  BUILD
//
//  Created by Ishan Vyas on 12/04/19.
//  Copyright © 2019 Govind Rakholiya. All rights reserved.
//

import UIKit

class DailyExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var insideView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        Singleton.sharedSingleton.setCornerRadius(view: insideView, radius: 5.0)
//        Singleton.sharedSingleton.setShadow(to: insideView)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

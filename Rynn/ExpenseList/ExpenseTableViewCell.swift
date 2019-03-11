//
//  ExpenseTableViewCell.swift
//  Rynn
//
//  Created by Govind Rakholiya on 13/10/18.
//  Copyright © 2018 Govind Rakholiya. All rights reserved.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var imgExpense: UIImageView!
    @IBOutlet weak var viewOutSide: UIView!
    @IBOutlet weak var viewCornerRadius: UIView!
    @IBOutlet weak var btnExpenseType: UIButton!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblcategoryNameAndDate: UILabel!
    @IBOutlet weak var expensetitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        Singleton.sharedSingleton.setCornerRadius(view: viewOutSide, radius: 5.0)
        Singleton.sharedSingleton.setShadow(to: viewOutSide)
        btnExpenseType.layer.borderWidth = 1.0
        btnExpenseType.layer.borderColor = UIColor.darkGray.cgColor
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

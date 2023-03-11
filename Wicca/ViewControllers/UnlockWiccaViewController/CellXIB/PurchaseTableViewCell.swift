//
//  PurchaseTableViewCell.swift
//  Wicca
//
//  Created by Jay Jariwala on 12/04/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class PurchaseTableViewCell: UITableViewCell {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var alreadyMemberButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        continueButton.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

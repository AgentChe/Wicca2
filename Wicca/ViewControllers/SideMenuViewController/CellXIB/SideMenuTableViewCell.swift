//
//  SideMenuTableViewCell.swift
//  Wicca
//
//  Created by Jay Jariwala on 27/01/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItemICImageView: UIImageView!
    @IBOutlet weak var menuItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

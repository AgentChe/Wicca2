//
//  MenuItemCollectionViewCell.swift
//  Wicca
//
//  Created by Jay Jariwala on 26/01/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class MenuItemCollectionViewCell: UICollectionViewCell {
    
    enum CellUserType {
        case HomeMenus
        case CalenderMonths
    }

    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    
    var cellUserType: CellUserType = .HomeMenus
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch cellUserType {
        case .HomeMenus:
            itemLabel.isHidden = false
            if UIScreen.main.bounds.height <= 568.0 {
                itemLabel.font = UIFont.init(type: .PlayfairDisplay_Regular, size: 17)
            } else {
                itemLabel.font = UIFont.init(type: .PlayfairDisplay_Regular, size: 20)
            }
            break
        case .CalenderMonths:
            if UIScreen.main.bounds.height <= 568.0 {
                itemLabel.font = UIFont.init(type: .PlayfairDisplay_Regular, size: 13)
            } else {
                itemLabel.font = UIFont.init(type: .PlayfairDisplay_Regular, size: 15)
            }
            itemLabel.isHidden = true
            break
        }
    }

}

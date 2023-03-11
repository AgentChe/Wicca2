//
//  CategoryTableViewCell.swift
//  Wicca
//
//  Created by Jay Jariwala on 27/01/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    enum CellUseType {
        case Category, HerbsAndOils, LunarCalender, CandleColor
    }

    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var seperator: UILabel!
    @IBOutlet weak var categoryLabelHeight: NSLayoutConstraint!
    
    var cellUseType: CellUseType = .Category
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch cellUseType {
        case .Category:
            categoryTitleLabel.font = UIFont.init(type: .PlayfairDisplay_Regular, size: 25)
            seperator.isHidden = false
            categoryLabelHeight.priority = .defaultLow
            categoryTitleLabel.numberOfLines = 0
            break
        case .HerbsAndOils, .CandleColor:
            categoryTitleLabel.font = UIFont.init(type: .PlayfairDisplay_Regular, size: 20)
            seperator.isHidden = true
            categoryLabelHeight.priority = .defaultLow
            categoryTitleLabel.numberOfLines = 0
            break
        case .LunarCalender:
            categoryLabelHeight.priority = .defaultHigh
            categoryTitleLabel.numberOfLines = 1
            break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

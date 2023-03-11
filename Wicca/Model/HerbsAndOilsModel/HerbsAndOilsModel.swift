//
//  HerbsAndOilsModel.swift
//  Wicca
//
//  Created by Jay Jariwala on 02/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation

struct HerbsAndOilsModel {
    
    var herbOilId: Int = 0
    var herbOilName: String = ""
    var ingredients: String = ""
    
    init(herbOilId: Int = 0, herbOilName: String, ingredients: String) {
        self.herbOilId = herbOilId
        self.herbOilName = herbOilName
        self.ingredients = ingredients
    }
    
}


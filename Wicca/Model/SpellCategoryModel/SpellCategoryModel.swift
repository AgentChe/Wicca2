//
//  SpellCategoryModel.swift
//  Wicca
//
//  Created by Jay Jariwala on 28/01/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation

struct SpellCategoryModel {
    
    var categoryId: Int = 0
    var categoryName: String = ""
    
    init(categoryId: Int, categoryName: String) {
        self.categoryId = categoryId
        self.categoryName = categoryName
    }
    
}

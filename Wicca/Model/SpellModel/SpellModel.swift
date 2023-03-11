//
//  SpellModel.swift
//  Wicca
//
//  Created by Jay Jariwala on 01/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation

struct SpellModel {
    
    var categoryId: Int = 0
    var spellId: Int = 0
    var spellName: String = ""
    var spellContent: String = ""
    
    init(categoryId: Int, spellId: Int = 0, spellName: String, spellContent: String) {
        self.categoryId = categoryId
        self.spellId = spellId
        self.spellName = spellName
        self.spellContent = spellContent
    }
    
}

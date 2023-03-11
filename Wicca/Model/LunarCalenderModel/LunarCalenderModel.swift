//
//  LunarCalenderModel.swift
//  Wicca
//
//  Created by Jay Jariwala on 03/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation

struct LunarCalenderModel {
    
    var lunarId: Int = 0
    var lunarName: String = ""
    var lunarDate: String = ""
    var signDesc: String = ""
    
    init(lunarId: Int = 0, lunarName: String, lunarDate: String, signDesc: String) {
        self.lunarId = lunarId
        self.lunarName = lunarName
        self.lunarDate = lunarDate
        self.signDesc = signDesc
    }
    
}

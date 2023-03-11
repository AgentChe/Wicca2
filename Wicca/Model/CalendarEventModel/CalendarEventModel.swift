//
//  CalendarEventModel.swift
//  Wicca
//
//  Created by Jay Jariwala on 15/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation

struct CalendarEventModel {
    
    var monthIndx: Int = 0
    var monthName: String = ""
    var event: String = ""
    
    init(monthIndx: Int = 0, monthName: String, event: String) {
        self.monthIndx = monthIndx
        self.monthName = monthName
        self.event = event
    }
    
}

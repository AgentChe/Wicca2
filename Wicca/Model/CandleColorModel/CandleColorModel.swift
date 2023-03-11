//
//  CandleColorModel.swift
//  Wicca
//
//  Created by Jay Jariwala on 15/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation

struct CandleColorModel {
    
    var diseaseId: Int = 0
    var diseaseName: String = ""
    var candleColor: String = ""
    
    init(diseaseId: Int, diseaseName: String, candleColor: String) {
        self.diseaseId = diseaseId
        self.diseaseName = diseaseName
        self.candleColor = candleColor
    }
    
}

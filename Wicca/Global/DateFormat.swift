//
//  DateFormat.swift
//  Wicca
//
//  Created by Jay Jariwala on 12/04/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation

/// Helps to get dateformatter as per format
/// basically, handles all dateformat related work
enum DateFormat : String {
    case dd_MM_yyyy = "dd-MM-yyyy"
    case dd_MMM_yyyy = "dd MMM yyyy"
    case yyyy_dd_MM = "yyyy-dd-MM" // 1990-24-07
    case yyyy_MM_dd = "yyyy-MM-dd" // 2019-07-23
    case yyyy_MM_dd_HH_MM_SS = "yyyy-MM-dd HH:mm:ss"//    2019-12-31 17:24:09
    case ddth_MMM_yyyy = "dd'th' MMM yyyy" // 31st Dec 2019
    case ddth_MMM = "dd'th' MMM" // 31st Dec
    
    var formatter : DateFormatter {
        let df = DateFormatter()
        df.dateFormat = self.rawValue
        return df
    }
}

func UTCToLocal(date:String, dateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

    let dt = dateFormatter.date(from: date)
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = dateFormat

    return dateFormatter.string(from: dt ?? Date())
}
extension Date {
    func addDays(_ numDays: Int) -> Date {
        var components = DateComponents()
        components.day = numDays
        return Calendar.current.date(byAdding: components, to: self)!
    }
}

//
//  Fonts+Ext.swift
//  MyBestLife
//
//  Created by Jay Jariwala on 06/10/20.
//  Copyright © 2020 Jay Jariwala. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    enum FontsType : String {
        case PlayfairDisplay_Regular = "PlayfairDisplay-Regular"
        case PlayfairDisplay_Italic_VariableFont_wght = "PlayfairDisplay-Italic-VariableFont_wght"
        case PlayfairDisplay_VariableFont_wght = "PlayfairDisplay-VariableFont_wght"
        case PlayfairDisplay_Black = "PlayfairDisplay-Black"
        case PlayfairDisplay_BlackItalic = "PlayfairDisplay-BlackItalic"
        case PlayfairDisplay_Bold = "PlayfairDisplay-Bold"
        case PlayfairDisplay_BoldItalic = "PlayfairDisplay-BoldItalic"
        case PlayfairDisplay_ExtraBold = "PlayfairDisplay-ExtraBold"
        case PlayfairDisplay_ExtraBoldItalic = "PlayfairDisplay-ExtraBoldItalic"
        case PlayfairDisplay_Italic = "PlayfairDisplay-Italic"
        case PlayfairDisplay_Medium = "PlayfairDisplay-Medium"
        case PlayfairDisplay_MediumItalic = "PlayfairDisplay-MediumItalic"
        case PlayfairDisplay_SemiBold = "PlayfairDisplay-SemiBold"
        case PlayfairDisplay_SemiBoldItalic = "PlayfairDisplay-SemiBoldItalic"
    }
    
    convenience init?(type : FontsType, size : CGFloat) {
        self.init(name: type.rawValue, size: size)
    }
    
    /// Not using this much, but still better to keep until they are allocated to old codes
    class func regularFont(withInitialSize size : CGFloat) -> UIFont {
        return UIFont.init(name: "Poppins-Regular", size: size)!
    }
    
    class func boldFont(withInitialSize size : CGFloat) -> UIFont {
        return UIFont.init(name: "Poppins-Bold", size: size)!
    }
}

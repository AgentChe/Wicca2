//
//  Color+Ext.swift
//  MyBestLife
//
//  Created by Jay Jariwala on 07/10/20.
//  Copyright © 2020 Jay Jariwala. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var project_Valencia: UIColor {
        // #DC4E3F
        return #colorLiteral(red: 0.862745098, green: 0.3058823529, blue: 0.2470588235, alpha: 1)
    }
    
    class var project_Sunflower: UIColor {
        // #E9CB20
        return #colorLiteral(red: 0.9137254902, green: 0.7960784314, blue: 0.1254901961, alpha: 1)
    }
    
    class var project_ChateauGreen: UIColor {
        // #3EB060
        return #colorLiteral(red: 0.2431372549, green: 0.6901960784, blue: 0.3764705882, alpha: 1)
    }
    
    class var project_HavelockBlue: UIColor {
        // #5593DB
        return #colorLiteral(red: 0.3333333333, green: 0.5764705882, blue: 0.8588235294, alpha: 1)
    }
    
    class var project_VividViolet: UIColor {
        // #8E37AC
        return #colorLiteral(red: 0.5568627451, green: 0.2156862745, blue: 0.6745098039, alpha: 1)
    }
    
    class var project_OceanGreen: UIColor {
        // #39A186
        return #colorLiteral(red: 0.2235294118, green: 0.631372549, blue: 0.5254901961, alpha: 1)
    }
    
}

extension UIColor {
    public class func hex(hex: String, alpha: CGFloat = 1.0) -> UIColor? {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return nil
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                         green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                         blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                         alpha: alpha)
    }
    
    public convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return nil
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

extension UIColor {
    convenience init?(hexString hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        guard cString.count == 6 else {
            return nil
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

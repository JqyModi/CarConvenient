//
//  UIColor+Extension.swift
//  YiBiFen
//
//  Created by Hanson on 16/10/13.
//  Copyright © 2016年 Hanson. All rights reserved.
//

import UIKit

extension UIColor {
    //用数值初始化颜色，便于生成设计图上标明的十六进制颜色
    convenience init(hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(rgba: String) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = rgba.characters.index(rgba.startIndex, offsetBy: 1)
            let hex     = rgba.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    debugPrint("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                }
            } else {
                debugPrint("Scan hex error")
            }
        } else {
            debugPrint("Invalid RGB string, missing '#' as prefix", terminator: "")
        }
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    static var md_windowBackgroundColor: UIColor {
        return UIColor(rgba: "#22282FFF")
    }
    
    static var md_viewBackgroundColor: UIColor {
        return UIColor.init(white: 0.93, alpha: 1.0)
    }
    
    static var md_loadingColor: UIColor {
        return UIColor(rgba: "#4D5B69FF")
    }
    
    static var md_tabBarColor: UIColor {
        return UIColor(rgba: "#4D5B69FF")
    }
    
    static var md_tabBarTintColor: UIColor {
        return UIColor(rgba: "#17D1FFFF")
    }
    
    static var md_navigationBarColor: UIColor {
        return UIColor(rgba: "#404B57FF")
    }
    
    static var md_navigationBarTitleColor: UIColor {
        return UIColor(rgba: "#F5F5F5FF")
    }
    
    static var md_gradientStartColor: UIColor {
        return UIColor(rgba: "#2C343C00")
    }
    
    static var md_gradientEndColor: UIColor {
        return UIColor(rgba: "#2C343CE5")
    }
    
    static var md_cellBackgroundColor: UIColor {
        return UIColor(rgba: "#22282fFF")
    }
    
    static var md_cellBackgroundHighlightedColor: UIColor {
        return UIColor(rgba: "#2C343FFF")
    }
    
    static var md_cellTextColor: UIColor {
        return UIColor(rgba: "#F5F5F5FF")
    }
    
    static var md_cellTextHighlightedColor: UIColor {
        return UIColor(rgba: "#17D1FFFF")
    }
    
}

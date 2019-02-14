//
//  ColorConfiguation.swift
//  InternetOfProfit
//
//  Created by 毛诚 on 2018/8/30.
//  Copyright © 2018年 WBG. All rights reserved.
//

import Foundation
import UIKit


/*
struct Color {
    
    
    /// app主题颜色，导航栏背景色,主要文字
    static let appThemeColor_statusBar: UIColor = Hex("#2894fd").UIColor
    
    /// 主要按钮，左右渐变
    static let themeButtonColor = Hex("#2894fd").UIColor
    
    /// (文字，按钮)价格
    static let price_text_button_Color = Hex("#ff4e2b").UIColor
    
    /// 辅助按钮 ->左右渐变
    static let warningbuttonColor = Hex("#ffa200").UIColor
    
    /// 菜单栏文字/主要文字色调
    static let themeTextColor = Hex("#666666").UIColor
    
    /// app背景色
    static let appBackgroundColor = Hex("#f6f6f6").UIColor
    
    /// 底部线条颜色 /输入框提示文字

    static let bottomLine_inputText_Color = Hex("#c5c5c5").UIColor
    
    //文本 - 主题文字颜色
    static let mainTextColor = Color.RGB(r: 78, g: 78, b: 78, a: 1.0).UIColor
//    #868686
    
    /// 次要文字颜色
    static let subMainTextColor = Hex("#868686").UIColor
    
    /// 登录背景颜色
    static let loginBgColor = Hex("#3E9BF5").UIColor
    ///cell的背景颜色
    static let cellBackgroundColor = RGB(r: 240, g: 240, b: 240, a: 1.0).UIColor
    
    
    static func RGB(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> (UIColor: UIColor,CGColor: CGColor){
        
        let color = UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
        return (color,color.cgColor)
        
    }
    
    static func Hex(_ hexString: String) -> (UIColor: UIColor,CGColor: CGColor){
        var cstring = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if(cstring.hasPrefix("#")){
            cstring = String(cstring[cstring.index(after: cstring.startIndex)..<cstring.endIndex])
        }
        if (cstring.count != 6) {
            return (UIColor.clear,UIColor.clear.cgColor)
        }
        let rString = cstring[..<cstring.index(cstring.startIndex, offsetBy: 2)]
        let gString = cstring[cstring.index(cstring.startIndex, offsetBy: 2)..<cstring.index(cstring.startIndex, offsetBy: 4)]
        let bString = cstring[cstring.index(cstring.endIndex, offsetBy: -2)..<cstring.endIndex]
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: String(rString)).scanHexInt32(&r)
        Scanner(string: String(gString)).scanHexInt32(&g)
        Scanner(string: String(bString)).scanHexInt32(&b)
        
        let color = UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
        return (color,color.cgColor)
        
    }
}
*/

struct Fount {
    
    /// 全局字体
//    static let MC_FontName = "PingFangSC-Regular"
    
    /// bigFontT1 = 38
    static let bigFontT1 = UIFont(name: "PingFangSC-Regular", size: 38)
    /// 导航标题 /大按钮 /价格
//    static let bigFontT1 = 38
    /// 列表产品标题/输入框 bigFontT2- 32
    static let bigFontT2 = UIFont(name: "PingFangSC-Regular", size: 32)
    /// 提示性文字
    /// bigFontT3 - 28
    static let bigFontT3 = UIFont(name: "PingFangSC-Regular", size: 28)
    /// 菜单栏文字/副标题/带四方图标菜单文字 24
    static let bigFontT4 = UIFont(name: "PingFangSC-Regular", size: 24)
    /// 带小图标菜单文字 22
    static let bigFontT5 = UIFont(name: "PingFangSC-Regular", size: 22)
    
    /// bigFontT6 -> 18
    static let bigFontT6 = UIFont(name: "PingFangSC-Regular", size: 18)

    
    /// bigFontT7 - 16
    static let bigFontT7 = UIFont(name: "PingFangSC-Regular", size: 16)
    
    ///bigFontT8 - 14
    static let bigFontT8 = UIFont(name: "PingFangSC-Regular", size: 14)
    
    
    /// navBar (标题) - 19
    static let bigFontT9 = UIFont(name: "PingFangSC-Regular", size: 19)
    /// 标准字体大小(正文) - 15
    static let bigFontT10 = UIFont(name: "PingFangSC-Regular", size: 15)
    
    /// 小字体 - 12
    static let smallFont1 = UIFont(name: "PingFangSC-Regular", size: 12)
    
    /// 小字体 - 10
    static let smallFont2 = UIFont(name: "PingFangSC-Regular", size: 10)
    
    ///粗体
    static let blodFontT12 = UIFont(name: "PingFang-SC-Medium", size: 12)
    static let blodFontT13 = UIFont(name: "PingFang-SC-Medium", size: 13)
    static let blodFontT19 = UIFont(name: "PingFang-SC-Medium", size: 19)
    static let blodFontT0 = UIFont(name: "PingFang-SC-Medium", size: 15)
    static let blodFontT1 = UIFont(name: "PingFang-SC-Medium", size: 16)
    static let blodFontT2 = UIFont(name: "PingFang-SC-Medium", size: 30)
    static let blodFontT3 = UIFont(name: "PingFang-SC-Medium", size: 32)
    static let blodFontT4 = UIFont(name: "PingFang-SC-Medium", size: 28)
    static let blodFontT5 = UIFont(name: "PingFang-SC-Medium", size: 24)
    static let blodFontT6 = UIFont(name: "PingFang-SC-Medium", size: 20)
}




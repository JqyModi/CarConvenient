//
//  ColorConfiguration.swift
//  LampblackMonitor
//
//  Created by 姚鸿飞 on 2017/11/29.
//  Copyright © 2017年 encifang. All rights reserved.
//

import UIKit

/// 屏幕宽度
//let SCREEN_WIDTH = UIScreen.main.bounds.width
/// 屏幕高度
//let SCREEN_HEIGHT = UIScreen.main.bounds.height

struct Color {

    // MARK: - 房产APP配色
    
    /// App主题颜色：导航栏、主要按钮、按钮高亮
//    static let ThemeColor_Orange: UIColor = RGB(r: 248, g: 136, b: 52, a: 1).UIColor
    static let md_ThemeColor: UIColor = UIColor.init(rgba: "#1B82D2")
    /// 导航栏颜色
    static let md_NavBarBgColor = UIColor.init(rgba: "#ffffff")
    static let md_NavBarTintColor = UIColor.init(rgba: "#333333")
    
    /// 导航栏\菜单栏标题颜色
    static let md_333333: UIColor = UIColor.init(rgba: "#333333")
    static let md_1B82D2: UIColor = UIColor.init(rgba: "#1B82D2")
    
    /// 输入框提示文字
    static let md_bbbbbb: UIColor = UIColor.init(rgba: "#bbbbbb")
    
    /// 输入框底部提示文字
    static let md_e5e5e5: UIColor = UIColor.init(rgba: "#e5e5e5")
    
    
    
    // MARK: - 按钮相关
    /// 蓝色按钮高亮与正常
    /// 突出文字颜色/主要按钮颜色
    static let md_3788e8 = UIColor.init(rgba: "#3788e8")
    ///登录按钮
    static let md_3788E8 = UIColor.init(rgba: "#3788E8")
    static let md_2f71c2 = UIColor.init(rgba: "#2f71c2")
    /// 绿色按钮高亮与正常登录按钮
    static let md_33cc33 = UIColor.init(rgba: "#33cc33")
    static let md_29a629 = UIColor.init(rgba: "#29a629")
    
    /// 红色按钮高亮与正常价钱
    static let md_ff3232 = UIColor.init(rgba: "#ff3232")
    static let md_d92b2b = UIColor.init(rgba: "#d92b2b")
    
    /// 橙色按钮高亮与正常
    static let md_ff8a00 = UIColor.init(rgba: "#ff8a00")
    static let md_d97400 = UIColor.init(rgba: "#d97400")
    
    /// 白色按钮高亮与正常
    static let md_FFFFFF = UIColor.init(rgba: "#FFFFFF")
    static let md_F0F0F0 = UIColor.init(rgba: "#F0F0F0")
    
    
    /// 线的颜色
    static let md_DDDDDD: UIColor = UIColor.init(rgba: "#DDDDDD") 
    /// 分割线
    static let md_f0f0f0 : UIColor = UIColor.init(rgba: "#f0f0f0")
    
    
    
    /// 次要文字、输入框提示文字
    static let md_666666 = UIColor.init(rgba: "#666666")
    
    static func RGB(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> (UIColor: UIColor,CGColor: CGColor) {
        let color = UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
        return (color,color.cgColor)
    }

    /// 透明背景色
    static let md_AlphaBGColor = UIColor.init(white: 0, alpha: 0.5)
    /// tableview默認背景色
    static let md_ViewGrayBGColor = UIColor.init(white: 0.93, alpha: 1)

    
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
    
    
//    static func RGB(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> (UIColor: UIColor,CGColor: CGColor){
//
//        let color = UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
//        return (color,color.cgColor)
//
//    }
    
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

// MARK: - 字体配置
struct FontSize {
    
    /// 导航栏
    static let md_NavBarFontSize: CGFloat = 15
    
    /// 按钮
    static let md_BigBtnFontSize: CGFloat = 16
    
    /// 大标题
    static let md_TitleFontSize: CGFloat = 16
    
    /// 子标题
    static let md_SubTitleFontSize: CGFloat = 14
    
    /// 描述信息
    static let md_DescFontSize: CGFloat = 12
    
    /// 输入框
    static let md_InputFontSize: CGFloat = 14
    
    /// 菜单
    static let md_MenuFontSize: CGFloat = 12
    
    /// 提示文字
    static let md_showFontSize: CGFloat = 12
    
}

///MARK : 通知相关 
struct NotCenter{
    
    /// 用户信息修改
    
    static let Change_UserInfo:String    =    "Change_UserInfo"
    
}


///默认图片
struct ImageNormal{
    
    //MARK :图片占位图
//    static let IamgeNodata      = "image_noData"
    static let IamgeNodata      = "placeholder"
    
    //MARK :头像占位图
    static let HeadNodata      = "Image_headNormol"
}

struct Margin {
    
    /// CollectionView Item间距
    static let md_CVItemMargin: CGFloat = 5
    
    /// CollectionView Section间距
    static let md_CVSectionMargin: CGFloat = 10
    
    /// 圆角半径
    static let md_CornerRadius: CGFloat = 5
    static let md_SmallCornerRadius: CGFloat = 2
    
    /// 大间距
    static let md_BigMargin: CGFloat = 14
    
    /// 小间距
    static let md_SmallMargin: CGFloat = 8
    
    /// 内容块间距
    static let md_ItemMargin: CGFloat = 15
    
    /// 左右边距
    static let md_LeftAndRight: CGFloat = 22.5
    
}

struct AppCommon {
    
    /// CollectionView Item间距
    static let md_NavBarHeight: CGFloat = 44
    
    static let md_StatusBarHeight: CGFloat = 20
    
    /// 文件存放路径
    static let md_PlistPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    typealias BtnClickedCompleteHandler = ((_ sender: UIButton)->Void)?
    
    static let JsonRequestHeader: [String: String]? = ["Content-Type": "application/json"]
    
    static let FromRequestHeader: [String: String]? = ["Content-Type": "application/x-www-form-urlencoded"]
    
    static let UserRoleType = "UserRoleType"
    
    static let DateFormat = "yyyy-MM-dd HH:mm:ss"
    
    static let ErrorCodePlistName = "ErrorCodeStrs"
    
}















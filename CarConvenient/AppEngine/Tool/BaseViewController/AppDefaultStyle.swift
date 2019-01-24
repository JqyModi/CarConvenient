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
    
    /// 透明背景色
    static let md_AlphaBGColor = UIColor.init(white: 0, alpha: 0.5)
    
    /// tableview默認背景色
    static let md_ViewGrayBGColor = UIColor.init(white: 0.93, alpha: 1)
    
    /// 导航栏\菜单栏标题颜色
    static let md_TitleColor: UIColor = UIColor.init(rgba: "#333333")
    
    /// 次要文字、输入框提示文字
    static let md_SubTitleColor: UIColor = UIColor.init(rgba: "#666666")
    
    /// 输入框提示文字
    static let md_InputDescColor: UIColor = UIColor.init(rgba: "#bbbbbb")
    
    /// 输入框底部提示文字
    static let md_InputBottomColor: UIColor = UIColor.init(rgba: "#e5e5e5")
    
    /// 分割线
    static let md_SplitLineColor: UIColor = UIColor.init(rgba: "#f0f0f0")
    
    /// 突出文字颜色/主要按钮颜色
    static let md_HighLightTextColor: UIColor = UIColor.init(rgba: "#3788e8")
    
    /// 登录按钮
    static let md_LoginBtnGreenColor: UIColor = UIColor.init(rgba: "#33cc33")
    static let md_LoginBtnOrangeColor: UIColor = UIColor.init(rgba: "#ff8a00")
    
    /// 价钱
    static let md_PriceTextColor: UIColor = UIColor.init(rgba: "#ff3232")
    
    
    // MARK: - 按钮相关
    
    
    /// 蓝色按钮高亮与正常
    static let md_BtnBlueHighLightColor = UIColor.init(rgba: "#3788e8")
    static let md_BtnBlueNormalColor = UIColor.init(rgba: "#3788E8")
    
    /// 绿色按钮高亮与正常
    static let md_BtnGreenHighLightColor = UIColor.init(rgba: "#33cc33")
    static let md_BtnGreenNormalColor = UIColor.init(rgba: "#29a629")
    
    /// 红色按钮高亮与正常
    static let md_BtnRedHighLightColor = UIColor.init(rgba: "#ff3232")
    static let md_BtnRedNormalColor = UIColor.init(rgba: "#d92b2b")
    
    /// 橙色按钮高亮与正常
    static let md_BtnOrangeHighLightColor = UIColor.init(rgba: "#ff8a00")
    static let md_BtnOrangeNormalColor = UIColor.init(rgba: "#d97400")
    
    /// 白色按钮高亮与正常
    static let md_BtnWhiteHighLightColor = UIColor.init(rgba: "#FFFFFF")
    static let md_BtnWhiteNormalColor = UIColor.init(rgba: "#F0F0F0")
    
    static let md_BtnWhiteTitleHighLightColor = UIColor.init(rgba: "#3788e8")
    static let md_BtnWhiteTitleNormalColor = UIColor.init(rgba: "#2f71c2")
    
    static let md_BtnDisableBGColor = UIColor.init(rgba: "#e5e5e5")
    static let md_BtnDisableTitleColor = UIColor.init(rgba: "#666666")
    
    static func RGB(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> (UIColor: UIColor,CGColor: CGColor) {
        let color = UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
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















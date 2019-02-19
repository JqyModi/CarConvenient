//
//  Macro.swift
//  LampblackMonitor
//
//  Created by 姚鸿飞 on 2017/12/4.
//  Copyright © 2017年 encifang. All rights reserved.
//

import UIKit

// MARK: 核心模块宏

/// 引擎
weak var AppEngine: HFAppEngine?                        = HFAppEngine.shared

// MARK: - --------数据中心宏定义开始-------

/// 主数据中心
weak var MainCent: HFMainDataCent?                  = AppEngine?.mainDataCent

///登录页数据中心
//weak var LoginCent:LoginDataCent?                   = AppEngine?.loginDataCent

/// 设置
//weak var SettingCent: SettingDataCent?                  = AppEngine?.settingDataCent

/// 公共数据
weak var CommonCent: CommonDataCent?                = AppEngine?.commonDataCent

/// 主页数据
//weak var HomeCent: HomeDataCent?                = AppEngine?.homeDataCent

/// 消息数据
//weak var MessageCent: MessageDataCent?                = AppEngine?.messageDataCent

/// 购物车数据
//weak var ShoppingCartCent: QBShoppingCartDataCent?                = AppEngine?.shoppingCartDataCent

// MARK: - --------数据中心宏定义结束-------



/// 根控制器
weak var RootController: UIViewController?              = UIApplication.shared.keyWindow?.rootViewController

/// 定位完成通知
let HFLocationDidUpdateNotification: Notification             = Notification(name: Notification.Name(rawValue: "HFLocationDidUpdateNotification"))


// MARK: 其他

/// 百度地图AppKey
let BaiduMapAppKey: String                              = "ll428MWiAAkwh7y269rP4knX1wrtvUQj"

/// 使用说明URL
let AboutURL: String                                    = "http://www.baidu.com"

/// 公钥KEY
let PublicKeyKEY: String                                = "pk"

/// 令牌KEY
let TokenKEY: String                                    = "tk"

/// 令牌KEY
let RefreshTokenKEY: String                                    = "rtk"

/// 接口基地址KEY
let BaseURLKEY: String                                  = "buk"

/// 用户名KEY
let UserNameKEY: String                                 = "unk"

/// 用户手机KEY
let UserPhoneKEY: String                                = "phok"

/// 用户id
let UserIDKEY: String                                   = "userid"

/// 密码KEY
let PasswordKEY: String                                 = "pdk"

/// 是否设置支付密码
let IsPayPass: String                                   = "payPass"

/// 当前版本号
let CurrentVersion: String                                   = "CurrentVersion"

/// 集货倒计时通知
let CollectCountDownTimeName                            = "CollectCountDownTimeName"



/// 屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.width
/// 屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let IPHONEX: Bool = UIScreen.main.bounds.height == 812 ? true : false
let is_iPhonex: Bool = UIScreen.main.bounds.height == 812 ? true : false

let IPHONESE: Bool = UIScreen.main.bounds.width == 320 ? true : false

let SaveAreaHeight: CGFloat = StatusBarHeight > 20 ? 34 : 0

let NavBarHeight: CGFloat = StatusBarHeight > 20 ? 88 : 64

let TabBarHeight: CGFloat = StatusBarHeight > 20 ? 49+SaveAreaHeight : 49

/// 状态栏高度
let StatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height


/// 配置TabBar
let TabBarDataSource: [[String: String]] = {
    let dic1 = ["title": "车品", "imageNameS": "btn_product_s", "imageNameN": "btn_product_n", "viewController": "CCCarCategoryViewController"]
    let dic2 = ["title": "服务", "imageNameS": "btn_serve_s", "imageNameN": "btn_serve_n", "viewController": "CCServiceViewController"]
    let dic3 = ["title": "洗车", "imageNameS": "btn_carwash_s", "imageNameN": "btn_carwash_n", "viewController": "CCWashCarViewController"]
    let dic4 = ["title": "车圈", "imageNameS": "btn_rim_s", "imageNameN": "btn_rim_n", "viewController": "CCGroupViewController"]
    let dic5 = ["title": "福利", "imageNameS": "btn_welfare_s", "imageNameN": "btn_welfare_n", "viewController": "CCWelfareViewController"]
    return [dic1, dic2, dic3, dic4, dic5]
}()

protocol ViewClickedDelegate {
    var clickBlock: ((_ sender: Any?) -> ())? {get set}
}

//
//  AppConfiguration.swift
//  Ecosphere
//
//  Created by 姚鸿飞 on 2017/6/3.
//  Copyright © 2017年 encifang. All rights reserved.
//

import UIKit
import SwiftyJSON

let dataFilePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("DataCent.dc")

let savePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String


class HFAppConfiguration: NSObject {
    
    // 是否允许跳过登录限制
    static let isAllowSkipLogin = false
    
    // 请求超时时间设置
    static let requestOutTime = 20
    
//    // 服务器的响应中 消息 字段Key
//    static let respond_MsgKey = "msg"
//
//    // 服务器的响应中 状态 字段Key
//    static let respond_StatusKey = "status"
//
//    // 服务器的响应中 数据 字段Key
//    static let respond_DataKey = "data"
//
//    // 登录接口请求参数 账号 字段Key
//    static let login_ApiAccountKey = "phone"
//
//    // 登录接口请求参数 密码 字段Key
//    static let login_ApiPasswordKey = "password"
    
    /// 设置需要展示的控制器
    /// - 此方法默认会添加一个UITabBarController
    /// - Returns: 将控制器放在数组中返回
    class func setupViewController() -> [UIViewController] {
        
        /*--------------------在下面创建控制器--------------------*/
        var vcsArr = [UIViewController]()
        
        if (TabBarDataSource.count) > 0 {
            for item in TabBarDataSource {
                if let vcs = item["viewController"], let moduleName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
//                    let moduleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
//                    let personClass: AnyClass? = NSClassFromString(moduleName + "." + "Person")
                    if let cls = NSClassFromString(moduleName + ".\(vcs)") {
                        if let vcType = cls as? UIViewController.Type {
                            
                            let title = item["title"] ?? ""
                            let imageNameS = item["imageNameS"] ?? ""
                            let imageNameN = item["imageNameN"] ?? ""
                            
                            let vc = vcType.init()
                            vc.navigationItem.title = title
                            let VCN3 = MDNavigationController(vc: vc)
                            VCN3.tabBarItem.title = title
                            VCN3.tabBarItem.image = UIImage(named:imageNameN)?.withRenderingMode(.alwaysOriginal)
                            VCN3.tabBarItem.selectedImage = UIImage(named:imageNameS)?.withRenderingMode(.alwaysOriginal)
                            VCN3.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Color.md_ThemeColor] , for: UIControlState.selected)
                            VCN3.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.init(rgba: "#888888")] , for: UIControlState.normal)
                            vcsArr.append(VCN3)
                        }
                    }
                    
                }
            }
        }
        
        /*--------------------创建好控制器添加到数组中即可--------------------*/
        
        return vcsArr
    }
    
    /// 设置自定义主控制器
    /// - 此方法在需要使用自定义UITabBarController的时候调用
    /// - Returns: 将控制器放在数组中返回
    class func setupMainController() -> UITabBarController? {
        
        
        
        return nil
    }
    
    
    /// 设置登录成功后的操作
    ///
    /// - Parameters:
    ///   - result: 返回的结果
    ///   - NextExecute: 下一步操作
    class func setupLoginSucceedHandle(result:JSON, NextExecute: (_ isSuccess: Bool,_ msg: String) -> Void) {
        
        
        
        /// 当您完成您的操作时，请调用此闭包并告诉引擎您处理的结果是否允许登录，isSuccess为false时将登录失败，并且弹窗提示您传递的msg
        NextExecute(true,"msg")
        
    }
    
    
}

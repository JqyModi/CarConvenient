//
//  AppDelegate.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/21.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit
import IQKeyboardManager
import Kingfisher
import KingfisherWebP

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        
        //注册第三方
        HFThirdPartyManager.shared.registerThirdParty()
        
        //        let configuration = HFEngineConfiguration()
        //        configuration.isNeedWelcomeView = true
        //        configuration.isEnabledDemonstration = false
        //        configuration.autoLoginByLocalTokenKey = TokenKEY
        //        HFAppEngine.run(configuration: configuration)
        HFAppEngine.run()
        
        // Facebook
//        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//
//        // Initialize sign-in
//        GIDSignIn.sharedInstance().clientID = HFThirdPartyManager.GoogleClientID
        
        // 极光推送
        self.pushAction(launchOptions: launchOptions)
        // KF支持webP图片
        KingfisherManager.shared.defaultOptions = [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)]
        
        // 支持不同尺寸设备自动xib按比例约束
//        NSLayoutConstraint().adaptive = true
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        debugPrint("前台进入后台 --------------------------> ")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        debugPrint("后台回前台 --------------------------> ")
        if let cvc = HFAppEngine.shared.currentViewController() {
            //            cvc.viewWillAppear(true)
            cvc.viewDidAppear(true)
        }
        // 清除角标
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}
extension AppDelegate {
    
    // MARK: - 兼容iOS8.0之前版本
    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return HFThirdPartyManager.shared.application(application, open: url as URL, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    // MARK: - 处理第三方回调
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return HFThirdPartyManager.shared.application(application,handleOpen:url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return HFThirdPartyManager.shared.application(_:application, open:url, sourceApplication:sourceApplication, annotation:annotation)
    }
    //解决iOS9后微博分享回调找不到系统方法
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        return HFThirdPartyManager.shared.application(_:application, open:url, sourceApplication:sourceApplication, annotation:annotation)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return HFThirdPartyManager.shared.application(app:app, openURL:url, options:options)
    }
}
extension AppDelegate: JPUSHRegisterDelegate {
    private func pushAction(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        
        //极光推送
        let entity = JPUSHRegisterEntity()
        entity.types = 1 << 0 | 1 << 1 | 1 << 2
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        // 配置APPKey
        JPUSHService.setup(withOption: launchOptions, appKey: HFThirdPartyManager.JPushAppKey, channel: "App Store", apsForProduction: false)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("did Fail To Register For Remote Notifications With Error: \(error)")
    }
    
    //    func applicationDidBecomeActive(_ application: UIApplication) {
    //        if let launchOptions = UserDefaults.standard.value(forKey: "launchOptions") as? [UIApplicationLaunchOptionsKey: Any] {
    //            if let remoteNotify = launchOptions[UIApplicationLaunchOptionsKey.remoteNotification] as? [String: Any] {
    //                if let aps = remoteNotify["aps"] as? [String: Any] {
    //                    if let badge = aps["badge"] as? Int {
    //                        UserDefaults.standard.set(badge, forKey: "badge")
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    //MARK:JPUSHRegisterDelegate
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {//收到通知
        let userInfo = notification.request.content.userInfo
        debugPrint("userInfo --------------------------> \(userInfo)")
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler(Int(JPAuthorizationOptions.alert.rawValue))
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {//点击通知
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        
        if UIApplication.shared.applicationState == .active {
            self.handlePushAction(userInfo: userInfo)
        }else{
            DispatchQueue.main.asyncAfter(deadline:1.5, execute: {
                self.handlePushAction(userInfo: userInfo)
            })
        }
        
        completionHandler()
    }
    
    private func handlePushAction(userInfo: [AnyHashable : Any]) {
        debugPrint("userInfo --------------------------> \(userInfo)")
        
        // 获取当前的角标数量
        //        if let aps = userInfo["aps"] as? [String: Any], let badge = aps["badge"] as? Int {
        //            UIApplication.shared.applicationIconBadgeNumber = badge
        //        }
        
        
    }
}
// 监听后台回到前台
extension AppDelegate {
    
}

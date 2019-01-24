//
//  HFThirdPartyManager.swift
//  SodMall
//
//  Created by 姚鸿飞 on 2018/3/17.
//  Copyright © 2018年 姚鸿飞. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher

enum HFThirdPartyLoginType {
    case Wechat
    case QQ
    case Google
    case Facebook
}

enum HFThirdPartyShareType {
    case Session
    case Timeline
    case QQ
    case SinaWeibo
}

enum HFThirdPartyPayType {
    case WechatPay
    case AliPay
}

@objc protocol HFThirdPartyManagerDelegate: NSObjectProtocol {

    @objc optional func WXPayDidComplete(_ isSucceed: Bool, _ msg: String, _ resp: BaseResp)

    @objc optional func WXLoginDidComplete(_ isSucceed: Bool, _ msg: String, _ data: WXUserInfoModel?)

    @objc optional func AliPayDidComplete(_ isSucceed: Bool, _ msg: String, _ data: [AnyHashable:Any]?)
    @objc optional func QQLoginDidComlete(_ isSucced: Bool, _ msg: String, _ data: QQUserInfoModel?)
    
}

class HFThirdPartyManager: NSObject, WXApiDelegate, TencentSessionDelegate {


    // MARK: - 第三方配置
    static let SinaWeiboAppKey: String = "4285643628"
    static let SinaWeiboScheme: String = "wb4285643628"

    static let WXAppkey: String = "wx4fc9ff6e5c76f8bc"
    static let WXSecret: String = "1be78d3237f24ce3612733bcabae0a5c"
    
    static let QQAppID: String = "1106949895"
    static let QQAppKey: String = "WRTIh0l1AFGXb2uI"
    
    static let AlipayScheme: String = "LiTong"
    
//    static let GoogleClientID = "com.googleusercontent.apps.491659727556-vtk3kbfmvck4fggm806mafct16gnbi4j"
    static let GoogleClientID = "491659727556-vtk3kbfmvck4fggm806mafct16gnbi4j.apps.googleusercontent.com"
    
    static let JPushAppKey = "338b37a013e2c4f8c3f15672"


    var delegate: HFThirdPartyManagerDelegate?


    static let shared: HFThirdPartyManager = HFThirdPartyManager()
    var tencentOAuth: TencentOAuth?

    func registerThirdParty() {
        WXApi.registerApp(HFThirdPartyManager.WXAppkey)
        self.tencentOAuth = TencentOAuth(appId: HFThirdPartyManager.QQAppID, andDelegate: self)
    }

    func loginByThirdParty(type: HFThirdPartyLoginType, controller: UIViewController? = nil) {

        switch type {

        case .Wechat:

            let req = SendAuthReq()
            req.scope = "snsapi_userinfo"
            req.state = "123"
            if WXApi.isWXAppInstalled() {
                WXApi.send(req)
            }else {
                WXApi.sendAuthReq(req, viewController: controller, delegate: self)
            }
        case .QQ:

            let permissions = [kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO]
            self.tencentOAuth?.authorize(permissions)

        case .Google:
//            self.googleLoginAction()
            break
        case .Facebook:
//            self.handleFaceBookNotify()
//            self.facebookLoginAction(viewController: controller)
            break
            
        }

    }

    func payByThirdParty(type: HFThirdPartyPayType,wxDict:[String:Any]?,AliStr: String?) {
        switch type {
        case .WechatPay:
            if wxDict == nil { return }
            //调起微信支付
            let req = PayReq()
            req.openID = wxDict!["appid"] as! String
            req.partnerId = wxDict!["mch_id"] as! String
            req.prepayId = wxDict!["prepay_id"] as! String
            req.nonceStr = wxDict!["nonce_str"] as! String
            req.package = "Sign=WXPay"
            req.sign = wxDict!["sign"] as! String
            req.timeStamp = UInt32.init(exactly: NSNumber.init(value: wxDict!["time"] as! Int))!
            WXApi.send(req)

        case .AliPay:

            if AliStr == nil { return }

            AlipaySDK.defaultService().payOrder(AliStr, fromScheme: HFThirdPartyManager.AlipayScheme, callback: { (info) in
                debugPrint("pay info ----> \(info)")
            })

        }
    }

    // MARK: - Wechat

    /// 微信回调
    ///
    /// - Parameter resp: 数据包
    func onResp(_ resp: BaseResp!) {

        switch resp {

        case is SendAuthResp:

            self.disposeWechatLogin(resp)

        case is PayResp:

            self.disposeWechatPay(resp)

        case is SendMessageToWXResp:
            
            let title = resp.errCode == 0 ? "分享成功" : "分享失败"
            var message = ""
            switch(resp.errCode){
            case -1:
                message = "参数错误"
            case -2:
                message = "该群不在自己的群列表里面"
            case -3:
                message = "上传图片失败"
            case -4:
                message = "用户放弃当前操作"
            case -5:
                message = "客户端内部处理错误"
            default: //0
                message = "成功"
                break
            }
            
            //显示消息
            SVProgressHUD.showInfo(withStatus: title)
            
        default:
            break
        }

    }


    /// 处理微信登录
    ///
    /// - Parameter resp: -
    func disposeWechatLogin(_ resp: BaseResp!) {
        let authResp: SendAuthResp = resp as! SendAuthResp
        if authResp.errCode == 0 {
            let code = authResp.code
            let param =  ["appid": HFThirdPartyManager.WXAppkey,
                          "secret": HFThirdPartyManager.WXSecret,
                          "code": code!,
                          "grant_type": "authorization_code"]

            HFNetworkManager.request(url: API.WXAccessToken, needBaseURL:false, method: .post, parameters:param, description: "获取授权") { (error, resp) in

                // 连接失败时
                if error != nil {
                    SVProgressHUD.showInfo(withStatus: error!.localizedDescription)
                    return
                }


                // 请求成功时
                let accessToken = resp!["access_token"].string
                let refreshToken = resp!["refresh_token"].string
                let openID = resp!["openid"].string
                if accessToken != nil && openID != nil {
                    UserDefaults.standard.set(accessToken, forKey: "wx_access_token")
                    UserDefaults.standard.set(refreshToken, forKey: "wx_refresh_token")
                    UserDefaults.standard.set(openID, forKey: "wx_openid")
                    UserDefaults.standard.synchronize()
                }

                let param: [String:Any] = ["openid":openID!,"access_token":accessToken!]

                HFNetworkManager.request(url: API.WXUserinfo,needBaseURL: false, method: .post, parameters:param, description: "获取微信用户信息") { (error, resp) in

                    // 连接失败时
                    if error != nil {
                        SVProgressHUD.showInfo(withStatus: error!.localizedDescription)
                        return
                    }


                    // 请求成功时
                    let data = resp!.dictionaryObject
                    let UIM = Mapper<WXUserInfoModel>().map(JSONObject: data)

                    self.delegate?.WXLoginDidComplete?(true, "Wechat获取成功", UIM)

                    //                        print(resp!)
                }
            }

        }
    }

    /// 处理微信支付
    ///
    /// - Parameter resp: -
    func disposeWechatPay(_ resp: BaseResp!) {
        switch resp.errCode {
        case WXSuccess.rawValue:
            self.delegate?.WXPayDidComplete?(true, "支付成功", resp)
        case WXErrCodeCommon.rawValue:
            self.delegate?.WXPayDidComplete?(false, resp.errStr, resp)
        case WXErrCodeUserCancel.rawValue:
            self.delegate?.WXPayDidComplete?(false, "支付失败", resp)
        default:
            break
        }
    }


    // MARK: - Tencent QQ
    

    /// 已经登录
    func tencentDidLogin() {
        self.tencentOAuth?.getUserInfo()
    }

    /// 未登录
    ///
    /// - Parameter cancelled: -
    func tencentDidNotLogin(_ cancelled: Bool) {
        SVProgressHUD.showInfo(withStatus: "登录失败")
    }

    /// 连接失败
    func tencentDidNotNetWork() {
        SVProgressHUD.showInfo(withStatus: "无法连接网络")
    }

    func getUserInfoResponse(_ response: APIResponse!) {
        // 获取个人信息
        SVProgressHUD.show()
        if response.retCode == 0 {

            if let res = response.jsonResponse {

                let qqModel = QQUserInfoModel()

                if let uid = self.tencentOAuth!.getUserOpenID() {
                    // 获取uid
                    qqModel.openid = uid
                }

                if let name = res["nickname"] {
                    // 获取nickname
                    qqModel.nickname = name as! String
                }

                if let sex = res["gender"] {
                    // 获取性别
                    qqModel.sex = sex as! String
                }

                if let img = res["figureurl_qq_2"] {
                    // 获取头像
                    qqModel.headimgurl = img as! String
                }
                self.delegate?.QQLoginDidComlete!(true, "QQ授权成功", qqModel)

            }
        } else {
            // 获取授权信息异常
            self.delegate?.QQLoginDidComlete!(false, "授权失败", nil)
            SVProgressHUD.showInfo(withStatus: response.errorMsg)
        }
    }


    // MARK: - AppDelegate响应
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if url.scheme == HFThirdPartyManager.WXAppkey {
            return WXApi.handleOpen(url, delegate: HFThirdPartyManager.shared)
        }
        
        if url.host == "safepay" {
            
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
                self.alipayResult(resultDic: resultDic!)
            })
        }
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.scheme == HFThirdPartyManager.WXAppkey {
            return WXApi.handleOpen(url, delegate: HFThirdPartyManager.shared)
        }
        if url.host == "safepay" {
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
                self.alipayResult(resultDic: resultDic!)
            })
        }
//        if url.scheme == HFThirdPartyManager.SinaWeiboScheme {
//            // 新浪微博回调: 获取网页OAuth授权
//            debugPrint("获取网页OAuth授权")
//            return LDSinaShare.handle(url)
//        }
        
        // Facebook
//        FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
//        // Google
//        GIDSignIn.sharedInstance().handle(url as URL,
//                                          sourceApplication: sourceApplication,
//                                          annotation: annotation)
        
        return true
    }
    
    func application(app: UIApplication, openURL url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if url.scheme == HFThirdPartyManager.WXAppkey {
            return WXApi.handleOpen(url, delegate: HFThirdPartyManager.shared)
        }
        
        if (options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String) == "com.tencent.mqq" {
            QQApiInterface.handleOpen(url, delegate: QQCompleteHandler.shared)
            return  TencentOAuth.handleOpen(url)
        }
        
        if url.host == "safepay" {
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
                self.alipayResult(resultDic: resultDic!)
            })
        }
        
//        if (options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String) == "com.sina.weibo" {
//            // 新浪微博回调
//            return WeiboSDK.handleOpen(url, delegate: HFThirdPartyManager.shared)
//        }
        
        // facebook
//        FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
//        // Google
//        GIDSignIn.sharedInstance().handle(url as URL?,
//                                          sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
//                                          annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return true
    }

    func alipayResult(resultDic:[AnyHashable:Any]) {
        let result = (resultDic["resultStatus"] as! NSString).integerValue
        if result == 9000 {
            self.delegate?.AliPayDidComplete?(true, "支付成功", resultDic)
        }else {
            self.delegate?.AliPayDidComplete?(true, "支付失败", resultDic)
        }

    }
    
    // MARK: - 分享
    
    /// 分享
    ///
    /// - Parameters:
    ///   - str: 分享内容
    ///   - type: 分享类型
    func shareAction(shareModel: ShareModel?, type: HFThirdPartyShareType) {
        guard let model = shareModel else {
            return
        }
        SVProgressHUD.show()
        SVProgressHUD.dismiss(withDelay: 5)
        switch type {
        case .Session:  //微信
//            if WXApi.isWXAppInstalled() {
            self.shareWebToWeChat(model: model, type: .Session)
//            }else {
//                SVProgressHUD.showInfo(withStatus: "没有发现微信客户端")
//            }
            break
        case .Timeline: //朋友圈
//            if WXApi.isWXAppInstalled() {
            self.shareWebToWeChat(model: model, type: .Timeline)
//            }else {
//                SVProgressHUD.showInfo(withStatus: "没有发现微信客户端")
//            }
            break
        case .QQ:       //QQ
            //分享跳转URL
            self.shareWebToQQ(model: model)
            break
        case .SinaWeibo:       //微博
//            self.shareWebToSina(url: str)
            
            break
        default:
            break
        }
    }
    
    private func shareWebToQQ(model: ShareModel) {
        
        getShareImageData(model: model, finishBlock: {(data) in
            debugPrint("")
            let newsObj = QQApiNewsObject(url: URL(string: model.data_url!), title: (model.data_share?.data_share_title)!, description: (model.data_share?.data_share_content)!, previewImageData: data, targetContentType: QQApiURLTargetTypeNews)
            let req = SendMessageToQQReq(content: newsObj)
            //分享到QQ
            let sentResp = QQApiInterface.send(req)
            self.handleSendResult(sendResult: sentResp)
        })
        
    }
    
    //处理分享返回结果
    private func handleSendResult(sendResult:QQApiSendResultCode){
        var message = ""
        switch(sendResult){
        case EQQAPIAPPNOTREGISTED:
            message = "App未注册"
        case EQQAPIMESSAGECONTENTINVALID, EQQAPIMESSAGECONTENTNULL,
             EQQAPIMESSAGETYPEINVALID:
            message = "发送参数错误"
        case EQQAPIQQNOTINSTALLED:
            message = "QQ未安装"
        case EQQAPIQQNOTSUPPORTAPI:
            message = "API接口不支持"
        case EQQAPISENDFAILD:
            message = "发送失败"
        case EQQAPIQZONENOTSUPPORTTEXT:
            message = "空间分享不支持纯文本分享，请使用图文分享"
        case EQQAPIQZONENOTSUPPORTIMAGE:
            message = "空间分享不支持纯图片分享，请使用图文分享"
        default:
            message = "发送成功"
        }
        SVProgressHUD.showInfo(withStatus: message)
    }
    
    private func getShareImageData(model: ShareModel, finishBlock: ((_ data: Data) -> Void)?) {
        // 判断后台是否返回图片
        if let img = model.data_share?.data_share_img {
            KingfisherManager.shared.downloader.downloadImage(with: URL.init(string: img)!, retrieveImageTask: nil, options: nil, progressBlock: nil) {(image, error, url, data) in
                if finishBlock != nil && image != nil {
                    finishBlock!(UIImageJPEGRepresentation(image!, 0.5)!)
                }else {
                    if finishBlock != nil {
                        finishBlock!(UIImageJPEGRepresentation(#imageLiteral(resourceName: "logo_"), 0.5)!)
                    }
                }
            }
        }else {
            if finishBlock != nil {
                finishBlock!(UIImageJPEGRepresentation(#imageLiteral(resourceName: "logo_"), 0.5)!)
            }
        }
    }
    
    /// 分享到微信
    ///
    /// - Parameter url: 分享链接
    private func shareWebToWeChat(model: ShareModel, type: HFThirdPartyShareType) {
        
        getShareImageData(model: model, finishBlock: {(data) in
            debugPrint("")
            let wxMMsg = WXMediaMessage()
            wxMMsg.title = (model.data_share?.data_share_title)!
            wxMMsg.description = (model.data_share?.data_share_content)!
            wxMMsg.setThumbImage(UIImage.init(data: data))
            let webpageObj = WXWebpageObject()
            webpageObj.webpageUrl = model.data_url
            wxMMsg.mediaObject = webpageObj
            let msgReq = SendMessageToWXReq()
            msgReq.bText = false
            msgReq.message = wxMMsg
    
            switch type {
            case .Session:
                msgReq.scene = Int32(WXSceneSession.rawValue)
            case .Timeline:
                msgReq.scene = Int32(WXSceneTimeline.rawValue)
            default:
                break
            }
            //发起请求
            if WXApi.send(msgReq) {
                debugPrint("发送成功")
            }
        })
        
        
    }

}


import ObjectMapper

class WXUserInfoModel: NSObject, Mappable {

    var openid: String = ""
    var city: String = ""
    var privilege: [String] = []
    var nickname: String = ""
    var country: String = ""
    var headimgurl: String = ""
    var unionid: String = ""
    var language: String = ""
    var sex: Int = 0
    var province: String = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        self.openid <- map["openid"]
        self.city <- map["city"]
        self.privilege <- map["privilege"]
        self.nickname <- map["nickname"]
        self.country <- map["country"]
        self.headimgurl <- map["headimgurl"]
        self.unionid <- map["unionid"]
        self.language <- map["language"]
        self.sex <- map["sex"]
        self.province <- map["province"]

    }
}

class QQUserInfoModel: NSObject {

    var openid: String = ""
    var city: String = ""
    var privilege: [String] = []
    var nickname: String = ""
    var country: String = ""
    var headimgurl: String = ""
    var unionid: String = ""
    var language: String = ""
    var sex: String = ""
    var province: String = ""

    override init() {

    }
}

class ShareModel: NSObject, Mappable {
    var data_url: String?
    var data_user: ShareUser?
    var data_share: Share?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        data_url <- map["url"]
        data_user <- map["user"]
        data_share <- map["share"]
        
    }
}

class Share: NSObject, Mappable {
    
    var data_share_img: String?
    var data_share_title: String?
    var data_share_content: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        data_share_img <- map["share_img"]
        data_share_title <- map["share_title"]
        data_share_content <- map["share_content"]
        
    }
    
}

class ShareUser: NSObject, Mappable {
    
    var data_user_img: String?
    var data_nickname: String?
    var data_user_phone: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        data_user_img <- map["user_img"]
        data_nickname <- map["nickname"]
        data_user_phone <- map["user_phone"]
        
    }
}

// MARK: - QQ分享回调处理类
class QQCompleteHandler: NSObject, QQApiInterfaceDelegate {
    
    static let shared: QQCompleteHandler = QQCompleteHandler()
    
    func onReq(_ req: QQBaseReq!) {
//        SVProgressHUD.showInfo(withStatus: "onReq")
    }
    
    func onResp(_ resp: QQBaseResp!) {
        
        if resp is SendMessageToQQResp {
            //QQApi应答消息类型判断（手Q -> 第三方应用，手Q应答处理分享消息的结果）
            if uint(resp.type) == ESENDMESSAGETOQQRESPTYPE.rawValue {
                let title = resp.result == "0" ? "分享成功" : "分享失败"
                var message = ""
                switch(resp.result){
                case "-1":
                    message = "参数错误"
                case "-2":
                    message = "该群不在自己的群列表里面"
                case "-3":
                    message = "上传图片失败"
                case "-4":
                    message = "用户放弃当前操作"
                case "-5":
                    message = "客户端内部处理错误"
                default: //0
                    //message = "成功"
                    break
                }
                
                //显示消息
                SVProgressHUD.showInfo(withStatus: title)
            }
        }

    }
    
    func isOnlineResponse(_ response: [AnyHashable : Any]!) {
//        SVProgressHUD.showInfo(withStatus: "isOnlineResponse")
    }
}
/*
// MARK: - 处理Google登录回调
extension HFThirdPartyManager: GIDSignInDelegate, GIDSignInUIDelegate {
    
    private func googleLoginAction() {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    private func googleLogoutAction() {
        GIDSignIn.sharedInstance()?.signOut()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
            
            debugPrint("user --------------------------> \(user.getPropertiesAndValues())")
            if let d = self.delegate {
                d.GoogleLoginDidComlete!(true, "Google授权成功", user)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    // MARK: - GIDSignInUIDelegate
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
//        self.present(viewController, animated: true, completion: nil)
        HFAppEngine.shared.currentViewController()?.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
//        self.dismiss(animated: true, completion: nil)
        HFAppEngine.shared.currentViewController()?.dismiss(animated: true, completion: nil)
    }
}
// MARK: - 处理Facebook登录
extension HFThirdPartyManager {
    private func facebookLoginAction(viewController: UIViewController?) {
        // 设置Facebook的点击事件
        let login = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["public_profile", "email"], from: viewController) { (result, error) in
            if (error != nil) {
                debugPrint("Facebook授权报错： ------------> \(error)")
            }else if (result?.isCancelled)! {
                debugPrint("用户取消了Facebook授权")
            }else {
                let token = result?.token.tokenString
                // 手动设置用户资料更新通知：通过通知监听到用户资料
//                FBSDKAccessToken.setCurrent(result?.token)
//                FBSDKProfile.enableUpdates(onAccessTokenChange: true)
                
                // 进一步获取用户信息：userID、name、头像等
                if let profile = FBSDKProfile.current() {
                    let url = profile.imageURL(for: FBSDKProfilePictureMode.normal, size: CGSize(width: 200, height: 200))
                    let fbRsModel = FacebookRsModel(openId: profile.userID, name: profile.name, icon: url?.absoluteString)
                    
                    if let d = self.delegate {
                        d.FacebookLoginDidComlete!(true, "Facebook授权成功", fbRsModel)
                    }
                }
            }
        }
    }
    
    private func handleFaceBookNotify() {
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.FBSDKProfileDidChange,
            object: nil, queue: nil) { (Notification) in
                // 通过该通知监听Facebook资料改变
                if let profile = FBSDKProfile.current() {
                    // ...
                }
        }
        
    }
}
*/

/// Facebook登录回调模型
class FacebookRsModel: NSObject {
    var openId: String?
    var name: String?
    var icon: String?
    
    init(openId: String?, name: String?, icon: String?) {
        self.openId = openId
        self.name = name
        self.icon = icon
    }
}

//
//  CommonDataCent.swift
//  MingChuangWine
//
//  Created by Modi on 2018/5/22.
//  Copyright © 2018年 江启雨. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
import Alamofire

enum BannerType {
    case BannerTypeHome
    case BannerTypeUser
    case BannerTypeZX
}

class CommonDataCent: HFDataCent {
    
    // MARK: - 刷新token
    var data_Login: TokenModel?
    func requestRefreshToken(refreshToken: String, complete:@escaping ((_ isSucceed: Bool, _ data: TokenModel?, _ message: String) -> Void)) {
        let param: [String:Any] = ["refreshToken": refreshToken]
        
        HFNetworkManager.request(url: API.RefreshToken, method: .post, parameters:param, requestHeader: AppCommon.FromRequestHeader, description: "刷新token") { (error, resp) in
            
            // 连接失败时
            if error != nil {
                complete(false, nil, error!.localizedDescription)
                return
            }
            
            guard let status = resp?["status"].intValue else {return}
            guard let msg = resp?["msg"].string else {return}
            
            // 请求失败时
            if status != 200 {
                complete(false,nil, msg)
                return
            }
            
            guard let code = resp?["code"].string else {return}
            
            //            guard let dataArr = resp?["data"].arrayObject else {return}
            guard let dataDic = resp?["data"].dictionaryObject else {return}
            
            let model: TokenModel = Mapper<TokenModel>().map(JSONObject: dataDic)!
            self.data_Login = model
            self.localizationUserInfo(resp: resp)
            // 请求成功时
            complete(true,model,msg)
        }
    }
    
    // MARK: - 淘口令解密
    var data_TaoPasswordParse: MDTaoPasswordParseModel?
    func requestTaoPasswordParse(apikey: String = "BdRnBnGOsa", tkl: String, complete:@escaping ((_ isSucceed: Bool, _ data: MDTaoPasswordParseModel?, _ message: String) -> Void)) {
        let param: [String:Any] = ["apikey": apikey, "tkl": tkl]
        
        HFNetworkManager.request(url: API.TaoPasswordParse, needBaseURL: false, method: .post, parameters:param, requestHeader: AppCommon.FromRequestHeader, description: "淘口令解析") { (error, resp) in
            
            // 连接失败时
            if error != nil {
                complete(false, nil, error!.localizedDescription)
                return
            }
            
            guard let code = resp?["code"].intValue else {return}
            guard let msg = resp?["msg"].string else {return}

            // 请求失败时
            if code != 1 {
                complete(false,nil, msg)
                return
            }

            guard let dataDic = resp?.dictionaryObject else {return}
            
            let model: MDTaoPasswordParseModel = Mapper<MDTaoPasswordParseModel>().map(JSONObject: dataDic)!
            self.data_TaoPasswordParse = model
            // 请求成功时
            complete(true,model,msg)
        }
    }
    
    /// 本地化用户基本信息
    ///
    /// - Parameter resp: -
    private func localizationUserInfo(resp: JSON?) {
        // 保存用户信息
        if let m = resp?["data"].dictionaryObject {
            UserDefaults.standard.setValue(m["accessToken"], forKey: TokenKEY)
        }
        
        if let m = resp?["data"].dictionaryObject {
            UserDefaults.standard.setValue(m["id"], forKey: UserPhoneKEY)
        }
        
        if let m = resp?["data"].dictionaryObject, let role = m["refreshToken"] {
            UserDefaults.standard.setValue(role, forKey: RefreshTokenKEY)
        }
        
        UserDefaults.standard.synchronize()
    }
    
}




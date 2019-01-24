//
//  HFNetworkManager.swift
//  Ecosphere
//
//  Created by 姚鸿飞 on 2017/6/2.
//  Copyright © 2017年 encifang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class HFNetworkManager: NSObject {
    
    /// 请求池
    private var requestPool: Dictionary<String,String> = [:]
    /// 请求编号主键
    private var requestNumber: Int = 1
    /// 会话管理
    private lazy var sessionManager:SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(HFAppConfiguration.requestOutTime)
//        configuration.httpAdditionalHeaders = ["Content-Type":"multipart/form-data"]
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    
    /// 请求连接
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - method: 请求方法
    ///   - parameters: 请求参数
    ///   - description: 请求描述
    ///   - complete: complete description
    class func request(url: String,
                       needBaseURL: Bool = true,
                       method: HTTPMethod = .post,
                       parameters: Parameters? = nil,
                       requestHeader: HTTPHeaders? = AppCommon.JsonRequestHeader,
                       encoding: ParameterEncoding = URLEncoding.default,
                       description: String = "未命名请求",
                       complete: @escaping (_ error: Error? ,_ data:JSON?) -> Void) {
        
        var api = url
        if needBaseURL == true {
            api = API.baseURL + url
        }
        
//        if HFAppEngine.shared.networkManager.requestPool[api] != nil {
//            complete(NSError(domain: "重复请求", code: 10088, userInfo: nil), nil)
//            return
//        }

        var p: [String:Any] = [:]
        if parameters  == nil {
            
        }
        else{
            
            // 将字典转为json字符串
            
            p = parameters!
        }
        
        HFAppEngine.shared.networkManager.requestPool[api] = "\(HFAppEngine.shared.networkManager.requestNumber)"
        HFAppEngine.shared.networkManager.requestNumber += 1
        
        // MARK: - 添加头部信息
        var requestHeader: HTTPHeaders = requestHeader!
        
        //附加token字段
        if let token = UserDefaults.standard.object(forKey: TokenKEY) as? String {
            requestHeader["access_token"] = token
        }
        
        // 设置编码格式
//        requestHeader["Content-Type"] = "application/json;charset=utf-8"
//        requestHeader["Content-Type"] = "application/json; application/x-www-form-urlencoded; charset=utf-8"
        
        print(requestHeader)
        
        // 设置请求超时时间: 20s
//        HFAppEngine.shared.networkManager.sessionManager.session.configuration.timeoutIntervalForRequest = 20.0
        
        print("———————— 发起请求 ————————\n请求名称: \(description)\n请求编号: \(HFAppEngine.shared.networkManager.requestPool[api]!)\n请求方式: \(method.rawValue)\n地址: \(api)\n参数: \(JSON(parameters ?? [:]))\n—————————————————————\n")
        
        HFAppEngine.shared.networkManager.sessionManager.request(api, method: method, parameters: p, encoding: encoding, headers: requestHeader).responseJSON { (resp) in
            let url = resp.request?.url?.absoluteString
            let data = JSON(resp.result.value as Any)
            let status = data["status"].intValue
            let code = data["code"].intValue
//            let requestNumber = HFAppEngine.shared.networkManager.requestPool[url!]!
            debugPrint(resp)
            if resp.result.isSuccess == false {
                
                print("———————— 连接失败 ————————\n请求名称: \(description)\n请求方式: \(method.rawValue)\n地址: \(api)\n异常: \(String(describing: resp.result.error.debugDescription))\n—————————————————————\n")
                HFAppEngine.shared.networkManager.requestPool.removeValue(forKey: url!)
                // 连接错误时自定义异常返回
                let errorDesc = "网络连接超时~"
//                complete(resp.result.error!,nil)
                complete(NSError(domain: "MDError", code: 4004, userInfo: [NSLocalizedDescriptionKey : errorDesc]), nil)
                return
                
            }else {
                
                //判断token是否过期：刷新token
                if code == 40005 || code == 40022 {
                    if let rt = UserDefaults.standard.value(forKey: RefreshTokenKEY) as? String {
                        CommonCent?.requestRefreshToken(refreshToken: rt, complete: { (isSucceed, data, msg) in
                            switch isSucceed {
                            case true:
                                debugPrint("刷新token成功 --------------------->")
                                self.request(url: api, needBaseURL: false, method: method, parameters: p, requestHeader: requestHeader, encoding: encoding, description: description, complete: complete)
                                break
                            case false:
                                SVProgressHUD.showError(withStatus: msg)
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                    HFAppEngine.shared.loginOut()
                                }
                                break
                            }
                        })
                    }else {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            HFAppEngine.shared.loginOut()
                        }
                    }
                }
                
                if status == 1 {
                    print("———————— 收到响应 ————————\n请求名称: \(description)\n请求方式: \(method.rawValue)\n地址: \(api)\n状态: \(resp.result.isSuccess)\n数据: \(data)\n—————————————————————\n")
                    HFAppEngine.shared.networkManager.requestPool.removeValue(forKey: url!)
                    complete(nil,data)
                    
                    return
                }else if status == 10000 {
                    print("———————— 连接失败 ————————\n请求名称: \(description)\n请求方式: \(method.rawValue)\n地址: \(api)\n异常: \(data["msg"].stringValue))\n—————————————————————\n")
                    SVProgressHUD.dismiss()
                    HFAppEngine.shared.networkManager.requestPool.removeValue(forKey: url!)
//                    HFAppEngine.shared.loginDidFailure(msg: data["msg"].stringValue)
                    return
                } else {
                    
                    print("———————— 收到响应 ————————\n请求名称: \(description)\n请求方式: \(method.rawValue)\n地址: \(api)\n状态: \(resp.result.isSuccess)\n异常: \(data["info"].stringValue)\n数据: \(data)\n—————————————————————\n")
                    HFAppEngine.shared.networkManager.requestPool.removeValue(forKey: url!)
                    complete(nil,data)
                    return
                }
                
                
            }
            
        }
        
    }
    
    /// 上传视频
    ///
    /// - Parameters:
    ///   - path: 视频路径
    ///   - name: 名字
    ///   - complete: -
    class func upload(path: URL,
                      name: String,
                      complete: @escaping (_ error: Error? ,_ data:JSON?) -> Void) {
        
        let api = URL.init(string: API.baseURL + API.uploadVideo)!
        
        print("———————— 发起请求 ————————\n请求名称: 上传文件\n请求方式: upload\n地址: \(api)\n—————————————————————\n")
        
    
        HFAppEngine.shared.networkManager.sessionManager.upload(multipartFormData: { (formdata) in
            formdata.append(path, withName: name)
        }, to: api, encodingCompletion: { (encodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { (resp) in
                    let url = resp.request?.url?.absoluteString
                    let data = JSON(resp.result.value as Any)
                    let status = data["status"].intValue
                    debugPrint(resp)
                    if resp.result.isSuccess == false {
                        
                        print("———————— 连接失败 ————————\n请求名称: 上传文件\n请求方式: upload\n地址: \(api)\n异常: \(String(describing: resp.result.error.debugDescription))\n—————————————————————\n")
                        HFAppEngine.shared.networkManager.requestPool.removeValue(forKey: url!)
                        complete(resp.result.error!,nil)
                        return
                        
                    }else {
                        
                        if status == 1 {
                            print("———————— 收到响应 ————————\n请求名称: 上传文件\n请求方式: upload\n地址: \(api)\n状态: \(resp.result.isSuccess)\n数据: \(data)\n—————————————————————\n")
                            HFAppEngine.shared.networkManager.requestPool.removeValue(forKey: url!)
                            complete(nil,data)
                            
                            return
                        }else if status == 10000 {
                            print("———————— 连接失败 ————————\n请求名称: 上传文件\n请求方式: upload\n地址: \(api)\n异常: \(data["msg"].stringValue))\n—————————————————————\n")
                            SVProgressHUD.dismiss()
                            HFAppEngine.shared.networkManager.requestPool.removeValue(forKey: url!)
                            //                    HFAppEngine.shared.loginDidFailure(msg: data["msg"].stringValue)
                            return
                        } else {
                            
                            print("———————— 收到响应 ————————\n请求名称: 上传文件\n请求方式: upload\n地址: \(api)\n状态: \(resp.result.isSuccess)\n异常: \(data["info"].stringValue)\n数据: \(data)\n—————————————————————\n")
                            HFAppEngine.shared.networkManager.requestPool.removeValue(forKey: url!)
                            complete(nil,data)
                            return
                        }
                        
                        
                    }
                    
                }
                
                
                
//                responseJSON(completionHandler: { (resp) in
                
//                    let data = JSON(resp.result.value as Any)
//                    let status = data["status"].string
//                    let msg = data["msg"].string
//                    let data
//                })
            case .failure(let error):
                print(error)
            }
           
        })
    }
//
//        upload(.POST, URL, multipartFormData: { (FormData) in
//            FormData.appendBodyPart(data: String(userInfo["id"] as! Int).dataUsingEncoding(NSUTF8StringEncoding)!, name: "userId")
//            FormData.appendBodyPart(data: nsData, name: "file", fileName: "fileName", mimeType: "image/png")
//        }, encodingCompletion: { (encodingResult) in
//            switch encodingResult {
//            case .Success(let upload, _, _):
//                upload.responseJSON(completionHandler: { (response) in
//                    print("\(response)")  //上传成功通过response返回json值
//                })
//            case .Failure(let error):
//                print(error)
//            }
//        })

    
    
    // MARK: - AMFC：网络访问

}
//定义错误类型
enum MDError: Error, CustomStringConvertible {
    case invalidSelection
    case customStr(desc: String)
    case outOfStock
    
    var localizedDescription: String {
        return "错误处理~ 呵呵呵呵呵呵~"
    }
    
    var description: String {
        return "错误处理~ 呵呵呵呵呵呵~ 哈哈哈哈哈哈~"
    }
}



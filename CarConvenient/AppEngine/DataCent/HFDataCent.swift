//
//  HFDataCentBase.swift
//  Ecosphere
//
//  Created by 姚鸿飞 on 2017/5/26.
//  Copyright © 2017年 encifang. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import ObjectMapper


class HFDataCent: NSObject {
    
    var fileName: String = "DataCent.dc"
    
    internal func uploadFile(url: URL,complete:@escaping ((_ isSucceed: Bool,_ msg: String, _ data: String?) -> Void)) {
        
        
        HFNetworkManager.upload(path: url, name: "video_file", complete: { (error, resp) in

            // 连接失败时
            if error != nil {
                complete(false,  error!.localizedDescription, nil)
                return
            }
            let status: String = resp!["status"].string!
            let msg: String = resp!["msg"].string!
            
            // 请求失败时
            if status == "0" {
                complete(false, msg, nil)
                return
            }
            
            // 请求成功时
            let data = resp!["data"].string
            complete(true,msg ,data)
            
        })
        
        
    }
    
    // MARK: - base64上传图片
    internal func uploadImagesWith64(images:[UIImage],complete:@escaping ((_ isSucceed: Bool,_ msg: String, _ data: String) -> Void)) {
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "getOrderData")
        var flag = true
        var msg = ""
        var tmpStr: String = ""
        
        for image: UIImage in images {
            
            let imageData = UIImageJPEGRepresentation(image, 0.8)
            let encodedImageStr = imageData!.base64EncodedString(options: .lineLength64Characters)
            let param:[String:Any] = ["img":encodedImageStr]
            group.enter()
            queue.async(group: group) {
                HFNetworkManager.request(url: API.imgUp, method: .post, parameters: param, description: "图片批量上传") { (error, resp) in
                    
                    // 连接失败时
                    if error != nil {
                        flag = false
                        tmpStr = ""
                        msg = error!.localizedDescription
                        group.leave()
                        return
                    }
                    
                    let info: String? = resp?["msg"].stringValue
                    
                    let status: Int? = resp?["status"].intValue
                    
                    // 请求失败时
                    if status != 1 {
                        flag = false
                        tmpStr = ""
                        msg = info!
                        group.leave()
                        return
                    }
                    
                    // 请求成功时
                    
                    let data = resp!["data"].dictionaryObject
                    if tmpStr != "" {
                        tmpStr += ","
                    }
                    tmpStr += data!["imgUrl"] as! String
                    
                    msg = info!
                    
                    group.leave()
                    
                }
            }
            
        }
        
        group.notify(queue: .main) {
            
            complete(flag, msg, tmpStr)
        }
        
    }
    
    internal func uploadImagesWith64(image:UIImage,complete:@escaping ((_ isSucceed: Bool,_ msg: String, _ data: String?) -> Void)) {
        
        
        let imageData = UIImageJPEGRepresentation(image, 0.8)
        let encodedImageStr = imageData!.base64EncodedString(options: .lineLength64Characters)
        let param:[String:Any] = ["img":encodedImageStr]
        
        HFNetworkManager.request(url: API.imgUp, method: .post, parameters: param, description: "图片上传") { (error, resp) in
            
            // 连接失败时
            if error != nil {
                complete(false, error!.localizedDescription, nil)
                return
            }
            
            let info: String? = resp?["msg"].stringValue
            
            let status: Int? = resp?["status"].intValue
            
            // 请求失败时
            if status != 1 {
                complete(false, info!, nil)
                return
            }
            // 请求成功时
            
            let data = resp!["data"].dictionaryObject
            let imgUrl = data!["imgUrl"] as! String
            
            complete(true, info!, imgUrl)
            
        }
        
        
    }
     
    
    // MARK: - 批量上传图片
    /// 批量上传图片
    ///
    /// - Parameters:
    ///   - images: 图片集
    ///   - complete: -
    func uploadImages(images:[UIImage], documentName:String = "",complete:@escaping ((_ isSucceed: Bool,_ data: [String]?, _ message: String) -> Void)) {
        
        var urlArray = [String]()
        for i in 0..<images.count {
            var flag = true
            var msg = ""
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    let imageData = UIImageJPEGRepresentation(images[i], 0.6)
                    multipartFormData.append(imageData!, withName: "pic", fileName: "tlfitness.jpg", mimeType: "image/jpeg")
                    multipartFormData.append(documentName.data(using: String.Encoding.utf8)!, withName: "type")
            },to: API.baseURL + API.imgUp ,encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    //连接服务器成功后，对json的处理
                    upload.responseJSON { response in
                        //解包
                        guard let result = response.result.value else { return }
                        let data = JSON(result as Any)
                        let info:String = data["msg"].stringValue
                        let status: Int? = data["status"].intValue
                        // 请求失败时
                        if status != 200 {
                            flag = false
                            msg = info
                            complete(flag, nil, msg)
                            return
                        }
                        // 请求成功时
                        
                        let dataDic = data["data"].dictionaryObject
                        
                        guard let tempM = Mapper<QBImageModel>().map(JSONObject: dataDic) else {
                            return
                        }
                        msg = info
                        urlArray.append(tempM.data_src ?? "")
                        if urlArray.count == images.count{
                            complete(flag, urlArray, msg)
                        }
                    }
                    //获取上传进度
                    upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                        print("图片上传进度: \(progress.fractionCompleted)")
                    }
                case .failure(let encodingError):
                    complete(false, nil, msg)
                    print(encodingError)
                }
            })
        }
    }
    /*
     internal func uploadImages(type: Int = -1, images:[UIImage],complete:@escaping ((_ isSucceed: Bool,_ msg: String, _ data: String?) -> Void)) {
        
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "upImageData")
        
        var flag = true
        var msg = ""
        var tmpStr: String = ""
        
        for image:UIImage in images {
            let imageData = UIImageJPEGRepresentation(image, 0.6)
            group.enter()
            queue.async(group: group) {
                Alamofire.upload(
                    multipartFormData: { multipartFormData in
                        multipartFormData.append(imageData!, withName: "pic", fileName: "tlfitness.jpg", mimeType: "image/jpeg")
                },to: API.baseURL + API.imgUp ,encodingCompletion: {encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            guard let result = response.result.value else { return }
                            let data = JSON(result as Any)
                            let info:String = data["msg"].stringValue
                            let status: Int? = data["status"].intValue
                                // 请求失败时
                                if status != 1 {
                                    flag = false
                                    tmpStr = ""
                                    msg = info
                                    group.leave()
                                    return
                                }
                                // 请求成功时
                                if tmpStr != "" {
                                    tmpStr += ","
                                }
                            tmpStr += data["data"].stringValue
                            msg = info
                            group.leave()
                        }
                        upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
//                            print("图片上传进度: \(progress.fractionCompleted)")
                        }
                    case .failure(let encodingError):
                        complete(false, "上传出错", nil)
                        group.leave()
                        print(encodingError)
                        return
                    }
                })
//                group.leave()
            
            }
        
        }
        group.notify(queue: .main) {
            
            complete(flag, msg, tmpStr)
        }
        
    }
    
    internal func uploadImages(type: Int = -1, image:UIImage,complete:@escaping ((_ isSucceed: Bool,_ msg: String, _ data: String?) -> Void)) {
        
        
        let imageData = UIImageJPEGRepresentation(image, 0.8)
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //采用post表单上传
                // 参数解释：
                //withName:和后台服务器的name要一致 ；fileName:可以充分利用写成用户的id，但是格式要写对； mimeType：规定的，要上传其他格式可以自行百度查一下
                multipartFormData.append(imageData!, withName: "img_url", fileName: "123456.jpg", mimeType: "image/jpeg")
                //如果需要上传多个文件,就多添加几个
                //multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
                //......
                
        },to: API.baseURL + API.imgUp ,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    guard let result = response.result.value else { return }
                    print("json:\(result)")
                    let data = JSON(result as Any)
                    complete(true, data["msg"].stringValue, data["data"].stringValue)
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
            case .failure(let encodingError):
                //打印连接失败原因
                complete(false, "上传出错", nil)
                print(encodingError)
            }
        })
        
        
        //            let imageData = UIImageJPEGRepresentation(image, 0.8)
        //            let encodedImageStr = imageData!.base64EncodedString(options: .lineLength64Characters)
        //            let param:[String:Any] = ["img_url":encodedImageStr]
        //
        //                HFNetworkManager.request(url: API.imgUp, method: .post, parameters: param, description: "图片上传") { (error, resp) in
        //
        //                    // 连接失败时
        //                    if error != nil {
        //                        complete(false, error!.localizedDescription, nil)
        //                        return
        //                    }
        //
        //                    let info: String? = resp?["msg"].stringValue
        //
        //                    let status: Int? = resp?["status"].intValue
        //
        //                    // 请求失败时
        //                    if status != 1 {
        //                        complete(false, info!, nil)
        //                        return
        //                    }
        //
        //                    // 请求成功时
        //
        //                    let data = resp!["data"].string
        ////                    let imgUrl = data!["imgUrl"] as! String
        //
        //                    complete(true, info!, data)
        //
        //                }
        
        
    }
    */
    
    // MARK: - 批量上传图片
    /// 批量上传图片
    ///
    /// - Parameters:
    ///   - images: 图片集
    ///   - complete: -
    func uploadBusiImages(type:String = "" ,images:[UIImage], documentName:String = "",complete:@escaping ((_ isSucceed: Bool,_ data: [String]?, _ message: String) -> Void)) {
        
        var flag = true
        var msg = ""
        var tmpStr: [String]?
        
        let requestHeader: HTTPHeaders = [:]
        var index = 0
        
        var url = ""
        
        if type != "" {
            url = API.imgUp
        }else {
            url = API.ModifyPortrait
        }
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for image:UIImage in images{
                    let imageData = UIImageJPEGRepresentation(image, 0.6)
                    multipartFormData.append(imageData!, withName: "pic", fileName: "tlfitness.jpg", mimeType: "image/jpeg")
//                    multipartFormData.append(documentName.data(using: String.Encoding.utf8)!, withName: "type")
                    index += 1
                }
//                if type != "" {
//                    let param = ["type":type]
//                    for (key, value) in param {
//                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                    }
//                }
        },to: API.baseURL + url ,headers: requestHeader,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    guard let result = response.result.value else { return }
                    let data = JSON(result as Any)
                    let info:String = data["msg"].stringValue
                    let status: Int? = data["status"].intValue
                    
                    // 请求失败时
                    if status != 200 {
                        flag = false
                        tmpStr = nil
                        msg = info
                        complete(flag, tmpStr, msg)
                        return
                    }
                    // 请求成功时
                    
                    let dataDic = data["data"].dictionaryObject
                    
                    guard let tempM = Mapper<QBImageModel>().map(JSONObject: dataDic) else {
                        return
                    }
                    tmpStr = [tempM.data_src ?? ""]
                    complete(flag, tmpStr, msg)
                    
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
            case .failure(let encodingError):
                complete(false, tmpStr, msg)
                print(encodingError)
            }
        })
        
    }
    
    /// 写入数据到本地
    ///
    /// - Parameter setSave: 在此回调中设置存储的属性
    /// - Returns: 是否写入成功
    @discardableResult
    internal func writeDataToLocal(setSave:(( _ archiver: inout NSKeyedArchiver) -> String)) -> Bool {
        let data: NSMutableData = NSMutableData()
        var archiver = NSKeyedArchiver(forWritingWith: data)
        
        // 写入数据
//        archiver.encode(self.data_saveList, forKey: "saveList")
//        for (key, obj) in self.data_saveList {
//            archiver.encode(obj, forKey: key)
//        }
        let fileName = setSave(&archiver)
        
        
        
        let path = savePath + "/" + fileName
        
        archiver.finishEncoding()
        let result = data.write(toFile: path, atomically: true)
        return result
    }
    
    
    /// 从本地读取数据
    ///
    /// - Parameter setRead: 设置读取的数据赋值的对象
    internal func readDataFormLocal(fileName: String,setRead:((_ unarchiver: inout NSKeyedUnarchiver) -> Void)) {
        
        let data = NSData(contentsOfFile: savePath + "/" + fileName)
        
        if data == nil {
            return
        }
        var unarchiver = NSKeyedUnarchiver(forReadingWith: data! as Data)
        
        
//        // 读取数据
//        if let list = unarchiver.decodeObject(forKey: "saveList") as? [String: Any] {
//            self.data_saveList = list
//        }
//        for (key, obj) in self.data_saveList {
        //            obj = unarchiver.decodeObject(forKey: "key")
        //        }
        setRead(&unarchiver)
        
        unarchiver.finishDecoding()
        
    }
    
    /// 清理本地数据
    ///
    /// - Returns: return value description
    internal func cleanLocalData() -> Bool {
        
        let fileManager = FileManager.default
        
        let blHave = fileManager.fileExists(atPath: dataFilePath)
        
        if !blHave {
            return false
        }else {
            
            do{
                try fileManager.removeItem(atPath: dataFilePath)
                return true
            }catch{
                return false
            }
            
        }
        
    }
    
}

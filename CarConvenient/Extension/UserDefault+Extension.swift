//
//  UserDefaultExtension.swift
//  YiBiFen
//
//  Created by Hanson on 16/9/2.
//  Copyright © 2016年 Hanson. All rights reserved.
//

import Foundation

let firstLaunch = "firstLaunch"


extension UserDefaults {
    
    class func bool(forKey key: String) -> Bool {
        return standard.bool(forKey: key)
    }
    
    class func setValue(_ value: Any?, forKey key: String, synchronize: Bool) {
        standard.setValue(value, forKey: key)
        if synchronize { standard.synchronize() }
    }
    
    
    /// 归档一个Any对象
    ///
    /// - Parameter obj: Any对象
    static func md_saveWithNSKeyedArchiver(obj: Any?) {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent("loginuser.data");
        let obj = obj
        /**
         *  数据归档处理
         */
        NSKeyedArchiver.archiveRootObject(obj!, toFile: filePath);
    }
    
    
    /// 读取归档的对象
    ///
    /// - Returns: 对象
    static func md_readWithNSKeyedUnarchiver() -> Any? {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent("loginuser.data");
        //判断文件是否存在
        var obj: NSObject?
        let isFileExist = md_checkFileExist(fileName: filePath)
        if isFileExist {
            obj = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? NSObject;
            debugPrint(obj?.description)
        }
        return obj
    }
    
    
    /// 保存图片（归档）
    ///
    /// - Parameter img: 要保持的图片
    static func md_saveImgWithNSKeyedArchiver(img: UIImage) {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent("loginuserImg.data");
        /**
         *  数据归档处理
         */
        NSKeyedArchiver.archiveRootObject(img, toFile: filePath);
    }
    
    
    /// 读取保存的图片
    ///
    /// - Returns: 成功读取到图片
    static func md_readImgWithNSKeyedUnarchiver() -> UIImage? {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent("loginuserImg.data");
        //判断文件是否存在
        var obj: UIImage?
        let isFileExist = md_checkFileExist(fileName: filePath)
        if isFileExist {
            obj = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? UIImage;
        }
        return obj
    }
    
    /// 检查文件是否存在：
    ///
    /// - Parameter fileName: 文件全路径
    /// - Returns: 文件是否存在
    static func md_checkFileExist(fileName: String) -> Bool{
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: fileName)
    }
    
    
    /// 判断UIImage类型：png/jpeg （是否有透明度来判断）
    ///
    /// - Parameter image: 图片
    /// - Returns: 类型true：png, flase: jpeg
    static func md_imageHasAlpha(image: UIImage) -> Bool{
        var alpha = image.cgImage!.alphaInfo
        return (alpha == CGImageAlphaInfo.first ||
            alpha == CGImageAlphaInfo.last ||
            alpha == CGImageAlphaInfo.premultipliedFirst ||
            alpha == CGImageAlphaInfo.premultipliedLast)
    }
    
    
    /// 将UIImage转成带image/png || image/jpeg前缀的base64字符串
    ///
    /// - Parameter image: 图片
    /// - Returns: base64字符串
    static func md_image2DataURL(image: UIImage) -> String {
        var imageData: NSData? = nil;
        var mimeType: NSString? = nil;
        
        if (self.md_imageHasAlpha(image: image)) {
            imageData = UIImagePNGRepresentation(image) as NSData?;
            mimeType = "image/png";
        } else {
            imageData = UIImageJPEGRepresentation(image, 1.0) as NSData?;
            mimeType = "image/jpeg";
        }
        //前缀：data:image/jpeg;base64,...
        //imgstr = image/jpeg
        return "data:\(mimeType!);base64,"+(imageData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))!
        
    }
    
    /// 计算缓存大小
    ///
    /// - Returns: 缓存大小
    static func md_caculateCache() ->String {
        let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).first
        let fileManager = FileManager.default
        debugPrint("cache＝ \(basePath)")
        
        
        var total:Float = 0
        if fileManager.fileExists(atPath: basePath!){
            let childrenPath = fileManager.subpaths(atPath: basePath!)
            if childrenPath != nil{
                for path in childrenPath!{
                    let childPath = basePath?.appending("/").appending(path)
                    do{
                        let attr = try fileManager.attributesOfItem(atPath: childPath!)
                        let key = FileAttributeKey.init("NSFileSize")
                        let fileSize = attr[key]as! Float
                        total += fileSize
                        
                    }catch{
                        
                    }
                }
            }
        }
        
        //        let cacheSize = NSString(format: "%.1f MB缓存", total / 1024.0 / 1024.0 )as String
        let cacheSize = NSString(format: "%.1f", total / 1024.0 / 1024.0 )as String
        return cacheSize
    }
    
    /// 清除缓存
    ///
    /// - Returns: 是否清楚成功
    static func md_clearCache() ->Bool{
        var result = false
        let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).first
        debugPrint("cache＝ \(basePath)")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: basePath!){
            let childrenPath = fileManager.subpaths(atPath: basePath!)
            for childPathin in childrenPath!{
                //过滤登录信息缓存路径
                if childPathin != "loginuser.data"{
                    let cachePath = basePath?.appending("/").appending(childPathin)
                    do{
                        try fileManager.removeItem(atPath: cachePath!)
                    }catch{
                        //                    result = false
                    }
                }
            }
        }
        if NumberFormatter().number(from: md_caculateCache())?.floatValue == 0 {
            result = true
        }
        
        return result
    }
}

/*
 //（1）获取变量
 let appDelegate = UIApplication.shared.delegate as! AppDelegate
 
 //（2）在viewDidLoad中修改blockRotation变量值
 override func viewDidLoad() {
 super.viewDidLoad()
 appDelegate.blockRotation = true
 }
 
 //（3）viewWillAppear 设置页面横屏
 override func viewWillAppear(animated: Bool) {
 let value = UIInterfaceOrientation.LandscapeLeft.rawValue
 UIDevice.currentDevice().setValue(value, forKey: "orientation")
 }
 
 //（4）viewWillDisappear设置页面转回竖屏
 override func viewWillDisappear(animated: Bool) {
 appDelegate.blockRotation = false
 let value = UIInterfaceOrientation.Portrait.rawValue
 UIDevice.currentDevice().setValue(value, forKey: "orientation")
 }
 
 //（5）横屏页面是否支持旋转
 // 是否支持自动横屏。看项目可调，可以设置为true
 override func shouldAutorotate() -> Bool {
 return false
 }
 */

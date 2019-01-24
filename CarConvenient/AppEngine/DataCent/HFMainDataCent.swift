//
//  HFMainDataCent.swift
//  AppEngineDemo
//
//  Created by 姚鸿飞 on 2017/6/14.
//  Copyright © 2017年 姚鸿飞. All rights reserved.
//

import UIKit

/// 主数据中心，用于存储通用数据
class HFMainDataCent: HFDataCent {
    
    var data_UserData: HFUserData?
    
    

    // MARK: 本地化存储（归档/反归档）
    /// 从本地读取
    @discardableResult
    func readDataFormLocal() -> Bool  {
        
        self.readDataFormLocal(fileName: "MainData", setRead: { (unarchiver) in
            
            // 在此设置需要读取本地对对象
            
            self.data_UserData = unarchiver.decodeObject(forKey: "UserData") as? HFUserData
            
        })
        
        if self.data_UserData != nil {return true }else {return false }
        
    }
    /// 将数据写入本地
    @discardableResult
    func writeDataToLocal() -> Bool {
        return self.writeDataToLocal(setSave: { (archiver) -> String in
            
            // 在此设置需要写入对象至本地
//            let archiver = UnsafePointer<NSKeyedArchiver>.init(bitPattern: 1)
            
            archiver.encode(self.data_UserData, forKey: "UserData")
            
            return "MainData" // 返回保存的文件名
        })
        
    }
    
    
    
}

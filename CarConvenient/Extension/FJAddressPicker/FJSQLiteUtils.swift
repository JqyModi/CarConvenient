//
//  SQLiteManager.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/22.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
//import FMDB

class FJSQLiteUtils: NSObject {
    /// 单例
    static let instance = FJSQLiteUtils()
    
    
    /// 选中的
    var itemArray:[AddressModel] = []
    
    
    /// 配置信息
    var arribute = AddressAttribute()
    
    
    override init() {
        super.init()
    }
}

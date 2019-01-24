//
//  UIDevice+Extension.swift
//  GST_SY
//
//  Created by mac on 2018/1/23.
//  Copyright © 2018年 hrscy. All rights reserved.
//
import UIKit

extension UIDevice {
    
    /// 判断是否是iPhone X
    ///
    /// - Returns: 是/否
    public func md_isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
}

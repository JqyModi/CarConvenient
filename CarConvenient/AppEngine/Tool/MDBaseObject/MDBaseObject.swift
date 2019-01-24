//
//  MDBaseObject.swift
//  MDObject
//
//  Created by Modi on 2018/9/27.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit

@objcMembers
class MDBaseObject: NSObject {
    
    override var description: String {
        return self.getPropertiesAndValues().description
    }
    
}
extension NSObject {
    /// 获取当前对象的所有属性和值
    func getPropertiesAndValues() -> [String: Any?] {
        var tempDic = [String: Any?]()
        var count :UInt32 = 0
        let ivar = class_copyIvarList(self.classForCoder, &count)
        for i in 0..<Int(count) {
            let iv = ivar![i]
            //获取成员变量的名称 -》 c语言字符串
            let cName = ivar_getName(iv)
            //转换成String字符串
            guard  let Strname = String.init(utf8String: cName!) else {
                //继续下一次遍历
                continue
            }
            //利用kvc 取值
            if let value = self.value(forKey: Strname) {
                tempDic[Strname] = value
            }
        }
        // 释放c 语言对象
        free(ivar)
        return tempDic
    }
}
class Person: MDBaseObject {
    
    //    static let standard: Person = Person()
    
    var name: String? = "Modi"
    
    var like: String? = "游泳🏊"
    
    var age: Int = 120
    
    var fAge: Float = 1000
    
    var color: UIColor? = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    var bgColor: UIColor? = #colorLiteral(red: 0.5270761847, green: 0.5328453779, blue: 0.9979786277, alpha: 1)
    
    var sex: String? = "男"
    
    class func getOriginDic() -> [String: Any] {
        let dic: [String: Any] = ["name": "M偶滴覅地", "like": "滑雪⛷", "age": 100, "color": #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), "bgColor": #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), "sex": "女"]
        return dic
    }
}

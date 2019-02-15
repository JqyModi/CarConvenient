//
//  ZALotteryModel.swift
//  ZhongAiHealth
//
//  Created by 微标杆 on 2018/10/29.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit
import ObjectMapper

class ZALotteryModel: NSObject,Mappable {
    
    var remark: String?
    var id: Int = 0
    var prizename: String?
    var img: String?
    var credit: Int = 0
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        remark <- map["remark"]
        id <- map["id"]
        prizename <- map["prizename"]
        img <- map["img"]
        credit <- map["credit"]
    }
    
}

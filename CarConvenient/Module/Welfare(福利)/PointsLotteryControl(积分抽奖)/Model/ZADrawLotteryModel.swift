//
//  ZADrawLotteryModel.swift
//  ZhongAiHealth
//
//  Created by 微标杆 on 2018/10/29.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit
import ObjectMapper

class ZADrawLotteryModel: NSObject,Mappable {
    
    var prizeid: Int = 0
    var prizename: String?
    
    override init() {
        super.init()
        
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        prizeid <- map["prizeid"]
        prizename <- map["prizename"]
    }
    
}

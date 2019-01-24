//
//  BannerModel.swift
//  AMFC
//
//  Created by Modi on 2018/8/22.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit
import ObjectMapper

class BannerModel: NSObject, Mappable {
    var data_imgJump: String?
    var data_imgType: Int = 0
    var data_imgUrl: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.data_imgJump <- map["imgJump"]
        self.data_imgType <- map["imgType"]
        self.data_imgUrl <- map["imgUrl"]
        
    }
}


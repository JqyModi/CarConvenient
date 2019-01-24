//
//  AddressModel.swift
//  LT
//
//  Created by Modi on 2018/6/22.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit
import ObjectMapper

class AddressModel: NSObject,Mappable {
    
    var parent_id: String?
    var id: String?
    var level: String?
    var name: String?
    var seleted: Int?
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.parent_id <- map["parent_id"]
        self.id <- map["id"]
        self.level <- map["level"]
        self.name <- map["name"]
        self.seleted <- map["seleted"]
    }
    
    
}

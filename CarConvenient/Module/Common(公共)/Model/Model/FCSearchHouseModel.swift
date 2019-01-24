//
//  FCSearchHouseModel.swift
//  AMFC
//
//  Created by Modi on 2018/8/23.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit
import ObjectMapper

class FCSearchHouseModel: NSObject, Mappable {
//    var data_number: Int = 0
    var data_number: String?
    var data_floor: Int = 0
    var data_floorArea: Int = 0
    var data_ID: Int = 0
    var data_houseSpace: String?
    var data_averageUlnarPrice: Int = 0
    var data_housePrice: Int = 0
    var data_name: String?
    var data_houseImg: String?
    
    var data_houseMsgId: Int = 0
    
    var data_city: String?
    var data_area: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        self.data_number <- map["number"]
        self.data_floor <- map["floor"]
        self.data_floorArea <- map["floorArea"]
        self.data_ID <- map["id"]
        self.data_houseSpace <- map["houseSpace"]
        self.data_averageUlnarPrice <- map["averageUlnarPrice"]
        self.data_housePrice <- map["housePrice"]
        self.data_name <- map["name"]
        self.data_houseImg <- map["houseImg"]
        
        self.data_houseMsgId <- map["houseMsgId"]
        
        self.data_city <- map["city"]
        self.data_area <- map["area"]
        
    }
}


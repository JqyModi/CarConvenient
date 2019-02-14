//
//  MCLocalModel.swift
//  InternetOfProfit
//
//  Created by 毛诚 on 2018/9/3.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit
import ObjectMapper

class MCLocalModel: NSObject {

}

///// -------假数据---------->
class MCLocalHotCityModel: NSObject ,Mappable{
    
    var cityNameStr:String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        self.cityNameStr <- map["cityNameStr"]
        
    }
    
    
}


class MCLocalCityArrayModel: NSObject ,Mappable{
    
    var letterStr:String? //首字母
    var Citys:[MCLocalCityModel]?
    
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        self.letterStr <- map["letterStr"]
        self.Citys <- map["Citys"]
    }
    
    
}


class MCLocalCityModel: NSObject ,Mappable{
    
    var cityName:String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        self.cityName <- map["cityName"]
        
    }
    
    
}

///// -------正式数据---------->
///城市列表模型 - 热门 ,城市，城市模型
class MCCityListArrayModel: NSObject ,Mappable{
    
    var code:String?
    var data:[MCCityListSingleModel]?
    var msg:String?
    var status:String?
    
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        self.code <- map["code"]
        self.data <- map["data"]
        self.msg <- map["msg"]
        self.status <- map["status"]
        
    }
    
    
}
////单个城市模型
class MCCityListSingleModel: NSObject ,Mappable{
    
    var city:String?
    var id:String?
    var keyword:String?

    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        self.city <- map["city"]
        self.id <- map["id"]
        self.keyword <- map["keyword"]
        
    }
    
    
}








//
//  MDTaoPasswordParseModel.swift
//  QBuy
//
//  Created by Modi on 2018/12/28.
//  Copyright © 2018年 weibiaogan. All rights reserved.
//

import ObjectMapper

class MDTaoPasswordParseModel: Mappable {
    var data_picUrl: String?
    var data_content: String?
    var data_validDate: String?
    var data_code: Int = 0
    var data_pj: String?
    var data_taopwdOwnerId: String?
    var data_msg: String?
    var data_ret: String?
    var data_url: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        data_picUrl <- map["picUrl"]
        data_content <- map["content"]
        data_validDate <- map["validDate"]
        data_code <- map["code"]
        data_pj <- map["pj"]
        data_taopwdOwnerId <- map["taopwdOwnerId"]
        data_msg <- map["msg"]
        data_ret <- map["ret"]
        data_url <- map["url"]
    }
}

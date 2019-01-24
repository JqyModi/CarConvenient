//
//  TokenModel.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/21.
//  Copyright © 2019年 modi. All rights reserved.
//

import ObjectMapper

class TokenModel: Mappable {
    var data_accessToken: String?
    var data_refreshToken: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        data_accessToken <- map["accessToken"]
        data_refreshToken <- map["refreshToken"]
    }
}

//
//  QBImageModel.swift
//  QBuy
//
//  Created by Modi on 2018/11/26.
//  Copyright © 2018年 weibiaogan. All rights reserved.
//

import ObjectMapper

class QBImageModel: Mappable {
    var data_src: String?
    var data_storePath: String?
    var data_fileName: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        data_src <- map["src"]
        data_storePath <- map["storePath"]
        data_fileName <- map["fileName"]
    }
}

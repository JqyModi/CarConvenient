//
//  STServiceViewControllerMode.swift
//  CarConvenient
//
//  Created by suteer on 2019/2/12.
//  Copyright © 2019 modi. All rights reserved.
//

import ObjectMapper
import UIKit




class STServiceViewControllerMode : NSObject ,Mappable {
    
    var title = "label"
    var pic = "print_load"
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        title <- map["title"]
        pic <- map["pic"]
    }
    
    

}


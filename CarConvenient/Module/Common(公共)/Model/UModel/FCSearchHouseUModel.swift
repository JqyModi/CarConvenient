//
//  FCSearchHouseUModel.swift
//  AMFC
//
//  Created by Modi on 2018/8/23.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit

class FCSearchHouseUModel: NSObject {
    var upload_page: Int = 0
    var upload_pageSize: Int = 0
    var upload_sellingMode: String?
    var upload_search: String?
    var upload_houseTypeId: [Int]?
    var upload_houseRegion: String?
    var upload_housePriceMax: Double = 0.00
    var upload_housePriceMin: Double = 0.00
    var upload_houseSpace: [String]?
    var upload_userId: String?
    var upload_city: Int = 0
    var upload_province: Int = 0
    var upload_area: [Int]?
}

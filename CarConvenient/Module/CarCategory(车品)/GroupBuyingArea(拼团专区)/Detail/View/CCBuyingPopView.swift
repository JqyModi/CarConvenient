//
//  CCBuyingPopView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit
import TagListView

class CCBuyingPopView: BaseView {

    @IBOutlet weak var tagListview: TagListView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tagListview.addTags(["规格001", "规格002", "规格003", "规格004", "规格005", "规格002", "规格003", "规格004", "规格005"])
    }

}

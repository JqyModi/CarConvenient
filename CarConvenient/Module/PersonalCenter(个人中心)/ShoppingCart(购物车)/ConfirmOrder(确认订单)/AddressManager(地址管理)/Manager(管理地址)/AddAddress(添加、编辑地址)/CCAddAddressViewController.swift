//
//  CCAddAddressViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCAddAddressViewController: BaseViewController {
    
    /// 编辑类型：0：添加 1：编辑
    typealias EditType = Int
    var type: EditType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if type == 0 {
            title = "添加收货地址"
        }else {
            title = "编辑收货地址"
            self.refillData()
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        addRightItem(title: "保存", fontColor: UIColor(rgba: "#1B82D2"))
    }

    override func clickRight(sender: UIButton) {
        super.clickRight(sender: sender)
        
    }
}
// MARK: - 填充数据
extension CCAddAddressViewController {
    private func refillData() {
        
    }
}

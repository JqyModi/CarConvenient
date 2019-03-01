//
//  CCOrderOutSideViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/28.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCOrderOutSideViewController: BasePageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "订单"
    }

    override func setupStyle() {
        super.setupStyle()
        
        addRightItem(title: "售后", fontColor: UIColor(rgba: "#1B82D2"))
    }
    
    override func clickRight(sender: UIButton) {
        super.clickRight(sender: sender)
        
        let vc = CCFinishOrderViewController.init(Titles: ["已完成", "退款/退货"], vc: [CCOrderViewController(), CCOrderViewController()])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

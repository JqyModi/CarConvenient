//
//  CCCarCategoryViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCCarCategoryViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 添加左右按钮
        addLeftItem(title: "", imageName: "btn_my_n", fontColor: Color.md_NavBarTintColor)
        addRightItem(title: "", imageName: "btn_system_n", fontColor: Color.md_NavBarTintColor)
    
    }

    override func setupTableHeaderView() {
        super.setupTableHeaderView()
        
        let hv = CCCarCategoryHeaderView.md_viewFromXIB() as! CCCarCategoryHeaderView
        hv.autoresizingMask = .flexibleWidth
        tableView.tableHeaderView = hv
        
    }
    
}

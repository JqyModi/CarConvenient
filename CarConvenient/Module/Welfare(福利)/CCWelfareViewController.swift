//
//  CCWelfareViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCWelfareViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func setupTableView() {
        super.setupTableView()
        
        title = "福利中心"
    }
    
    override func setupTableHeaderView() {
        super.setupTableHeaderView()
        
        let hv = CCWelfareHeaderView.md_viewFromXIB() as! CCWelfareHeaderView
        hv.autoresizingMask = .flexibleWidth
        tableView.tableHeaderView = hv
    }
    
}

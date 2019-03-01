//
//  CCEvaluationViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/28.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCEvaluationViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "商品评价"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCOrderTableViewCell"
        tableView.rowHeight = 113
        
        // 显示底部视图
        self.view.sendSubview(toBack: self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(40/375)))
        }
        
    }
    
    override func setupTableFooterView() {
        super.setupTableFooterView()
        
        let fv = CCEvaluationFooterView.md_viewFromXIB() as! CCEvaluationFooterView
        fv.autoresizingMask = .flexibleWidth
        tableView.tableFooterView = fv
    }
    
}
extension CCEvaluationViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCOrderTableViewCell
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}


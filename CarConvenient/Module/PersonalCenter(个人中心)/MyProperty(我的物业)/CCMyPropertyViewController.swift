//
//  CCMyPropertyViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCMyPropertyViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的物业"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCMyPropertyTableViewCell"
        // 显示底部视图
        self.view.sendSubview(toBack: self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(40/375)))
        }
    }
    
    override func setupTableHeaderView() {
        super.setupTableHeaderView()
        
        let hv = CCMyPropertyHeaderView.md_viewFromXIB() as! CCMyPropertyHeaderView
        hv.autoresizingMask = .flexibleWidth
        tableView.tableHeaderView = hv
    }
    
}
extension CCMyPropertyViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCMyPropertyTableViewCell
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "已认证物业"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

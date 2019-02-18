//
//  CCCarGroupViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCCarGroupViewController: BaseTableViewController {

    let models = TimelineModel.models()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "TableViewCell"
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        let nav = CCCarGroupNavView.md_viewFromXIB() as! CCCarGroupNavView
        nav.autoresizingMask = .flexibleWidth
        self.navigationItem.titleView = nav
    }
    
}
extension CCCarGroupViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! TableViewCell
        cell.updateData(model: models[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 根据模型计算出当前Cell的高度
        return models[indexPath.row].rowHeight
    }
}

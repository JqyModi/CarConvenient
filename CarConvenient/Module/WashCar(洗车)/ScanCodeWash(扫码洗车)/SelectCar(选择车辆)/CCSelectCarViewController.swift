//
//  CCSelectCarViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/21.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCSelectCarViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "爱车档案"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCSelectCarTableViewCell"
        tableView.rowHeight = 63
        
        // 显示底部视图
        self.view.sendSubview(toBack: self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(40/375)))
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        addRightItem(title: "继续添加", fontColor: UIColor(rgba: "#1B82D2"))
    }
    
    override func clickRight(sender: UIButton) {
        super.clickRight(sender: sender)
        
        let vc = CCVehicleRecordsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension CCSelectCarViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCSelectCarTableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

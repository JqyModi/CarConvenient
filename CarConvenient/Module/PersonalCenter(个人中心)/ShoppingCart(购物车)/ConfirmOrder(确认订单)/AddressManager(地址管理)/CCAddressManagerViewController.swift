//
//  CCAddressManagerViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCAddressManagerViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "选择收货地址"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCAddressManagerTableViewCell"
        addRightItem(title: "管理", imageName: "", fontColor: UIColor(rgba: "#1B82D2"))
        
    }
    
    override func clickRight(sender: UIButton) {
        super.clickRight(sender: sender)
        let vc = CCManagerAddressViewController.init(nibName: "CCManagerAddressViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension CCAddressManagerViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCAddressManagerTableViewCell
        cell.defaultAddr = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (100/375)
    }
}

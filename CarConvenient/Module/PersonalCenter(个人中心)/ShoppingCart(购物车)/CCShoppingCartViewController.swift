//
//  CCShoppingCartViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/12.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCShoppingCartViewController: BaseTableViewController {

    var editStatus: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "购物车"
    }

    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCShoppingCartTableViewCell"
        addRightItem(title: "编辑", selectTitle: "删除", imageName: "", fontColor: UIColor(rgba: "#1B82D2"))
        
        self.view.sendSubview(toBack: tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(47/375)))
        }
    }
    
    override func clickRight(sender: UIButton) {
        super.clickRight(sender: sender)
        sender.isSelected = !sender.isSelected
        self.editStatus = sender.isSelected
        tableView.reloadData()
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        switch sender.tag {
        case 10001: // 合计
            
            break
        case 10002: // 去结算
            let vc = CCConfirmOrderViewController.init(nibName: "CCConfirmOrderViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
    
    
}
extension CCShoppingCartViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCShoppingCartTableViewCell
        cell.editStatus = self.editStatus
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (113/375)
    }
}

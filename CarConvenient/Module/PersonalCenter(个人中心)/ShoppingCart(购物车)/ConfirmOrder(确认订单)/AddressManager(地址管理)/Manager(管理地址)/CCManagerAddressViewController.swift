//
//  CCManagerAddressViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCManagerAddressViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "收货地址管理"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCManagerAddressTableViewCell"
        
        self.view.sendSubview(toBack: tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(40/375)))
        }
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        jumpToAddAddress(type: 0)
    }

}
extension CCManagerAddressViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCManagerAddressTableViewCell
        cell.clickBlock = {(sender) in
            if let btn = sender as? UIButton {
                switch btn.tag {
                case 10001: // 编辑
                    self.jumpToAddAddress(type: 1)
                    break
                case 10002: // 删除
                    break
                case 10003: // 设为默认
                    btn.isSelected = true
                    break
                default:
                    break
                }
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (131/375)
    }
}
// MARK: - 跳转编辑地址控制器
extension CCManagerAddressViewController {
    private func jumpToAddAddress(type: Int) {
        let vc = CCAddAddressViewController()
        vc.type = type
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

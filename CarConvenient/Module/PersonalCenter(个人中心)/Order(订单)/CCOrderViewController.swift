//
//  CCOrderViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/28.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCOrderViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCOrderTableViewCell"
        
        tableView.rowHeight = 113
        
    }
    
}
extension CCOrderViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return [1,2,3,4,5].randomElement()!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [1,2,3].randomElement()!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCOrderTableViewCell
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let shv = CCOrderSectionHeaderView.md_viewFromXIB() as! CCOrderSectionHeaderView
        shv.autoresizingMask = .flexibleWidth
        return shv
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sfv = CCOrderSectionFooterView.md_viewFromXIB() as! CCOrderSectionFooterView
        sfv.autoresizingMask = .flexibleWidth
        sfv.clickBlock = {(sender) in
            if let btn = sender as? UIButton {
//                let vc = CCRebateViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
                
                let vc = CCEvaluationViewController.init(nibName: "CCEvaluationViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return sfv
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 89
    }
    
}

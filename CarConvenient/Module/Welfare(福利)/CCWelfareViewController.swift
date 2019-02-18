//
//  CCWelfareViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCWelfareViewController: BaseTableViewController {

    private lazy var dataSources: [String] = {
        let contents = ["恭喜136****0040抽中50积分", "恭喜136****0041抽中50元通用优惠券", "恭喜136****0042抽中精美小礼品一份"]
        return contents
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func setupTableView() {
        super.setupTableView()
        
        title = "福利中心"
        tableView.backgroundColor = UIColor(rgba: "#F8F8F8")
    }
    
    override func setupTableHeaderView() {
        super.setupTableHeaderView()
        
        let hv = CCWelfareHeaderView.md_viewFromXIB() as! CCWelfareHeaderView
        hv.autoresizingMask = .flexibleWidth
        hv.delegate = self
        tableView.tableHeaderView = hv
    }
    
}
extension CCWelfareViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CCWelfareTableViewCell")
        cell.textLabel?.text = dataSources[indexPath.row]
        cell.textLabel?.textColor = UIColor(rgba: "#E6162D")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
// MARK: - 头部视图代理：CCWelfareHeaderViewDelegate
extension CCWelfareViewController: CCWelfareHeaderViewDelegate {
    
    func prizeDidSelected() {
        let vc = CCPrizesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func ruleDidSelected() {
        
    }
    
    func menuItemDidSelected(_ index: Int) {
        switch index {
        case 0:
            break
        case 1:
            let vc = CCIntegralMallViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = CCCouponsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = CCGroupDiscountViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
}

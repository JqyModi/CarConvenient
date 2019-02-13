//
//  CCConfirmOrderViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCConfirmOrderViewController: BaseTableViewController {
    
    private lazy var dataSources: [[String: String]] = {
        var temps = [[String: String]]()
        let titles = ["商品总价", "服务费", "运费", "优惠券", "实付款"]
        let values = ["0.00", "0.00", "0.00", "0.00", "0.00"]
        for i in 0..<titles.count {
            let dic = ["title": titles[i], "value": values[i]]
            temps.append(dic)
        }
        return temps
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "订单确认"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
//        self.identifier = "CCConfirmOrderTableViewCell"
        
        self.view.sendSubview(toBack: tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(47/375)))
        }
    }
    
    override func setupTableHeaderView() {
        super.setupTableHeaderView()
        
        let hv = CCConfirmOrderHeaderView.md_viewFromXIB() as! CCConfirmOrderHeaderView
        hv.autoresizingMask = .flexibleWidth
        tableView.tableHeaderView = hv
        
        hv.clickBlock = {(sender) in
            if let btn = sender as? UIButton {
                switch btn.tag {
                case 10001: // 地址
                    let vc = CCAddressManagerViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 10002: // 商品列表
                    break
                case 10003: // 优惠券
                    let vc = CCCouponsViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 10004: // 发票
                    break
                default:
                    break
                }
            }
        }
    }
    
}
extension CCConfirmOrderViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "CCConfirmOrderTableViewCell")
        if let title = dataSources[indexPath.row]["title"] {
            cell.textLabel?.text = title
            cell.textLabel?.textColor = UIColor(rgba: "#333333")
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        }
        if let value = dataSources[indexPath.row]["value"] {
            cell.detailTextLabel?.text = value
            cell.detailTextLabel?.textColor = UIColor(rgba: "#333333")
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            if indexPath.row == 3 { // 优惠券红色字体
                cell.detailTextLabel?.textColor = UIColor.red
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (31.8/375)
    }
}

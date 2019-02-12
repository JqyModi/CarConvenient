
//
//  CCBalanceRechargeViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/12.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCBalanceRechargeViewController: BaseTableViewController {

    private lazy var dataSources: [[String: Any]] = {
        var temps = [[String: Any]]()
        let imgs = ["pay_ic_wechat", "pay_ic_alipay", "pay_ic_upcash"]
        let titles = ["微信支付", "支付宝支付", "卡密支付"]
        for i in (0..<imgs.count) {
            let dic = ["img": imgs[i], "title": titles[i], "isSelect": false] as [String : Any]
            temps.append(dic)
        }
        return temps
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "余额充值"
    }
    
    override func setupTableView() {
        super.setupTableView()
        // 显示底部视图
        self.view.sendSubview(toBack: self.tableView)
    }
    
    override func setupTableHeaderView() {
        super.setupTableHeaderView()
        
        let hv = CCBalanceRechargeHeaderView.md_viewFromXIB() as! CCBalanceRechargeHeaderView
        hv.autoresizingMask = .flexibleWidth
        tableView.tableHeaderView = hv
    }

}
extension CCBalanceRechargeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "BalanceRechargeCell")
        if let image = dataSources[indexPath.row]["img"] as? String {
            cell.imageView?.image = UIImage(named: image)
        }
        
        if let title = dataSources[indexPath.row]["title"] as? String {
            cell.textLabel?.text = title
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
            cell.textLabel?.textColor = UIColor(rgba: "#222222")
        }
        
        if let isSelect = dataSources[indexPath.row]["isSelect"] as? Bool {
            let btn = UIButton()
            btn.setImage(UIImage(named: "global_btn_select_n"), for: .normal)
            btn.setImage(UIImage(named: "global_btn_select_s"), for: .selected)
            btn.isSelected = isSelect
            btn.sizeToFit()
            cell.accessoryView = btn
        }
        
        cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let isSelect = dataSources[indexPath.row]["isSelect"] as? Bool {
            for i in 0..<dataSources.count {
                dataSources[i]["isSelect"] = false
            }
            dataSources[indexPath.row]["isSelect"] = !isSelect
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "支付方式"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

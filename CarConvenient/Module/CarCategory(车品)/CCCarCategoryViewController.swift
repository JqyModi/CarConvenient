//
//  CCCarCategoryViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCCarCategoryViewController: BaseTableViewController {

    lazy var dataSources: [[String: String]] = {
        let dic1 = ["title": "拼团专区", "subTitle": "品牌轮胎     优选好货", "bgImage": "img_group_purchase"]
        let dic2 = ["title": "砍价专区", "subTitle": "品质保障     买的放心", "bgImage": "img_bargain"]
        let dic3 = ["title": "秒杀专区", "subTitle": "品牌轮胎     优选好货", "bgImage": "img_seckill"]
        let dic4 = ["title": "特价专区", "subTitle": "品牌轮胎     优选好货", "bgImage": "img_special_offer"]
        return [dic1, dic2, dic3, dic4]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 添加左右按钮
//        addLeftItem(title: "", imageName: "btn_my_n", fontColor: Color.md_NavBarTintColor)
//        addRightItem(title: "", imageName: "btn_system_n", fontColor: Color.md_NavBarTintColor)
    
    }
    
    override func setupTableView() {
        super.setupTableView()
        
    }

    override func setupTableHeaderView() {
        super.setupTableHeaderView()
        
        let hv = CCCarCategoryHeaderView.md_viewFromXIB() as! CCCarCategoryHeaderView
        hv.autoresizingMask = .flexibleWidth
        hv.delegate = self
        tableView.tableHeaderView = hv
        
    }
    
    
    
}
extension CCCarCategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.identifier) as! UITableViewCell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
        self.updateCell(dic: dataSources[indexPath.row], cell: cell)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (100/375)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = CCGroupBuyingViewController.init(nibName: "CCGroupBuyingViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
            let vc = CCBargainViewController.init(nibName: "CCBargainViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func updateCell(dic: [String: String], cell: UITableViewCell) {
        if let title = dic["title"] {
            cell.textLabel?.text = title
            cell.textLabel?.font = UIFont(name: "FZHZGBJW--GB1-0", size: 17)
            cell.textLabel?.textColor = UIColor(rgba: "#FFFFFF")
        }
        if let sTitle = dic["subTitle"] {
            cell.detailTextLabel?.text = sTitle
            cell.detailTextLabel?.font = UIFont(name: "PingFang-SC-Medium", size: 12)
            cell.detailTextLabel?.textColor = UIColor(rgba: "#FFFFFF")
        }
        if let bgImg = dic["bgImage"] {
            cell.backgroundView = UIImageView(image: UIImage(named: bgImg))
            cell.backgroundView?.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
            })
//            cell.selectedBackgroundView = UIImageView(image: UIImage(named: bgImg))
        }
        
    }
}
extension CCCarCategoryViewController: CCCarCategoryHeaderViewDelegate {
    func itemDidSelect(index: Int) {
        let vc = CCCarTypeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

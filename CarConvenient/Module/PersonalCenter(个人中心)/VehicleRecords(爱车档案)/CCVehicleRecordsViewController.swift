//
//  CCOwnersCertificationViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/14.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCVehicleRecordsViewController: BaseTableViewController {

    private lazy var dataSources: [[String: Any]] = {
        var temps = [[String: Any]]()
        let titles1 = ["品牌", "型号", "车座", "购买时间", "行驶公里", "车牌", "车架号", "发动机号"]
        let placeholders1 = ["请选择品牌", "请选择型号", "请选择车座", "请选择购买时间", "请输入行驶公里", "请输入车牌", "请输入车架号", "请输入发动机号"]
        let type1 = ["btn", "btn", "btn", "btn", "tf", "tf", "tf", "tf"]
        var items1 = [[String: String]]()
        for i in 0..<titles1.count {
            let dic = ["title": titles1[i], "placeholder": placeholders1[i], "value": "", "type": type1[i]]
            items1.append(dic)
        }
        let titles2 = ["保险公司", "到期日", "车主名", "身份证", "投保城市", "是否一年内过户"]
        let placeholders2 = ["请输入保险公司", "请输入到期日", "请输入车主名", "请输入身份证号", "请选择投保城市", ""]
        let type2 = ["tf", "tf", "tf", "tf", "btn", "twobtn"]
        var items2 = [[String: String]]()
        for i in 0..<titles2.count {
            let dic = ["title": titles2[i], "placeholder": placeholders2[i], "value": "", "type": type2[i]]
            items2.append(dic)
        }
        temps.append(["items": items1, "section": "车辆信息"])
        temps.append(["items": items2, "section": "保险信息"])
        return temps
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "爱车档案"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCVehicleRecordsTableViewCell"
        self.identifier = "CCVehicleRecordsTypeOneBtnTableViewCell"
        self.identifier = "CCVehicleRecordsTypeTwoBtnTableViewCell"
        
        tableView.separatorStyle = .singleLine
        
        // 显示底部视图
        self.view.sendSubview(toBack: self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(40/375)))
        }
    }
    
    override func setupTableHeaderView() {
        super.setupTableHeaderView()
        
        let hv = CCVehicleRecordsHeaderView.md_viewFromXIB() as! CCVehicleRecordsHeaderView
        hv.autoresizingMask = .flexibleWidth
        tableView.tableHeaderView = hv
    }
    
    override func setupTableFooterView() {
        super.setupTableFooterView()
        let fv = CCVehicleRecordsFooterView.md_viewFromXIB() as! CCVehicleRecordsFooterView
        fv.autoresizingMask = .flexibleWidth
        tableView.tableFooterView = fv
    }
    
}
extension CCVehicleRecordsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = dataSources[section]["items"] as? [[String: String]] {
            return items.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let items = dataSources[indexPath.section]["items"] as? [[String: String]] {
            if let type = items[indexPath.row]["type"], let title = items[indexPath.row]["title"] {
                switch type {
                case "btn":
                    cell = tableView.dequeueReusableCell(withIdentifier: "CCVehicleRecordsTypeOneBtnTableViewCell") as! CCVehicleRecordsTypeOneBtnTableViewCell
                    (cell as! CCVehicleRecordsTypeOneBtnTableViewCell).updateCell(model: items[indexPath.row])
                    (cell as! CCVehicleRecordsTypeOneBtnTableViewCell).clickBlock = {(sender) in
                        if let btn = sender as? UIButton {
                            switch title {
                            case "品牌":
                                break
                            case "型号":
                                break
                            case "车座":
                                break
                            case "购买时间":
                                break
                            case "投保城市":
                                let vc = MCSelectLocalController()
                                self.navigationController?.pushViewController(vc, animated: true)
                                break
                            default:
                                break
                            }
                        }
                    }
                    break
                case "tf":
                    cell = tableView.dequeueReusableCell(withIdentifier: "CCVehicleRecordsTableViewCell") as! CCVehicleRecordsTableViewCell
                    (cell as! CCVehicleRecordsTableViewCell).updateCell(model: items[indexPath.row])
                    break
                case "twobtn":
                    cell = tableView.dequeueReusableCell(withIdentifier: "CCVehicleRecordsTypeTwoBtnTableViewCell") as! CCVehicleRecordsTypeTwoBtnTableViewCell
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
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let section = dataSources[section]["section"] as? String {
            return section
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let section = dataSources[section]["section"] as? String {
            let label = UILabel(title: section, size: 14, color: UIColor(rgba: "#1B82D2"))
            label.textAlignment = .left
            let v = UIView(frame: CGRect(origin: .zero, size: CGSize(width: tableView.width, height: 44)))
            v.backgroundColor = UIColor.white
            v.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.centerY.equalTo(v.snp.centerY)
                make.left.equalTo(v.snp.left).offset(8)
                make.right.equalTo(v.snp.right).offset(-8)
            }
            return v
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
}

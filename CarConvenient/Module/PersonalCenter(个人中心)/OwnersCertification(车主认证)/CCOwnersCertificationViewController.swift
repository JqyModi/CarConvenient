//
//  CCOwnersCertificationViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/14.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCOwnersCertificationViewController: BaseTableViewController {

    private lazy var dataSources: [[String: String]] = {
        var temps = [[String: String]]()
        let titles = ["姓名", "性别", "年龄", "职业", "兴趣爱好（选填）"]
        let placeholders = ["请输入姓名", "请输入性别", "请输入年龄", "请输入职业", "请输入兴趣爱好"]
        for i in 0..<titles.count {
            let dic = ["title": titles[i], "placeholder": placeholders[i], "value": ""]
            temps.append(dic)
        }
        return temps
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "车主认证"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCOwnersCertificationTableViewCell"
        // 显示底部视图
        self.view.sendSubview(toBack: self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(40/375)))
        }
    }
    
    override func setupTableHeaderView() {
        super.setupTableHeaderView()
        
        let hv = CCOwnersCertificationHeaderView.md_viewFromXIB() as! CCOwnersCertificationHeaderView
        hv.autoresizingMask = .flexibleWidth
        tableView.tableHeaderView = hv
    }
    
    override func setupTableFooterView() {
        super.setupTableFooterView()
        let fv = CCOwnersCertificationFooterView.md_viewFromXIB() as! CCOwnersCertificationFooterView
        fv.autoresizingMask = .flexibleWidth
        tableView.tableFooterView = fv
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        let vc = CCVehicleRecordsViewController.init(nibName: "CCVehicleRecordsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension CCOwnersCertificationViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCOwnersCertificationTableViewCell
        
        cell.updateCell(model: dataSources[indexPath.row])
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}

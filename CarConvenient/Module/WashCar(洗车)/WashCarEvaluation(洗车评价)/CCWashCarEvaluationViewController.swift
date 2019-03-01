//
//  CCEvaluationViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/28.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCWashCarEvaluationViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "评价"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCWashCarTableViewCell"
        tableView.rowHeight = 93
        
        // 显示底部视图
        self.view.sendSubview(toBack: self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(40/375)))
        }
        
    }
    
    override func setupTableFooterView() {
        super.setupTableFooterView()
        
        let fv = CCWashCarEvaluationFooterView.md_viewFromXIB() as! CCWashCarEvaluationFooterView
        fv.autoresizingMask = .flexibleWidth
        tableView.tableFooterView = fv
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        let pv = CCWelfarePopView.md_viewFromXIB(cornerRadius: 5) as! CCWelfarePopView
        pv.autoresizingMask = .flexibleWidth
        HFAlertController.showCustomView(view: pv)
    }
    
}
extension CCWashCarEvaluationViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCWashCarTableViewCell
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}


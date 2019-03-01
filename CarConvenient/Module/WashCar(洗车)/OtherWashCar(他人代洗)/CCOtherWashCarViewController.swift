//
//  CCOtherWashCarViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/20.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCOtherWashCarViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCOtherWashCarTableViewCell"
        tableView.rowHeight = 93
        
        // 显示底部视图
        self.view.sendSubview(toBack: self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(40/375)))
        }
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        let pv = CCReleaseNotesView.md_viewFromXIB(cornerRadius: 5) as! CCReleaseNotesView
        pv.autoresizingMask = .flexibleWidth
        pv.clickBlock = {(sender) in
            if let btn = sender as? UIButton {
                if let sv = pv.superview {
                    sv.removeFromSuperview()
                }
                let vc = CCPushSuccessViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        HFAlertController.showCustomView(view: pv)
    }
    
}
extension CCOtherWashCarViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCOtherWashCarTableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CCWashCarEvaluationViewController.init(nibName: "CCWashCarEvaluationViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

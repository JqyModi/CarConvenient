//
//  CCHandWashCarViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/20.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCHandWashCarViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCHandWashCarTableViewCell"
        tableView.rowHeight = 93
    }
    
}
extension CCHandWashCarViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCHandWashCarTableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pv = CCHandWashCarPopView.md_viewFromXIB() as! CCHandWashCarPopView
        pv.autoresizingMask = .flexibleWidth
        pv.frame = CGRect(origin: .zero, size: CGSize(width: pv.width, height: pv.height + SaveAreaHeight))
        HFAlertController.showCustomView(view: pv, type: HFAlertType.ActionSheet)
        
        pv.clickBlock = {(sender) in
            if let btn = sender as? UIButton {
                if let sv = pv.superview {
                    sv.removeFromSuperview()
                }
                let vc = CCWashCarBillingViewController.init(nibName: "CCWashCarBillingViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

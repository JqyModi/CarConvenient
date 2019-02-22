//
//  CCInvoiceViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCInvoiceViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "发票助手"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCInvoiceTableViewCell"
        tableView.backgroundColor = UIColor.white
    }
    
    override func setupTableFooterView() {
        super.setupTableFooterView()
        
        let fv = CCInvoiceFooterView.md_viewFromXIB() as! CCInvoiceFooterView
        fv.autoresizingMask = .flexibleWidth
        tableView.tableFooterView = fv
        
        fv.clickBlock = {(sender) in
            if let btn = sender as? UIButton {
                let vc = CCAddInvoiceViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}
extension CCInvoiceViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCInvoiceTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (80/375)
    }
}

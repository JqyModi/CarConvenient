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

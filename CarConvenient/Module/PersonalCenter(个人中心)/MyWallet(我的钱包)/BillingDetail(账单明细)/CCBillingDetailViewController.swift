//
//  CCBillingDetailViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/12.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCBillingDetailViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCBillingDetailTableViewCell"
    }
    
    
}
extension CCBillingDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCBillingDetailTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

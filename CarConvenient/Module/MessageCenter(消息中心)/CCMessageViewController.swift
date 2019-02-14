//
//  CCMessageViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/14.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCMessageViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "消息中心"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCMessageTableViewCell"
        
        tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
}
extension CCMessageViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCMessageTableViewCell
        
        cell.selectionStyle = .none
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 92
//    }

}

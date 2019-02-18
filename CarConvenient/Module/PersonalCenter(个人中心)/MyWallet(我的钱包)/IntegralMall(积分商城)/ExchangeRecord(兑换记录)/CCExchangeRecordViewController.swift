//
//  CCExchangeRecordViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/15.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCExchangeRecordViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "兑换记录"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCExchangeRecordTableViewCell"
        
    }
    
}
extension CCExchangeRecordViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCExchangeRecordTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (133/375)
    }
}

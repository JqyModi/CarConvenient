//
//  CCCouponsViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCCouponsViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "我的优惠券"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCCouponsTableViewCell"
        
    }
    
}
extension CCCouponsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCCouponsTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (82/375)
    }
}

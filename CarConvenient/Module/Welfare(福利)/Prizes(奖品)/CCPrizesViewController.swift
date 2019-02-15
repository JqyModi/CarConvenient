//
//  CCCouponsViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCPrizesViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "奖品列表"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCPrizesTableViewCell"
        
    }
    
}
extension CCPrizesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCPrizesTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (85/375)
    }
}

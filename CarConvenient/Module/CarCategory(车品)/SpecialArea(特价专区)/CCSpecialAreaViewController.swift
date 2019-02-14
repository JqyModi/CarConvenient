//
//  CCSpecialAreaViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/11.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCSpecialAreaViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "特价专区"
    }

    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCSpecialAreaTableViewCell"
    }
    
}
extension CCSpecialAreaViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CCSpecialAreaTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCSpecialAreaTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (113/375)
    }
}

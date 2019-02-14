//
//  CCSpikeViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/28.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCSpikeViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "秒杀专区"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCSpikeTableViewCell"
        
    }
    
    

}
extension CCSpikeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CCSpikeTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.identifier) as! CCSpikeTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (123/375)
    }
}

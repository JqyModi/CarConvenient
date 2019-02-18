//
//  CCMyTeamViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/15.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCMyTeamViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCMyTeamTableViewCell"
        
    }
    
}
extension CCMyTeamViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCMyTeamTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (70/375)
    }
}

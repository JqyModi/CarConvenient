//
//  CCRidersClubViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/18.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCRidersClubViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCRidersClubTableViewCell"
        tableView.rowHeight = 100
    }
    
}
extension CCRidersClubViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCRidersClubTableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CCRidersClubDetailViewController.init(nibName: "CCRidersClubDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

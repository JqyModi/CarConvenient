//
//  CCWashCarViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCWashCarViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCWashCarTableViewCell"
        tableView.rowHeight = 93
    }
    
}
extension CCWashCarViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCWashCarTableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CCRidersClubDetailViewController.init(nibName: "CCRidersClubDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

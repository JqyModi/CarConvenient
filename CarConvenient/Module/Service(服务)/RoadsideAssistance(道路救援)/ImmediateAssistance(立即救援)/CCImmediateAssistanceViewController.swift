//
//  CCImmediateAssistanceViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/25.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCImmediateAssistanceViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupStyle() {
        super.setupStyle()
        title = "立即救援"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCImmediateAssistanceTableViewCell"
    }
    
    override func setupTableFooterView() {
        super.setupTableFooterView()
        
        view.sendSubview(toBack: tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(47/375)))
        }
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        switch sender.tag {
        case 10001:
            
            break
        case 10002:
            
            break
        default:
            break
        }
    }
    
}
extension CCImmediateAssistanceViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCImmediateAssistanceTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (34/375)
    }
}

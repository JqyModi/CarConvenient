//
//  CCBargainViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/28.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCBargainViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupStyle() {
        super.setupStyle()
        title = "砍价专区"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCBargainTableViewCell"
    }
    
    override func setupTableFooterView() {
        super.setupTableFooterView()
        
//        let fv = CCBargainFooterView.md_viewFromXIB() as! CCBargainFooterView
//        fv.autoresizingMask = .flexibleWidth
//        self.view.addSubview(fv)
//
//        let saveAreaHeight = IPONEX ? BottomSaveAreaHeight : 0
//        let height = SCREEN_WIDTH*(50/375)+saveAreaHeight
//        fv.snp.makeConstraints { (make) in
//            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(height)
//        }
//
//        tableView.snp.makeConstraints{ (make) in
//            make.height.equalTo(tableView.height-height)
//        }
        
        view.sendSubview(toBack: tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(50/375)))
        }
    }

}
extension CCBargainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCBargainTableViewCell
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (123/375)
    }
}

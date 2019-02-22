//
//  CCGoodsViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/21.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCGoodsViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "商品详情"
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        addRightItem(title: "", imageName: "btn_store_share(1)")
    }
    
    override func clickRight(sender: UIButton) {
        super.clickRight(sender: sender)
        
    }

    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "CCGoodsTableViewCell"
    }
    
    override func setupTableHeaderView() {
        super.setupTableHeaderView()
        
        let hv = CCGoodsHeaderView.md_viewFromXIB() as! CCGoodsHeaderView
        hv.autoresizingMask = .flexibleWidth
        tableView.tableHeaderView = hv
        
        hv.clickBlock = {(sender) in
            if let btn = sender as? UIButton {
                let pv = CCServicePopView.md_viewFromXIB() as! CCServicePopView
                pv.autoresizingMask = .flexibleWidth
                HFAlertController.showCustomView(view: pv, type: HFAlertType.ActionSheet)
            }
        }
    }
    
    override func setupTableFooterView() {
        super.setupTableFooterView()
        
        let fv = CCGoodsFooterView.md_viewFromXIB() as! CCGoodsFooterView
        fv.autoresizingMask = .flexibleWidth
        tableView.tableFooterView = fv
        
        view.sendSubview(toBack: tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(49/375)))
        }
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        switch sender.tag {
        case 10001:
            
            break
        case 10002:
            let pv = CCBuyingPopView.md_viewFromXIB() as! CCBuyingPopView
            pv.autoresizingMask = .flexibleWidth
            pv.frame = CGRect(origin: .zero, size: CGSize(width: pv.width, height: pv.height+SaveAreaHeight))
            HFAlertController.showCustomView(view: pv, type: HFAlertType.ActionSheet)
            break
        case 10002:
            
            break
        default:
            break
        }
    }
    
}
extension CCGoodsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCGoodsTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH * (49/375)
    }
}


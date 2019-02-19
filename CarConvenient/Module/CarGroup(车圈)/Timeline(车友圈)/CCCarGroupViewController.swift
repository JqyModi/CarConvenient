//
//  CCCarGroupViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCCarGroupViewController: BaseTableViewController {

    let models = TimelineModel.models()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 将另外两个view添加到导航栏
        let clubvc = CCRidersClubOutSideViewController()
        self.navigationController?.viewControllers.append(clubvc)
        let agvc = CCActivityGroupViewController()
        self.navigationController?.viewControllers.append(agvc)
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        self.identifier = "TableViewCell"
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        let nav = CCCarGroupNavView.md_viewFromXIB() as! CCCarGroupNavView
        nav.autoresizingMask = .flexibleWidth
//        self.navigationController?.navigationItem.titleView = nav
        self.navigationItem.titleView = nav
        
        nav.clickBlock = {(sender) in
            if let sgm = sender as? UISegmentedControl {
                if sgm.selectedSegmentIndex == 1 {
                    
                }
            }
        }
    }
    
    override func setupTableHeaderView() {
        super.setupTableHeaderView()
        let hv = CCCarGroupHeaderView.md_viewFromXIB() as! CCCarGroupHeaderView
        hv.autoresizingMask = .flexibleWidth
        tableView.tableHeaderView = hv
    }
    
}
extension CCCarGroupViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! TableViewCell
        cell.updateData(model: models[indexPath.row])
        cell.selectionStyle = .none
        
        // 点击事件
        cell.clickBlock = {(sender) in
            if let btn = sender as? UIButton {
                switch btn.tag {
                case 10001:
                    break
                case 10002:
                    break
                case 10003:
                    let bv = CCCommmentView.md_viewFromXIB() as! CCCommmentView
                    bv.frame = CGRect(x: 0, y: 0, width: bv.width, height: bv.height+BottomSaveAreaHeight)
                    bv.xib_inputDesc.becomeFirstResponder()
                    HFAlertController.showCustomView(view: bv, type: HFAlertType.ActionSheet)
                    
                    bv.clickBlock = {(sender) in
                        if let txt = bv.xib_inputDesc.text {
                            let user = self.models[indexPath.row].name
                            let touser = ""
                            let content = txt
                            let dict = ["user": user, "touser": touser, "content": content]
                            self.models[indexPath.row].commentModels.append(dict)
                            self.models[indexPath.row].commentViewHeight = TimelineModel.heightForCommentView(comments: self.models[indexPath.row].commentModels, maxWidth: SCREEN_WIDTH-63)
                            
                            // 刷新评论tableView
                            cell.tableView.reloadData()
                            // 刷新当前tableView
                            tableView.reloadData()
                            bv.xib_inputDesc.resignFirstResponder()
                        }
                    }
                    
                    // 监听键盘改变事件
                    NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: nil) { (notify) in
                        // 改变view的高度
                        let keyBY = (notify.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! CGRect).origin.y
                        let y = keyBY - SCREEN_HEIGHT - bv.height
                        bv.top = SCREEN_HEIGHT + y
                    }
                    break
                default:
                    break
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 根据模型计算出当前Cell的高度
        return models[indexPath.row].rowHeight
    }
}

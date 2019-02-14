//
//  CCUserSettingViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCUserSettingViewController: BaseTableViewController {

    private static let plistPathName = "/usersetting.plist"
    
    var plistName: String = "usersetting" {
        didSet {
            initData()
        }
    }
    
    var groups: NSArray = NSArray()
    
    private func initData() {
        var arr = NSArray()
        let path = Bundle.main.path(forResource: self.plistName, ofType: "plist")
        arr = NSArray(contentsOfFile: path!)!
        debugPrint("arr --> \(arr)")
        self.groups = arr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        tableView.separatorStyle = .singleLine
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (groups.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //获取组
        let group = groups.object(at: section) as! NSDictionary
        let item = group["items"] as! NSArray
        return (item.count)
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //获取组
        let group = groups.object(at: indexPath.section) as! NSDictionary
        let item = group["items"] as! NSArray
        let cellInfo = item[indexPath.row] as! NSDictionary
        let cell = MDSettingTableViewCell.cellForItem(tableView: tableView, item: cellInfo)
        //设置数据
        cell.cellInfo = cellInfo
        //        cell.backgroundColor = UIColor.md_cellBackgroundColor
        
        if indexPath.section == 0 && indexPath.row == 0 { // 头像设置
            let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 55, height: 35)))
//            view.backgroundColor = UIColor.purple
            let iv = UIImageView(image: UIImage(named: "img_head_n"))
            view.addSubview(iv)
            let iv1 = UIImageView(image: UIImage(named: "global_btn_right_n"))
            iv1.sizeToFit()
            view.addSubview(iv1)
            
            iv1.snp.makeConstraints { (make) in
                make.centerY.equalTo(iv.snp.centerY)
                make.left.equalTo(iv.snp.right).offset(13)
                make.right.equalToSuperview()
                make.width.equalTo(iv1.snp.width)
                make.height.equalTo(iv1.snp.height)
            }
            iv.snp.makeConstraints { (make) in
                make.left.top.bottom.equalToSuperview()
                make.width.height.equalTo(34)
                make.right.equalTo(iv1.snp.left)
            }
            cell.accessoryView = view
        }
        cell.selectionStyle = .none
        return cell
    }
    
    //处理点击事件
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //获取组
        let group = groups.object(at: indexPath.section) as! NSDictionary
        let item = group["items"] as! NSArray
        let cellInfo = item[indexPath.row] as! NSDictionary
        
        //判断targetVC   targetVC
        if let targetType = cellInfo["targetVC"] as? String {
            let vc = getVCByClassString(targetType)
            //判断是否是相同模板的设置界面跳转
            if (vc?.isKind(of: MDSettingController.self))! {
                let targetPlist = cellInfo["targetPlist"] as? String
                let targetVC = vc as! MDSettingController
                targetVC.plistName = targetPlist!
            }
            
            //设置控制器属性
            let title = cellInfo["title"] as? String
            vc?.title = title
            //跳转控制器
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
        //判断plist中是否配置有funcKey参数：有就执行方法
        if let funcKey = cellInfo["funcKey"] as? String {
            //将字符串转为一个可执行方法
            let sel = NSSelectorFromString(funcKey)
            //执行配置的方法
            self.perform(sel)
        }
        
        if let switcher = cellInfo["accessoryType"] as? String, switcher == "UISwitch" {
            if indexPath.row == 0 {
                if let sw = tableView.cellForRow(at: indexPath)?.accessoryView as? UISwitch, !sw.isOn {
                    // 隐藏另外的按钮
                    let tempItems = item
                    if var tms = tempItems as? [[String: Any]], tms.count == 5 {
                        tms.remove(at: 1)
                        tms.remove(at: 1)
                        let mutDics = NSMutableDictionary.init(dictionary: (groups[indexPath.section] as! NSDictionary))
                        mutDics.setValue(tms, forKey: "items")
                        let mutGroups = NSMutableArray.init(array: groups)
                        mutGroups[indexPath.section] = mutDics
                        groups = mutGroups
                        tableView.reloadData()
                    }else {
                        
                    }
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height: CGFloat = 0
        if section != 0 {
            height = 44
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //获取组
        var title = ""
        let group = groups.object(at: section) as! NSDictionary
        if let t = group["header"] as? String {
            title = t
        }
        return title
    }
    
}

//MARK: -- 根据类文件字符串转换为ViewController：自定义的类需要重写初始化方法：init否则报空nil
extension CCUserSettingViewController {
    /// 类文件字符串转换为ViewController
    /// - Parameter childControllerName: VC的字符串
    /// - Returns: ViewController
    func getVCByClassString(_ childControllerName: String) -> UIViewController?{
        
        // 1.获取命名空间
        // 通过字典的键来取值,如果键名不存在,那么取出来的值有可能就为没值.所以通过字典取出的值的类型为AnyObject?
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            print("命名空间不存在")
            return nil
        }
        // 2.通过命名空间和类名转换成类
        let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + childControllerName)
        debugPrint(clsName)
        // swift 中通过Class创建一个对象,必须告诉系统Class的类型
        guard let clsType = cls as? UIViewController.Type else {
            print("无法转换成UIViewController")
            return nil
        }
        // 3.通过Class创建对象
        let childController = clsType.init()
        
        return childController
    }
}
// MARK: - 点击事件
extension CCUserSettingViewController {
    
    /// 头像
    @objc func avatar() {
        
    }
    /// 昵称
    @objc func nickname() {
        
    }
    /// 性别
    @objc func sex() {
        
    }
    /// 生日信息
    @objc func birthday() {
        
    }
    
    /// QQ
    @objc func QQ() {
        
    }
    /// 微信
    @objc func wechat() {
        
    }
    /// 支付宝
    @objc func alipay() {
        
    }
    /// 微博
    @objc func weibo() {
        
    }
    /// 收货地址
    @objc func address() {
        let vc = CCManagerAddressViewController.init(nibName: "CCManagerAddressViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 支付密码
    @objc func payPassword() {
        
    }
    /// 登录密码
    @objc func loginPassword() {
        
    }
    /// 手势密码
    @objc func gesturesPassword() {
        
    }
}

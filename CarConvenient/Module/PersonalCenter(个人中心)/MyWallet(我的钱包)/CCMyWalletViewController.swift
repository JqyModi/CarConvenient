//
//  CCMyWalletViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/11.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCMyWalletViewController: BaseTableViewController {

    private static let plistPathName = "/userinfo.plist"
    
    var plistName: String = "myWallet" {
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
        title = "我的钱包"
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        tableView.separatorStyle = .singleLine
    }
    
    override func setupTableHeaderView() {
        super.setupTableHeaderView()
        
        let pv = CCMyWalletHeaderView.md_viewFromXIB() as! CCMyWalletHeaderView
        pv.autoresizingMask = .flexibleWidth
        tableView.tableHeaderView = pv
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
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}

//MARK: -- 根据类文件字符串转换为ViewController：自定义的类需要重写初始化方法：init否则报空nil
extension CCMyWalletViewController {
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
extension CCMyWalletViewController {
    
    /// 充值
    @objc func recharge() {
        let vc = CCBalanceRechargeViewController.init(nibName: "CCBalanceRechargeViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 积分
    @objc func integral() {
        let vc = CCIntegralMallViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 账单
    @objc func billing() {
        let vc = CCBillingDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 返利
    @objc func rebate() {
        
    }
}

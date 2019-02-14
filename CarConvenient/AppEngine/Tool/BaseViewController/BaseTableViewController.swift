//
//  BaseTableViewController.swift
//  LT
//
//  Created by Modi on 2018/6/22.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh

protocol BaseTableViewDelegate: class {
    func setupTableView()
}

class BaseTableViewController: BaseViewController {
    
    // MARK: - TableView
    lazy var tableView : UITableView  = {
        let tv = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.separatorStyle = UITableViewCellSeparatorStyle.none
        return tv
    }()
    
    override func loadView() {
        
        super.loadView()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
            make.bottom.equalTo(self.view.safeArea.bottom)
        }
    }
    
    open var identifier: String = "UITableViewCell" {
        didSet {
            if let _ = Bundle.main.path(forResource: identifier, ofType: "nib") {
                let nib = UINib(nibName: identifier, bundle: nil)
                tableView.register(nib, forCellReuseIdentifier: identifier)
            }else {
                if let cls = NSClassFromString(identifier) {
                    tableView.register(cls, forCellReuseIdentifier: identifier)
                }
            }
        }
    }
    
    open var dataSource: [Any] = Array() {
        didSet{
            if dataSource == nil || dataSource.count == 0 {
                print("无数据///上线前删掉")
                dataSource = ["假数据一","假数据二","假数据三","假数据四","假数据五"]
            }
        }
    }
    
    typealias UpdateCellDataSourceHandler = () -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTableView()
       
    }
    
    open func setupTableView() {
        self.view.backgroundColor = UIColor.white
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        QYTools.refreshData(target: self, scrollView: tableView, refresh: #selector(refreshData), loadMore: #selector(pageTurning))
        
        setupTableHeaderView()
        setupTableFooterView()
        
        setupTableSectionHeaderView()
        setupTableSectionFooterView()
    }
    
    open func setupTableHeaderView() {
        
    }
    
    open func setupTableFooterView() {
        
    }
    
    open func setupTableSectionHeaderView() {
        
    }
    
    open func setupTableSectionFooterView() {
        
    }
    
    /// 刷新数据
    @objc open func refreshData() {}
    
    /// 数据翻页
    @objc open func pageTurning() {}

}
extension BaseTableViewController {
    
}

//MARK:--- UITableViewDelegate , UITableViewDataSource
extension BaseTableViewController: UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell :UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        //      cell.setdata(mode: dataArr[indexPath.row] as! STExchangeMode)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 0
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
}

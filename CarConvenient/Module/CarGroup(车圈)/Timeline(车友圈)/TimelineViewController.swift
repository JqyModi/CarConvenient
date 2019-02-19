//
//  TimelineViewController.swift
//  WechatTimeLineXib
//
//  Created by Modi on 2018/12/1.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

private let withIdentifier = "TableViewCell"

class TimelineViewController: UIViewController {

    let models = TimelineModel.models()
    
    private lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.frame = self.view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: withIdentifier, bundle: nil), forCellReuseIdentifier: withIdentifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
    }

}
extension TimelineViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: withIdentifier) as! TableViewCell
        cell.updateData(model: models[indexPath.row])
        debugPrint("models[indexPath.row].description --------------------------> \(models[indexPath.row].description)")
        cell.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 根据模型计算出当前Cell的高度
        return models[indexPath.row].rowHeight
    }
}

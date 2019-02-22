//
//  CCServicePopView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

private let identifier = "CCServicePopTableViewCell"

class CCServicePopView: BaseView {
    
    private var dataSources: [[String: String]] = {
        var temps = [[String: String]]()
        let titles = ["快送达", "正规发票", "7天无理由退货"]
        let contents = ["全国各大仓库直接发货", "确保开出正规有效发票", "消费者在满足7天无理由退换货申请条件的前提下，可以提出 “七天无理由退换货”的申请（定制商品不参与7天无理由退换 货）"]
        for i in 0..<titles.count {
            let dict = ["title": titles[i], "content": contents[i]]
            temps.append(dict)
        }
        return temps
    }()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            
            tableView.register(UINib(nibName: "CCServicePopTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            tableView.estimatedRowHeight = 73
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
extension CCServicePopView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CCServicePopTableViewCell
        cell.updateCell(model: dataSources[indexPath.row])
        return cell
    }
    
}

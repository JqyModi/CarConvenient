//
//  CCCarTypeViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/27.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit
import SVProgressHUD

class CCCarTypeViewController: BaseViewController {
    
    @IBOutlet weak var catogeryTableView: UITableView!
    @IBOutlet weak var goodsTableView: UITableView!
    
    private var catogeryArray = [String]() {
        didSet {
            catogeryTableView.reloadData()
            goodsTableView.reloadData()
        }
    }
    private var goodsArray = [String]() {
        didSet {
            goodsTableView.reloadData()
        }
    }
    
    private let leftCellId = "CCCarTypeTableViewCell"
    private let rightCellId = "CCCarTypeDetailTableViewCell"
    private let itemHeight = (SCREEN_WIDTH - 100 - 10*4)/2.0 * (9/16) + 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("车品分类", comment: "车品分类")
        catogeryTableView.register(UINib(nibName: leftCellId, bundle: nil), forCellReuseIdentifier: leftCellId)
        goodsTableView.register(UINib(nibName: rightCellId, bundle: nil), forCellReuseIdentifier: rightCellId)
        self.requestData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK:Method
    override func requestData() {
        
    }
    
    private func requesDesData(categoryID:Int){
        
    }
    
}

extension CCCarTypeViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == catogeryTableView {
            return catogeryArray.count
        }else{
            return goodsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == catogeryTableView {
            let cell:CCCarTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: leftCellId) as! CCCarTypeTableViewCell
            return cell
        }else{
            let cell:CCCarTypeDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: rightCellId) as! CCCarTypeDetailTableViewCell
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == catogeryTableView {
            return 40
        }else{
            let model = goodsArray[indexPath.row]
            let count = 5
            let row = (count/2) + ((count%2>0) ? 1 : 0)
            return CGFloat(row) * itemHeight + 40 + Margin.md_ItemMargin
        }
    }
}

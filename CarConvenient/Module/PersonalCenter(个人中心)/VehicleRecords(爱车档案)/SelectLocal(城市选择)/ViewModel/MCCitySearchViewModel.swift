//
//  MCCitySearchViewModel.swift
//  CarTireShopMall
//
//  Created by 毛诚 on 2018/12/11.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit

@objc protocol MCCitySearchViewModelDelegate : NSObjectProtocol{
    
    func searchCellClickAction(cityName:String)
    
}


class MCCitySearchViewModel: NSObject {
    
    weak open var delegate:MCCitySearchViewModelDelegate?
    
    fileprivate lazy var cityListArray = [MCLocalCityModel]()
    
    //    MARK:注册
    func registerTableView(tableView:UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
//        tableView.register(MCSelectLocalHeader.self, forHeaderFooterViewReuseIdentifier: "MCSelectLocalHeader")
//        tableView.register(MCLocalCityGroup.self, forHeaderFooterViewReuseIdentifier: "MCLocalCityGroup")
        
    }

    //    MARK:获取数据
    func getCityData(data:[MCLocalCityModel],completion:@escaping(() ->())) {
        if data.count <= 0 {
        }else {
            cityListArray.removeAll()
            cityListArray = data
            completion()
        }
    }
    
    
}

extension MCCitySearchViewModel:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        
        if indexPath.row < cityListArray.count {
            
            cell.textLabel?.text = cityListArray[indexPath.row].cityName
            cell.textLabel?.textColor = UIColor(rgba: "#333333")
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < cityListArray.count {
           delegate?.searchCellClickAction(cityName: cityListArray[indexPath.row].cityName ?? "")
        }
    }
    
    
}


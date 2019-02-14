//
//  MCSelectLocalViewModel.swift
//  CarTireShopMall
//
//  Created by 毛诚 on 2018/10/29.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit


@objc protocol MCSelectLocalViewModelDelegate : NSObjectProtocol{
    
    
    func cellClickAction(cityName:String)
    
    
}


class MCSelectLocalViewModel: NSObject {
    
    weak open var delegate:MCSelectLocalViewModelDelegate?
    
    fileprivate lazy var hotCityArray = [MCLocalHotCityModel]()
    fileprivate lazy var allCityArray = [MCLocalCityArrayModel]()
    fileprivate lazy var titleArray = [String]()
    
    //定位的地址
    fileprivate var locationCity:String?
    
    //    MARK:注册
    func registerTableView(tableView:UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(MCSelectLocalHeader.self, forHeaderFooterViewReuseIdentifier: "MCSelectLocalHeader")
        tableView.register(MCLocalCityGroup.self, forHeaderFooterViewReuseIdentifier: "MCLocalCityGroup")
        
    }
    
    //    MARK:获取数据
    func getHotCityData(hotCityData:[MCLocalHotCityModel],completion:@escaping(() ->())) {
        if hotCityData.count <= 0 {
        }else {
            hotCityArray.removeAll()
            hotCityArray = hotCityData
            completion()
        }
    }
    
    func getAllCityData(allCityData:[MCLocalCityArrayModel],completion:@escaping(() ->())) {
        if allCityData.count <= 0 {
        }else {
            allCityArray.removeAll()
            titleArray.removeAll()
            allCityArray = allCityData
            
            for item in allCityArray {
                titleArray.append(item.letterStr ?? "")
            }
            completion()
        }
    }
//    /定位信息
    func getLocationStr(locationStr:String,completion:@escaping(() ->())) {
        if locationStr.count <= 0 {
        }else {
            locationCity = locationStr
            completion()
        }
    }

}
extension MCSelectLocalViewModel:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return allCityArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 0
        }else {
            if section - 1 < allCityArray.count {
                let tempM = allCityArray[section - 1]
                guard let tempModel = tempM.Citys else {return 10}
                return tempModel.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.textColor = UIColor(rgba: "#666666")
            cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
            cell.textLabel?.textAlignment = .left
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.selectionStyle = .none
            
            if indexPath.section - 1 < allCityArray.count {
                let tempM = allCityArray[indexPath.section - 1]
                let tempArray = tempM.Citys ?? [MCLocalCityModel]()
                
                let model = tempArray[indexPath.row]
                cell.textLabel?.text = model.cityName
                cell.textLabel?.textColor = UIColor(rgba: "#333333")
                cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
                return cell
            }
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MCSelectLocalHeader") as? MCSelectLocalHeader
            headerView?.hotCityData = hotCityArray
            headerView?.locationCityStr = locationCity
            headerView?.delegate = self
            return headerView
        }else {
            
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MCLocalCityGroup") as? MCLocalCityGroup
            
            if section - 1 < allCityArray.count {
                let tempModel = allCityArray[section - 1]
                headerView?.headerModel = tempModel
                return headerView
            }
            return headerView
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //计算高度
        
        if section == 0 {
            return 95 + CGFloat(hotCityArray.count / 4 + 1) * (45) + 20
        }else {
            if is_iPhonex {
                return 60
            }else {
                return 40
            }
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view:UIView = UIView()
        view.backgroundColor = Color.appBackgroundColor
        view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 1)
        return view
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    
    
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        return index + 1
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        //        return ["A","B","C","D","E","F","G","H","J","K","L","M",
        //                "N","P","Q","R","S","T","W","X","Y","Z"]
        
        
        return titleArray
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section - 1 < allCityArray.count {
            guard let tempArray = allCityArray[indexPath.section - 1].Citys else {return}
            if indexPath.row < tempArray.count {
                let model = tempArray[indexPath.row]
                delegate?.cellClickAction(cityName: model.cityName ?? "")
            }
        }
    }
    
    
}

extension MCSelectLocalViewModel:MCSelectLocalHeaderDelegate {
    func clickHotCityAction(cityName: String) {
        delegate?.cellClickAction(cityName: cityName )
    }
    
    
    
}

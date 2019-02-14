//
//  MCLocalRequest.swift
//  InternetOfProfit
//
//  Created by 毛诚 on 2018/9/3.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit

class MCLocalRequest: NSObject {
    
    /***************假数据********************/
    
    fileprivate lazy var hotCityArray = [MCLocalHotCityModel]()
    fileprivate lazy var cityArray = [MCLocalCityArrayModel]()

    ///所有城市数据
    fileprivate lazy var allCityList = [MCLocalCityModel]()
    
    
    private let hotCityData:Array = [
        ["cityNameStr":"广州"],["cityNameStr":"深圳"],["cityNameStr":"上海"],
        ["cityNameStr":"长沙"],["cityNameStr":"杭州"],["cityNameStr":"成都"],
        ["cityNameStr":"西安"],["cityNameStr":"北京"],["cityNameStr":"重庆"],
        ["cityNameStr":"厦门"],["cityNameStr":"长沙"],["cityNameStr":"杭州"],["cityNameStr":"成都"],["cityNameStr":"西安"]
    ]
    
    func getHotCityData() -> [MCLocalHotCityModel] {
        hotCityArray.removeAll()
        for item in hotCityData {
            let tempM = MCLocalHotCityModel(JSON: item)
            guard let tempModel = tempM else {continue}
            hotCityArray.append(tempModel)
        }
        return hotCityArray
    }
    
    func getCityData() -> [MCLocalCityArrayModel] {
        cityArray.removeAll()
        
        let path = Bundle.main.path(forResource: "citydict", ofType: "plist")
        
        guard let tempStr = path else { return [MCLocalCityArrayModel]()}
        
        let tempArr = NSArray(contentsOfFile: tempStr)
        
        guard let tempArray = tempArr else { return [MCLocalCityArrayModel]()}
        
        for item in tempArray {
            
            guard let tempDic = item as? [String:AnyObject] else {continue}
            
            let model = MCLocalCityArrayModel(JSON: tempDic)
            guard let tempModel = model else {continue}
            cityArray.append(tempModel)
        }
        return cityArray
        
    }
    ///获取所有城市数据
    func getAllCityData() -> [MCLocalCityModel]{
        allCityList.removeAll()
        cityArray.removeAll()
        
        
        let path = Bundle.main.path(forResource: "citydict", ofType: "plist")
        guard let tempStr = path else { return [MCLocalCityModel]()}
        
        let tempArr = NSArray(contentsOfFile: tempStr)
        
        guard let tempArray = tempArr else { return [MCLocalCityModel]()}
        
        for item in tempArray {
            
            guard let tempDic = item as? [String:AnyObject] else {return [MCLocalCityModel]()}
            
            let model = MCLocalCityArrayModel(JSON: tempDic)
            guard let tempModel = model else {return [MCLocalCityModel]()}
            cityArray.append(tempModel)
        }
        
        ///拿到所有数据
        for item in cityArray {
            if let tempArray = item.Citys {
                for city in tempArray {
                    allCityList.append(city)
                }
                
            }
        }
        return allCityList
        
    }
    
    //////////正式数据 -》 ///////////
    
    /*
    ///获取热门城市
    func getHotCityListData(completion:@escaping((_ isSuccess:Bool,_ data:MCCityListArrayModel?,_ message:String)->())){
        
        HFNetworkManager.MC_request(url: API.hotCityListUrl, method: .get, parameters: nil, description: "") { (errorData, resp) in
            if errorData != nil {
                print("errorData:\(errorData!)")
                completion(false,nil,errorData!.localizedDescription)
                return
            }
            
            let respData = resp?.rawData?.dictionaryObject
            guard let status:NSString = respData!["status"] as?NSString,
                let msg:String = respData!["msg"] as?String,
                let tempDict = respData
                else{ return completion(false,nil,"获取失败") }
            //暂时这么写，等验证码接口好了，就不这么写
            if status.integerValue != 1{
                completion(false,nil,msg)
            }else {
                print("tmepDict -->\(tempDict)")
                //请求成功
                let model = MCCityListArrayModel(JSON: tempDict)
                completion(true,model,msg)
            }
            
            
        }
        
        
    }
    

    ///获取城市列表
    func getGroupCityListData(completion:@escaping((_ isSuccess:Bool,_ data:MCCityListArrayModel?,_ message:String)->())){
        
        HFNetworkManager.MC_request(url: API.cityGroupListUrl, method: .get, parameters: nil, description: "") { (errorData, resp) in
            if errorData != nil {
                print("errorData:\(errorData!)")
                completion(false,nil,errorData!.localizedDescription)
                return
            }
            
            let respData = resp?.rawData?.dictionaryObject
            guard let status:NSString = respData!["status"] as?NSString,
                let msg:String = respData!["msg"] as?String,
                let tempDict = respData
                else{ return completion(false,nil,"获取失败") }
            //暂时这么写，等验证码接口好了，就不这么写
            if status.integerValue != 1{
                completion(false,nil,msg)
            }else {
                print("tmepDict -->\(tempDict)")
                //请求成功
                let model = MCCityListArrayModel(JSON: tempDict)
                completion(true,model,msg)
            }
            
            
        }
    }
    
    ///城市模糊查询
    func searchCityListData(completion:@escaping((_ isSuccess:Bool,_ data:MCCityListArrayModel?,_ message:String)->())){
        
        HFNetworkManager.MC_request(url: API.searchCityUrl, method: .get, parameters: nil, description: "") { (errorData, resp) in
            if errorData != nil {
                print("errorData:\(errorData!)")
                completion(false,nil,errorData!.localizedDescription)
                return
            }
            
            let respData = resp?.rawData?.dictionaryObject
            guard let status:NSString = respData!["status"] as?NSString,
                let msg:String = respData!["msg"] as?String,
                let tempDict = respData
                else{ return completion(false,nil,"获取失败") }
            //暂时这么写，等验证码接口好了，就不这么写
            if status.integerValue != 1{
                completion(false,nil,msg)
            }else {
                print("tmepDict -->\(tempDict)")
                //请求成功
                let model = MCCityListArrayModel(JSON: tempDict)
                completion(true,model,msg)
            }
            
            
        }
    }
    */
}

//
//  MCSelectLocalController.swift
//  CarTireShopMall
//
//  Created by 毛诚 on 2018/10/29.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD
import MJRefresh

typealias cityBlock = (_ cityName:String) -> ()


class MCSelectLocalController: BaseViewController {

    ///定位相关
    ///当前的省份
    fileprivate var currentProvince:String?
    ///当前的省份
    fileprivate var currentCity:String?
    ///当前的详细信息
    fileprivate var currentAddress:String?
    ///当前的城市所在的区
    fileprivate var currentArea:String?
    
    fileprivate lazy var currentLocation = CLLocation()
    fileprivate lazy var locationManager = CLLocationManager()
    
    
    
    
    var selectCityBlock:cityBlock?
    

    fileprivate lazy var myTableView = UITableView()
    fileprivate lazy var viewModel = MCSelectLocalViewModel()
    fileprivate lazy var headerView = MCSelectLocalHeaderView()
    fileprivate lazy var cityServer = MCLocalRequest()
    
    
    
    //    /// 搜索修改 - 所有城市数据
    fileprivate lazy var allCityList = [MCLocalCityModel]()
    fileprivate lazy var searchViewModel = MCCitySearchViewModel()
    fileprivate lazy var searchTableView = UITableView()
    
    ///搜索到的城市
    fileprivate lazy var resultList = [MCLocalCityModel]()
    
//    fileprivate lazy var searchController = UISearchController()
////    fileprivate lazy var searchResult = []
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createUI()
        createLocal()
    }
    
    ///定位
    fileprivate func createLocal(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000.0
        
        //开启定位权限检测
        locationCheck()
        //开始定位
        locationManager.startUpdatingLocation()
    }
    ///定位权限检测
    fileprivate func locationCheck(){
        if CLLocationManager.locationServicesEnabled() == false {
            SVProgressHUD.showInfo(withStatus: "请确认定位服务已开启")
            SVProgressHUD.dismiss(withDelay: 2.0)
            return
        }
        ///请求用户授权
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        
    }
    
    
    
    private func createUI() {
        
//        navigationItem.title = "地区选择"
        
        //        适配11.0
        if #available(iOS 11.0, *) {
            
            myTableView.contentInsetAdjustmentBehavior = .never
            
        } else {
            
        }
        
        myTableView.backgroundColor = Color.appBackgroundColor
        myTableView.separatorStyle = .singleLine
        myTableView.showsVerticalScrollIndicator = false
        myTableView.showsHorizontalScrollIndicator = false
        myTableView.sectionIndexColor = Color.mainTextColor
        myTableView.sectionIndexBackgroundColor = UIColor.clear
        
        view.addSubview(myTableView)
        view.addSubview(headerView)
        
        ///搜索补充
        searchTableView.backgroundColor = Color.appBackgroundColor
        searchTableView.separatorStyle = .singleLine
        searchTableView.showsVerticalScrollIndicator = false
        searchTableView.showsHorizontalScrollIndicator = false
        searchTableView.sectionIndexColor = Color.mainTextColor
        searchTableView.sectionIndexBackgroundColor = UIColor.clear
        searchTableView.isHidden = true
        view.addSubview(searchTableView)
        
        
        headerView.delegate = self
        headerView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0)
            make.height.equalTo(is_iPhonex ? 91:71)
            
        }
        
        myTableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0)
            make.top.equalTo(headerView.snp.bottom).offset(0)
            
        }
        
        searchTableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0)
            make.top.equalTo(headerView.snp.bottom).offset(0)
            
        }
        
        
        

        
        viewModel.registerTableView(tableView: myTableView)
        viewModel.delegate = self
        weak var weakSelf = self
        
        viewModel.getHotCityData(hotCityData: cityServer.getHotCityData()) {
            weakSelf?.myTableView.reloadData()
        }
        
        viewModel.getAllCityData(allCityData: cityServer.getCityData()) {
            weakSelf?.myTableView.reloadData()
        }
        
//        ////增加搜索 - 2018.12.11
        searchViewModel.registerTableView(tableView: searchTableView)
        searchViewModel.delegate = self
        ///网络请求
//        createRefresh()
//        hotCityRequest()
        
        ///拿到所有城市数据
        getAllCityRequest()
        
    }
    ///拿到所有城市数据
    private func getAllCityRequest(){
        allCityList.removeAll()
        allCityList = cityServer.getAllCityData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

///网络相关
extension MCSelectLocalController {
    private func createRefresh(){
        myTableView.mj_header  = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            print("刷新")
//            self?.refreshData()
        })
        myTableView.mj_header.beginRefreshing()
        
    }
    /*
    private func refreshData() {
        cityServer.getGroupCityListData {[weak self] (isSuccess, model, msg) in
            if isSuccess {
                self?.myTableView.mj_header.endRefreshing()
            }else {
                self?.myTableView.mj_header.endRefreshing()
            }
            
        }
    }
    private func hotCityRequest() {
        cityServer.getHotCityListData { (isSuccess, model, msg) in
            if isSuccess {
                
            }else {
                
            }
        }
    }
    */
    
    ///模糊查询
    private func dimSearchCity(keyStr:String){
        resultList.removeAll()
        for item in allCityList {
            let range = (item.cityName ?? "").range(of: keyStr)
            if range != nil {
                ///包含
                print("\(item.cityName ?? "")")
                resultList.append(item)
            }
        }
        ///刷新列表
        myTableView.isHidden = true
        searchTableView.isHidden = false
        searchViewModel.getCityData(data: resultList) {[weak self] in
            self?.searchTableView.reloadData()
        }
        
        
    }
    
    
}


extension MCSelectLocalController: MCSelectLocalViewModelDelegate {
    
    func cellClickAction(cityName: String) {
        print("选中的城市的名字:\(cityName)")
        guard let tempBlock = selectCityBlock else { return  }
        tempBlock(cityName)
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension MCSelectLocalController: MCSelectLocalHeaderViewDelegate {
    func searchAction(cityStr: String?) {
        
        if (cityStr ?? "").count <= 0 || (cityStr ?? "").isEmpty {
            
            searchTableView.isHidden = true
            myTableView.isHidden = false
            
            viewModel.registerTableView(tableView: myTableView)
            viewModel.delegate = self
            viewModel.getHotCityData(hotCityData: cityServer.getHotCityData()) {[weak self] in
                self?.myTableView.reloadData()
            }
            
            viewModel.getAllCityData(allCityData: cityServer.getCityData()) {[weak self] in
                self?.myTableView.reloadData()
            }
            
        }else {
            ///暂时搜汉字
            dimSearchCity(keyStr: cityStr ?? "")
        }
    }
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
}


extension MCSelectLocalController:CLLocationManagerDelegate {
    
    //定位失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失败")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("定位成功")
        
        currentLocation = locations.last ?? CLLocation()
        //反编码获取信息
        let geocoder:CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locations.last ?? CLLocation()) {[weak self] (placeMarks, error) in
            
            if placeMarks == nil {
                SVProgressHUD.showInfo(withStatus: "定位失败")
                SVProgressHUD.dismiss(withDelay: 2.0)
                return
            }
            
            guard let placeMark = placeMarks?.last else {return}
            
            
            //把当前的市过滤掉
            self?.currentCity = placeMark.locality?.replacingOccurrences(of: "市", with: "")
            
            
            ////全部打印
            ///详细地址 = country + administrativeArea + locality + subLocality + name
            
            //
            self?.currentCity = placeMark.locality ?? ""
            self?.currentArea = placeMark.subLocality ?? ""
            self?.currentProvince = placeMark.administrativeArea ?? ""
            self?.currentAddress = "\(placeMark.country ?? "")" + "\(placeMark.administrativeArea ?? "")" + "\(placeMark.locality ?? "")" + "\(placeMark.subLocality ?? "")" + "\(placeMark.name ?? "")"
            
            self?.viewModel.getLocationStr(locationStr: placeMark.locality ?? "", completion: {
                self?.myTableView.reloadData()
            })
            
        }
    }
}

extension MCSelectLocalController:MCCitySearchViewModelDelegate {
    func searchCellClickAction(cityName: String) {
        print("选中的城市的名字:\(cityName)")
        guard let tempBlock = selectCityBlock else { return  }
        tempBlock(cityName)
        navigationController?.popViewController(animated: true)
    }
    
    
}


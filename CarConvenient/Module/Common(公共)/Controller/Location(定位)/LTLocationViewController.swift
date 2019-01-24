//
//  LTLocationViewController.swift
//  LT
//
//  Created by Modi on 2018/7/5.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import SVProgressHUD

enum LocationFromType {
    case FromHome(btnTitle: String, addr: String)
    case FromMaterialDetail(btnTitle: String, addr: String)
    case FromPushPro(btnTitle: String, addr: String)
    case FromConfirmWorker(btnTitle: String, addr: String)
    case FromConfirmBoss(btnTitle: String, addr: String)
    case none
}

class LTLocationViewController: BaseViewController {

    @IBOutlet weak var xib_map: MKMapView! {
        didSet {
            //设置模式为卫星地图
            //mapView.mapType = .satellite
//            xib_map.delegate = self
        }
    }
    var currentLocation: CLLocationCoordinate2D?
    
    var location: CLLocation?
    
    var fromType: LocationFromType = .none
    
    
    /// 定位完成回调
    typealias LocationCompleteHandler = ((_ location: MKAnnotation) -> Void)
    
    var locationBlock: LocationCompleteHandler?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SVProgressHUD.show()
        SVProgressHUD.dismiss(withDelay: 2.5)
        
        switch fromType {
        case let .FromMaterialDetail(btnTitle: _, addr: address):
            
//            xib_map.isUserInteractionEnabled = false
            
            let arr = address.components(separatedBy: ",")
            if arr.count == 2 {
                let location = CLLocation(latitude: Double.init(arr[1])!, longitude: Double.init(arr[0])!)
                self.location = location
                self.currentLocation = location.coordinate
//                addWayPoint(coordinate2D: location.coordinate)
                setupMapView()
            }
            break
        default:
//            xib_map.isUserInteractionEnabled = true
            startLocation()
            break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "定位详情"
    }
    
    private func startLocation() {
        
        // 添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapMap(_:)))
        xib_map.addGestureRecognizer(tap)
        
        //定位当前位置获取经纬度
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupMapView), name: HFLocationDidUpdateNotification.name, object: nil)
        if AppEngine?.locationManager.isHaveAuthority == false {
            HFAlertController.showAlert(title: "打开定位开关", message: "定位服务未开启,请进入系统设置>隐私>定位服务中打开开关,并允许App使用定位服务", ConfirmCallBack: { (_, _) in
                if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(appSettings)
                }
            }, CancelCallBack: nil)
        }else {
            AppEngine?.locationManager.startLocation(complete: { (location, city) in
                debugPrint("location : \(location), city : \(city)")
                self.location = location
                self.setupMapView()
            })
        }
    }
    
    @objc private func setupMapView() {
        
        //设置导航定位：Latitude = 23.118511, Longitude = 113.321621
//        let coordinate = CLLocationCoordinate2D(latitude: 23.118511, longitude: 113.321621)
        let coordinate = CLLocationCoordinate2D(latitude: (self.location?.coordinate.latitude)!, longitude: (self.location?.coordinate.longitude)!)
        
        self.currentLocation = coordinate
        
        addWayPoint(coordinate2D: coordinate)
        
        //添加标注
//        let annotation = HFPointAnnotation(coordinate: coordinate, title: "柏悦酒店")
//        self.xib_map.addAnnotation(annotation)
        
    }
    
    private func setupBottomView(type: LocationFromType) {
        let bv = LTLocationBottomView.md_viewFromXIB() as! LTLocationBottomView
        bv.model = type
        view.addSubview(bv)
        bv.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(80)
        }
        
        bv.clickBlock = {(sender) in
            if let b = sender as? UIButton {
                self.handleAction(sender: b)
            }
        }
    }
    
    private func handleAction(sender: UIButton) {
        switch sender.tag {
        case 10001: //主页定位
            locationCallBack()
            break
        case 10002: //去导航
            HFAlertController.showMapAlert(title: "导航去这", message: "选择导航工具", SelectCallBack: { (type) in
                switch type {
                case .Gaode:
                    //判断是否安装应用
                    if UIApplication.shared.canOpenURL(URL(string: "iosamap://")!) {
                        let urlString = "iosamap://navi?sourceApplication=LiTong&backScheme=iosamap://&lat=\((self.currentLocation?.latitude)!)&lon=\((self.currentLocation?.longitude)!)&dev=0&style=2"
                        let url = URL(string:urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
                        UIApplication.shared.openURL(url!)
                    }else {
                        SVProgressHUD.showInfo(withStatus: "未发现应用，请先安装")
                    }
                    
                    break
                case .Baidu:
                    
                    //判断是否安装应用
                    if UIApplication.shared.canOpenURL(URL(string: "baidumap://")!) {
                        let urlString = "baidumap://map/direction?origin={{我的位置}}&destination=latlng:\((self.currentLocation?.latitude)!),\((self.currentLocation?.longitude)!)|name=LiTong&mode=driving&coord_type=gcj02"
                        let url = URL(string:urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
                        UIApplication.shared.openURL(url!)
                    }else {
                        SVProgressHUD.showInfo(withStatus: "未发现应用，请先安装")
                    }
                    
                    break
                case .Apple:
                    let currentLocation = MKMapItem.forCurrentLocation()
                    let toLocation = MKMapItem(placemark: MKPlacemark(coordinate: self.currentLocation!, addressDictionary: nil))
                    MKMapItem.openMaps(with: [currentLocation,toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: NSNumber.init(value: true)])
                    break
                default:
                    //谷歌地图
                    //判断是否安装应用
                    if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                        let urlString = "comgooglemaps://?x-source=LiTong&x-success=comgooglemaps://&saddr=&daddr=\((self.currentLocation?.latitude)!),\((self.currentLocation?.longitude)!)&directionsmode=driving"
                        let url = URL(string:urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
                        UIApplication.shared.openURL(url!)
                    }else {
                        SVProgressHUD.showInfo(withStatus: "未发现应用，请先安装")
                    }
                    
                    //腾讯地图
                    //                    let urlString = "qqmap://map/routeplan?from=我的位置&type=drive&tocoord=\((self.currentLocation?.latitude)!),\((self.currentLocation?.longitude)!)&to=\("名创酒品")&coord_type=1&policy=0"
                    //                    let url = URL(string:urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
                    //                    UIApplication.shared.openURL(url!)
                    break
                }
            })
            break
        case 10003: //发布项目
            locationCallBack()
            break
        case 10004: //认证工人
            //回传经纬度及详细地址
            locationCallBack()
            break
        case 10005: //认证老板
            locationCallBack()
            break
        default:
            break
        }
    }
    
    private func locationCallBack() {
        //回传经纬度及详细地址
        if let b = locationBlock {
            b(getCurrentPoint()!)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    /// 获取点击位置的经纬度传给后台
    ///
    /// - Parameter sender: 点击手势
    @objc func tapMap(_ sender: UITapGestureRecognizer) {
        clearWaypoints()
        let state = sender.state
        if state == .ended {
            //将长按点坐标转换到mapView上对应坐标
            let coordinate2D = xib_map.convert(sender.location(in: xib_map), toCoordinateFrom: xib_map)
            
            addWayPoint(coordinate2D: coordinate2D)
            
        }
    }
    
    private func addWayPoint(coordinate2D: CLLocationCoordinate2D) {
        //创建路点
        //let waypoint = GPX.Waypoint(latitude: coordinate2D.latitude, longitude: coordinate2D.longitude)
        //替换为可拖动的标注
        let waypoint = EditableWaypoint(latitude: coordinate2D.latitude, longitude: coordinate2D.longitude)
        
        _ = "默认地址"
        
        HFLocationManageer.shared.reverseGeocode(location: CLLocation(latitude: coordinate2D.latitude, longitude: coordinate2D.longitude), complete: {[weak self](add) in
            if let address = add {
                waypoint.name = address
                //            waypoint.info = "Dropped info"
                //添加测试图片
                //            waypoint.links.append(GPX.Link(href: "http://web.stanford.edu/class/cs193p/Images/Panorama.jpg"))
                //mapView上添加路点
                self?.xib_map.addAnnotation(waypoint)
                
                //添加动画
                self?.xib_map.setCenter(coordinate2D, animated: false)
                self?.xib_map.setRegion(.init(center: coordinate2D, span: .init(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: true)
                
                // 设置底部View
                self?.setupBottomView(type: (self?.changeAddr(addr: address))!)
            }
            
        })
    }
    
    
    /// 获取详细地址后重新修改fromType
    ///
    /// - Parameter addr: 详细地址
    /// - Returns: 修改后的fromType
    private func changeAddr(addr: String) -> LocationFromType {
        var type = fromType
        switch fromType {
        case let .FromHome(btnTitle: t, addr: _):
            type = .FromHome(btnTitle: t, addr: addr)
            break
        case let .FromMaterialDetail(btnTitle: t, addr: _):
            type = .FromMaterialDetail(btnTitle: t, addr: addr)
            break
        case let .FromPushPro(btnTitle: t, addr: _):
            type = .FromPushPro(btnTitle: t, addr: addr)
            break
        case let .FromConfirmWorker(btnTitle: t, addr: _):
            type = .FromConfirmWorker(btnTitle: t, addr: addr)
            break
        case let .FromConfirmBoss(btnTitle: t, addr: _):
            type = .FromConfirmBoss(btnTitle: t, addr: addr)
            break
        default:
            break
        }
        return type
    }
    
    /// 清除标注
    private func clearWaypoints() {
        if xib_map.annotations != nil {
            xib_map.removeAnnotations(xib_map.annotations as [MKAnnotation])
        }
    }
    
    private func getCurrentPoint() -> MKAnnotation? {
        var point: MKAnnotation?
        if xib_map.annotations != nil {
            point = xib_map.annotations[0]
        }
        return point
    }
}

class HFPointAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate:CLLocationCoordinate2D, title:String) {
        
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
}

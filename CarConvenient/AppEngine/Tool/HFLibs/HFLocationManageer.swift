//
//  HFLocationManageer.swift
//  3HMall
//
//  Created by 姚鸿飞 on 2018/4/23.
//  Copyright © 2018年 姚鸿飞. All rights reserved.
//

import UIKit
import CoreLocation

class HFLocationManageer: NSObject, CLLocationManagerDelegate {
    
    static let shared: HFLocationManageer = HFLocationManageer()
    
    let locationManager = CLLocationManager()
    
    var isHaveAuthority: Bool {
        get {
            if CLLocationManager.authorizationStatus() == .denied {
                return false
            }else {
                return true
            }
        }
    }
    
    var isFinish: Bool = false
    
    /// 当前位置
    var currentLocation:CLLocation = CLLocation(latitude: 39.92, longitude: 116.46)
    
    var currentLatitude: Double? {
        get {
            return self.currentLocation.coordinate.latitude
        }
    }
    
    var currentLongitude: Double? {
        get {
            return self.currentLocation.coordinate.longitude
        }
    }
    
    var currentCity: String = "北京"
    
    /// 线程锁
    private var lock = NSLock()
    
    private var callBackBlock: ((_ location:CLLocation,_ city: String) -> Void)?

    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest  // 最好定位精度
        
    }
    
    func startLocation(complete:((_ location:CLLocation,_ city: String) -> Void)?) {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.callBackBlock = complete
        print("开始定位")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.lock.lock()
        self.currentLocation = locations.last!
        print("定位经纬度为：\(currentLocation.coordinate.latitude)")
        //一直发生定位错误输出结果为0：原因是我输出的是currentLocation.altitude(表示高度的)而不是currentLoction.coordinate.latitude（这个才是纬度）
        print(self.currentLocation.coordinate.longitude)
        lock.unlock()
        self.locationToCity(location: self.currentLocation) { (City, State, Country) in
            self.callBackBlock?(self.currentLocation, City)
            NotificationCenter.default.post(name: HFLocationDidUpdateNotification.name, object: nil)
            self.isFinish = true
        }
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位出错拉！！\(error)")
        let location = CLLocation(latitude: 39.92, longitude: 116.46)
        self.locationToCity(location: location) { (City, State, Country) in
            self.callBackBlock?(self.currentLocation, City)
            NotificationCenter.default.post(name: HFLocationDidUpdateNotification.name, object: nil)
        }
        
    }

    ///将经纬度转换为城市名
    func locationToCity(location: CLLocation?, complete:@escaping ((_ city: String,_ state: String,_ country: String) -> Void))  {
        let geocoder: CLGeocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location!) { (placemark, error) in
            
            if (error == nil) {//转换成功，解析获取到的各个信息
                
                let mark = placemark!.first!
                
                var city: String = mark.addressDictionary!["City"] as! String
                let country: String = mark.addressDictionary!["Country"] as! String
//                var CountryCode: String = mark.addressDictionary!["CountryCode"] as! String
                var state: String? = mark.addressDictionary!["State"] as? String
              
                
                
                //去掉“市”和“省”字眼
                city = city.replacingOccurrences(of: "市", with: "")
                state = state?.replacingOccurrences(of: "省", with: "")
                //city = city.stringByReplacingOccurrencesOfString("市", withString: "")
                //State = State.stringByReplacingOccurrencesOfString("省", withString: "")
                self.currentCity = city
                
                complete(city,state == nil ? "" : state!,country)
                
                //                println(city)
                //            println(country)
                //            println(CountryCode)
                //            println(FormattedAddressLines)
                //            println(Name)
                //                println(State)
                //            println(SubLocality)
            }else {
                //转换失败
                complete("","","")
            }
            
        }
        
        
    }
    
    
    /// 地址转换完成回调
    typealias ReverseGeocodeCompleteHandler = (_ address: String?) -> Void
    
    //地理信息反编码
    
    /// 将经纬度转为地址
    ///
    /// - Parameter location: 经纬度
    /// - Returns: 详细地址
    func reverseGeocode(location: CLLocation, complete: @escaping ReverseGeocodeCompleteHandler) {
        
        var addr: String?
        
        let geocoder = CLGeocoder()
        let currentLocation = location
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            //强制转成简体中文
            let array = NSArray(object: "zh-hans")
            UserDefaults.standard.set(array, forKey: "AppleLanguages")
            //显示所有信息
            if error != nil {
                debugPrint("Error --------------------------> 错误：\(error!.localizedDescription))")
                addr = nil
                return
            }
            
            if let p = placemarks?[0]{
                print(p) //输出反编码信息
                var address = ""
                
                if let country = p.country {
                    address.append("国家：\(country)\n")
                }
                if let administrativeArea = p.administrativeArea {
                    address.append("省份：\(administrativeArea)\n")
                }
                if let subAdministrativeArea = p.subAdministrativeArea {
                    address.append("其他行政区域信息（自治区等）：\(subAdministrativeArea)\n")
                }
                if let locality = p.locality {
                    address.append("城市：\(locality)\n")
                }
                if let subLocality = p.subLocality {
                    address.append("区划：\(subLocality)\n")
                }
                if let thoroughfare = p.thoroughfare {
                    address.append("街道：\(thoroughfare)\n")
                }
                if let subThoroughfare = p.subThoroughfare {
                    address.append("门牌：\(subThoroughfare)\n")
                }
                if let name = p.name {
                    address.append("地名：\(name)\n")
                    addr = name
                }
                if let isoCountryCode = p.isoCountryCode {
                    address.append("国家编码：\(isoCountryCode)\n")
                }
                if let postalCode = p.postalCode {
                    address.append("邮编：\(postalCode)\n")
                }
                if let areasOfInterest = p.areasOfInterest {
                    address.append("关联的或利益相关的地标：\(areasOfInterest)\n")
                    if (addr?.isEmpty)! {
                        addr = areasOfInterest.first!
                    }
                }
                if let ocean = p.ocean {
                    address.append("海洋：\(ocean)\n")
                }
                if let inlandWater = p.inlandWater {
                    address.append("水源，湖泊：\(inlandWater)\n")
                }
                
                debugPrint("address --------------------------> \(address)")
//                addr = address
                complete(addr)
                
            } else {
                print("No placemarks!")
            }
        })
        
    }
    
    //地理信息编码
    
    /// 将地址转为经纬度
    ///
    /// - Parameter addr: 详细地址
    /// - Returns: 经纬度
    func locationEncode(addr: String) -> CLLocation? {
        
        var temp: CLLocation?
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addr, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            
            if error != nil {
                debugPrint("Error --------------------------> 错误：\(error!.localizedDescription))")
                temp = nil
                return
            }
            if let p = placemarks?[0]{
                temp = CLLocation(latitude: (p.location?.coordinate.latitude)!, longitude: (p.location?.coordinate.longitude)!)
            } else {
                print("No placemarks!")
                temp = nil
            }
        })
        return temp
    }
    
}

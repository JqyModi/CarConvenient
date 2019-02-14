//
//  MCSelectLocalHeader.swift
//  CarTireShopMall
//
//  Created by 毛诚 on 2018/10/29.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit

@objc protocol MCSelectLocalHeaderDelegate : NSObjectProtocol{
    
    func clickHotCityAction(cityName:String) //搜索
}


class MCSelectLocalHeader: UITableViewHeaderFooterView {

    weak open var delegate:MCSelectLocalHeaderDelegate?
    
    fileprivate let leftMargin = 15.0
    //
    private lazy var centerBgView = UIView()
    private lazy var selectLocalBtn = MCLocalButton(type: .custom)
    private lazy var currentLocalBtn = UIButton()
    
    //
    private lazy var bottmBgView = UIView()
    private lazy var hotBtn = MCLocalButton(type: .custom)
    
    
    //    MARK:赋值
    // 15 + 30 + 15 ->
    fileprivate let mc_width:CGFloat = (SCREEN_WIDTH - 60 - 30) / 4
    fileprivate let mc_height:CGFloat = 35.0
    
    var hotCityData:[MCLocalHotCityModel]? {
        didSet{
            if bottmBgView.subviews.count <= 0 {
                guard let tempArray = hotCityData else {return}
                for item in 0..<tempArray.count {
                    let tempModel = tempArray[item]
                    let tempBtn = UIButton()
                    tempBtn.setTitle(tempModel.cityNameStr, for: .normal)
                    tempBtn.setTitleColor(Color.mainTextColor, for: .normal)
                    tempBtn.backgroundColor = UIColor.white
                    tempBtn.titleLabel?.textAlignment = .center
                    tempBtn.tag = item + 80
                    tempBtn.titleLabel?.font = Fount.bigFontT10
                    
                    
                    bottmBgView.addSubview(tempBtn)
                    tempBtn.frame = CGRect(x: 15 + CGFloat(item % 4) * (mc_width + 10), y: CGFloat(item / 4) * (mc_height + 10), width: mc_width, height: mc_height)
                    tempBtn.viewClipCorner(radius: 4.0, fillColor: UIColor.white)
                    
                    tempBtn.addTarget(self, action: #selector(cityBtnClick(button:)), for: .touchUpInside)
                    
                }
                
                
            }
        }
    }
    
    
    ///定位数据
    var locationCityStr:String?{
        didSet{
            currentLocalBtn.setTitle(locationCityStr, for: .normal)
            currentLocalBtn.setImage(UIImage(named: "ic_location_n"), for: .normal)
        }
    }
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    private func createUI() {
        contentView.backgroundColor = Color.appBackgroundColor
        
        centerBgView.backgroundColor = Color.appBackgroundColor
        contentView.addSubview(centerBgView)
        
        
        
        
        
        selectLocalBtn.setTitle("定位/最近", for: .normal)
        selectLocalBtn.setTitleColor(UIColor(rgba: "#666666"), for: .normal)
//        selectLocalBtn.setImage(UIImage(named: "ic_location_n"), for: .normal)
        
        selectLocalBtn.titleLabel?.textAlignment = .center
        selectLocalBtn.titleLabel?.font = Fount.smallFont1
        //        selectLocalBtn.addTarget(self, action: #selector(registerClick(button:)), for: .touchUpInside)
        
        centerBgView.addSubview(selectLocalBtn)
        
        
        currentLocalBtn.setTitle("全部", for: .normal)
        currentLocalBtn.setTitleColor(UIColor(rgba: "#333333"), for: .normal)
        currentLocalBtn.backgroundColor = UIColor.white
        currentLocalBtn.titleLabel?.textAlignment = .left
        currentLocalBtn.titleLabel?.font = Fount.bigFontT8
        currentLocalBtn.addTarget(self, action: #selector(localBtnClick(button:)), for: .touchUpInside)
        
        centerBgView.addSubview(currentLocalBtn)
        
        
        
        
        //
        bottmBgView.backgroundColor = Color.appBackgroundColor
        contentView.addSubview(bottmBgView)
        
        hotBtn.setTitle("热门城市", for: .normal)
        hotBtn.setTitleColor(UIColor(rgba: "#666666"), for: .normal)
//        hotBtn.setImage(UIImage(named: "ic_city_n"), for: .normal)
        hotBtn.titleLabel?.textAlignment = .left
        hotBtn.titleLabel?.font = Fount.smallFont1
        //        hotBtn.addTarget(self, action: #selector(hotBtnClick(button:)), for: .touchUpInside)
        
        contentView.addSubview(hotBtn)
        
        currentLocalBtn.frame = CGRect(x: leftMargin, y: 0, width: 100, height: 35)
        currentLocalBtn.viewClipCorner(radius: 5.0, fillColor: UIColor.white)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        centerBgView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(90)
        }
        selectLocalBtn.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(leftMargin)
            make.size.equalTo(CGSize(width: 90, height: 30))
        }
        
        currentLocalBtn.snp.makeConstraints { (make) in
            make.top.equalTo(selectLocalBtn.snp.bottom).offset(0)
            make.left.equalToSuperview().offset(leftMargin)
            make.size.equalTo(CGSize(width: 100, height: 35))
        }
        
        hotBtn.snp.makeConstraints { (make) in
            make.left.equalTo(selectLocalBtn)
            make.top.equalTo(centerBgView.snp.bottom).offset(0)
            make.size.equalTo(CGSize(width: 120, height: 30))
        }
        
        bottmBgView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0)
            make.top.equalTo(hotBtn.snp.bottom).offset(0)
            
        }
        
        
        
        
    }
    
    @objc private func cityBtnClick(button:UIButton) {
        
        guard let tempArray = hotCityData else {return}
        let currentIndex = button.tag - 80
        if currentIndex < tempArray.count  {
            delegate?.clickHotCityAction(cityName: tempArray[currentIndex].cityNameStr ?? "")
        }
    }
    
    
    //全部定位到的城市
    @objc private func localBtnClick(button:UIButton) {
        if button.titleLabel?.text == "全部" {
            
        }else {
            delegate?.clickHotCityAction(cityName: button.titleLabel?.text ?? "")
        }
        
    }
    
    @objc private func hotBtnClick(button:UIButton) {
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

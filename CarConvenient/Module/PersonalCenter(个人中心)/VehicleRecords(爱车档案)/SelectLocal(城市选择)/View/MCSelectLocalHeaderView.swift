//
//  MCSelectLocalHeaderView.swift
//  CarTireShopMall
//
//  Created by 毛诚 on 2018/10/29.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@objc protocol MCSelectLocalHeaderViewDelegate : NSObjectProtocol{
    
    func backAction() //返回
    func searchAction(cityStr:String?) //搜索
    
}



class MCSelectLocalHeaderView: UIView {

    weak open var delegate:MCSelectLocalHeaderViewDelegate?
    
    fileprivate let bag = DisposeBag()
    
    private lazy var customSearch = MCSearchBar()
    private lazy var searchBtn = UIButton(type: .custom)
    private lazy var backBtn = UIButton(type: .custom)
//    private lazy var titleLab = UILabel()
    
    
    fileprivate var cityStr:String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    private func createUI() {
        
        backgroundColor = UIColor.white

        
        backBtn.setImage(UIImage(named: "global_btn_return_n"), for: .normal)
        backBtn.setTitleColor(UIColor.white, for: .normal)
        
        backBtn.addTarget(self, action: #selector(backBtnClick(button:)), for: .touchUpInside)
        addSubview(backBtn)
        
//        titleLab.textColor = UIColor.white
//        titleLab.font = Fount.bigFontT9
//        titleLab.numberOfLines = 1
//        titleLab.text = "地区选择"
//        titleLab.textAlignment = .center
//        addSubview(titleLab)
        
        
        
        
        customSearch.leftImageStr = "ic_search"
        customSearch.holdStr = "搜索城市"
//        customSearch.delegate = self
        customSearch.backgroundColor = UIColor(rgba: "#EEEEEE")
        customSearch.leftSize = CGSize(width: 25, height: 25)
        customSearch.leftMargin = 45
        addSubview(customSearch)
        customSearch.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 75, height: 30)
//        customSearch.viewClipCorner(radius: 6.0, fillColor: UIColor.white)
        customSearch.layer.cornerRadius = 6
        customSearch.layer.masksToBounds = true
        
        customSearch.rightView = nil
        customSearch.rightViewMode = .never
        
        customSearch.rx.text.orEmpty.asObservable().subscribe(onNext: {[weak self] (result) in
            self?.cityStr = result
            self?.delegate?.searchAction(cityStr: result)
            
            
        }).disposed(by: bag)
        
        customSearch.openTap = false
        
        searchBtn.setTitle("搜索", for: .normal)
        searchBtn.setTitleColor(UIColor(rgba: "#1B82D2"), for: .normal)
        searchBtn.titleLabel?.font = Fount.bigFontT10
        searchBtn.addTarget(self, action: #selector(searchBtnClick(button:)), for: .touchUpInside)
        addSubview(searchBtn)
        
    }
    
    @objc private func backBtnClick(button:UIButton) {
        
        delegate?.backAction()
    }
    @objc private func searchBtnClick(button:UIButton) {
        
//        if (cityStr ?? "").count <= 0 || (cityStr ?? "").isEmpty {
//            SVProgressHUD.showInfo(withStatus: "请输入城市")
//            SVProgressHUD.dismiss(withDelay: 2.0)
//            return
//        }
        delegate?.searchAction(cityStr: cityStr ?? "")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
//        titleLab.snp.makeConstraints { (make) in
//            if is_iPhonex {
//                make.top.equalToSuperview().offset(44)
//            }else {
//                make.top.equalToSuperview().offset(24)
//            }
//
//            make.centerX.equalToSuperview().offset(0)
//            make.size.equalTo(CGSize(width: 230, height: 35))
//        }
        customSearch.snp.makeConstraints { (make) in
            make.centerY.equalTo(backBtn.snp.centerY)
            make.left.equalTo(backBtn.snp.right).offset(10)
            make.height.equalTo(35)
        }
        searchBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalTo(customSearch.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 50, height: 30))
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

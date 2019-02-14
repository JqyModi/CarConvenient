//
//  MCLocalCityGroup.swift
//  InternetOfProfit
//
//  Created by 毛诚 on 2018/9/3.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit

class MCLocalCityGroup: UITableViewHeaderFooterView {

    private lazy var titleLab = UILabel()
    
    var headerModel:MCLocalCityArrayModel?{
        didSet{
            titleLab.text = headerModel?.letterStr
        }
    }
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    private func createUI() {
        contentView.backgroundColor = Color.appBackgroundColor
        
        titleLab.textColor = Color.mainTextColor
        titleLab.font = Fount.smallFont1
        titleLab.numberOfLines = 1
        titleLab.text = "地区选择"
        titleLab.textAlignment = .left
        contentView.addSubview(titleLab)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.bottom.equalToSuperview().offset(0)
            make.top.equalTo(snp.centerY).offset(0)
            
        }
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

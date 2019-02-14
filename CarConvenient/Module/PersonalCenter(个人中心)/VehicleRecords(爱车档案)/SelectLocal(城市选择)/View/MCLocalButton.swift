//
//  MCLocalButton.swift
//  InternetOfProfit
//
//  Created by 毛诚 on 2018/9/3.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit

class MCLocalButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .left
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRect(x: 0, y: 0, width: 18 , height: 20)
        titleLabel?.frame = CGRect(x: 10, y: 0, width: width - 21, height: 25)
        titleLabel?.centerY = imageView?.centerY ?? 10
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

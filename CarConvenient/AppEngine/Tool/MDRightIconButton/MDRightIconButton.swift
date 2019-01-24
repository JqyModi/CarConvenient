//
//  MDRightIconButton.swift
//  LT
//
//  Created by Modi on 2018/7/9.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit

/// button类型
///
/// - separate: 两端对齐
/// - adjacent: 相邻对齐
/// - none: 正常
@objc enum MDRightIconButtonType: Int {
    case separate, adjacent, none
}

@IBDesignable
class MDRightIconButton: UIButton {

//    var alignment: MDRightIconButtonType = .none
    
    @IBInspectable
    var alignment: Int = 2
    
    //更改按钮中图标和文字的位置：布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch self.alignment {
        case 1:
            self.titleLabel?.left = (self.frame.width - (self.titleLabel?.width)!)/2
            self.imageView?.left = (self.titleLabel?.right)!
            break
        case 2:
            self.imageView?.left = self.frame.width-(self.imageView?.width)!
            self.titleLabel?.left = Margin.md_SmallMargin
            break
        case 3:
            self.imageView?.left = self.frame.width-(self.imageView?.width)!
            self.titleLabel?.right = (self.imageView?.left)!
            break
        default:
            break
        }
    }
    
    
}

//
//  BaseView.swift
//  AMFC
//
//  Created by Modi on 2018/7/27.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit

class BaseView: UIView {

    var clickBlock: ((_ sender: Any?) -> ())?

    var updateFrameBlock: ((_ height: CGFloat) -> Void)?
    
    var updateFrameYBlock: ((_ height: CGFloat, _ y: CGFloat) -> Void)?
    
    var removeBlock: ((_ sender: Any?) -> ())?
}

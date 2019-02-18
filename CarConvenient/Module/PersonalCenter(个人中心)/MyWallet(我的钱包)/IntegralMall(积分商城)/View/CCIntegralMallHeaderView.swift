//
//  CCIntegralMallHeaderView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/12.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCIntegralMallHeaderView: BaseView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func btn_DidClicked(_ sender: UIButton) {
        if let b = clickBlock {
            b(sender)
        }
    }
}

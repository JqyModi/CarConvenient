//
//  CCHandWashCarPopView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/20.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCHandWashCarPopView: BaseView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        if sender.tag == 10001 {
            if let sv = self.superview {
                sv.removeFromSuperview()
            }
        }else {
            if let b = clickBlock {
                b(sender)
            }
        }
    }
    
}

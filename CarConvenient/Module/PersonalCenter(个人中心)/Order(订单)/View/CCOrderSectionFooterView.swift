//
//  CCOrderSectionFooterView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/28.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCOrderSectionFooterView: BaseView {
    
    @IBOutlet weak var leftBtn: UIButton! {
        didSet {
            leftBtn.layer.borderWidth = 0.5
            leftBtn.layer.borderColor = UIColor(rgba: "#DDDDDD").cgColor
        }
    }
    @IBOutlet weak var rightBtn: UIButton! {
        didSet {
            rightBtn.layer.borderWidth = 0.5
            rightBtn.layer.borderColor = UIColor(rgba: "#F95E5E").cgColor
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        if let b = clickBlock {
            b(sender)
        }
    }
    
    
}

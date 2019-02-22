//
//  CCInvoiceView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCInvoiceFooterView: BaseView {

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

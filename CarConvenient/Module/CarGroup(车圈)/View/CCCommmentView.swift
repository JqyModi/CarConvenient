//
//  FCCommunicationFooterView.swift
//  AMFC
//
//  Created by Modi on 2018/8/10.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit

class CCCommmentView: BaseView {

    @IBOutlet weak var xib_inputDesc: UITextField!
    @IBOutlet weak var xib_send: UIButton! {
        didSet {
            xib_send.layer.borderColor = UIColor(rgba: "#DDDDDD").cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func xib_send(_ sender: UIButton) {
        if let b = clickBlock {
            b(sender)
        }
    }
    
}

//
//  CCRebateViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/28.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCRebateViewController: BaseViewController {

    @IBOutlet weak var xib_content: UITextView! {
        didSet {
            xib_content.layer.borderWidth = 0.5
            xib_content.layer.cornerRadius = 5
            xib_content.layer.masksToBounds = true
            xib_content.layer.borderColor = UIColor(rgba: "#DDDDDD").cgColor
            xib_content.md_placeholder = "请输入退款原因"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "申请退款"
    }

}

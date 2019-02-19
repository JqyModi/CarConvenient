//
//  CCAddTimelineViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/19.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCAddTimelineViewController: BaseViewController {

    @IBOutlet weak var xib_content: UITextView! {
        didSet {
            xib_content.layer.borderWidth = 0.5
            xib_content.layer.cornerRadius = 5
            xib_content.layer.masksToBounds = true
            xib_content.layer.borderColor = UIColor(rgba: "#DDDDDD").cgColor
            xib_content.md_placeholder = "也许你还想说点什么...."
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func setupStyle() {
        super.setupStyle()
        
        addRightItem(title: "发表", fontColor: UIColor(rgba: "#1B82D2"))
    }
    
    override func clickRight(sender: UIButton) {
        super.clickRight(sender: sender)
        
        
    }
    
}

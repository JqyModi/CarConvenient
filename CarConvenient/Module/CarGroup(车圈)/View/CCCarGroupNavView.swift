
//
//  CCCarGroupNavView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/18.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCCarGroupNavView: BaseView {

    @IBOutlet weak var xib_segment: UISegmentedControl! {
        didSet {
            xib_segment.setSegmentStyle(normalColor: UIColor.white, selectedColor: UIColor(rgba: "#1B82D2"), dividerColor: UIColor(rgba: "#DDDDDD"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: SCREEN_WIDTH-120, height: 33)
    }
}

//
//  CCMessageTableViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/14.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var xib_centerBgView: UIView! {
        didSet {
            xib_centerBgView.layer.borderColor = UIColor(rgba: "#DDDDDD").cgColor
            xib_centerBgView.layer.borderWidth = 0.5
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

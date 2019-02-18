//
//  CCCouponsTableViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCPrizesTableViewCell: UITableViewCell {

    @IBOutlet weak var xib_bgView: UIView! {
        didSet {
            xib_bgView.layer.borderWidth = 0.5
            xib_bgView.layer.borderColor = UIColor(rgba: "#DDDDDD").cgColor
        }
    }
    @IBOutlet weak var xib_leftBgView: UIView! {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

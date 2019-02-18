//
//  CCCouponsTableViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCCouponsTableViewCell: UITableViewCell {

    @IBOutlet weak var xib_bgView: UIView! {
        didSet {
            let iv = UIImageView(image: UIImage(named: "bg_discount_coupon-1")!)
            xib_bgView.addSubview(iv)
            iv.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            xib_bgView.sendSubview(toBack: iv)
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

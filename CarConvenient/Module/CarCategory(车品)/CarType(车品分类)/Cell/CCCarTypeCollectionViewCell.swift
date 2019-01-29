//
//  ZACategoryCollectionViewCell.swift
//  ZhongAiHealth
//
//  Created by 微标杆 on 2018/10/8.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit

class CCCarTypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.layer.cornerRadius = 5
            iconImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
}

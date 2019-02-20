//
//  CCOtherWashCarTableViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/20.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCOtherWashCarTableViewCell: UITableViewCell {

    @IBOutlet weak var starView: ZYStarRateView! {
        didSet {
            starView.selectNumberOfStar = 3
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

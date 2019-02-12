//
//  CCSpikeTableViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/28.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCSpikeTableViewCell: UITableViewCell {

    @IBOutlet weak var xib_progress: UIProgressView! {
        didSet {
            xib_progress.layer.cornerRadius = 5.5
            xib_progress.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

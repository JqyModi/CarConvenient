//
//  CCAddressManagerTableViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCAddressManagerTableViewCell: UITableViewCell {

    @IBOutlet weak var xib_defaultAddr: UILabel!
    var defaultAddr: Bool = false {
        didSet {
            if defaultAddr {
                xib_defaultAddr.isHidden = false
            }else {
                xib_defaultAddr.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.defaultAddr = false
    }
    
}

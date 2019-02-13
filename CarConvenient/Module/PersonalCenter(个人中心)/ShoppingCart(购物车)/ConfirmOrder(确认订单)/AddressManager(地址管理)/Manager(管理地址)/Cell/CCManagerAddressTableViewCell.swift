//
//  CCManagerAddressTableViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCManagerAddressTableViewCell: UITableViewCell, ViewClickedDelegate {
    
    var clickBlock: ((Any?) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        if let b = self.clickBlock {
            b(sender)
        }
    }
}

//
//  CCShoppingCartTableViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/12.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCShoppingCartTableViewCell: UITableViewCell {

    @IBOutlet weak var xib_countBgView: UIView!
    @IBOutlet weak var xib_count: UILabel!
    @IBOutlet weak var xib_editCount: UILabel!
    
    var totalSum = 1
    
    var editStatus: Bool = false {
        didSet {
            if editStatus {
                xib_countBgView.isHidden = false
                xib_count.isHidden = true
            }else {
                xib_countBgView.isHidden = true
                xib_count.isHidden = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.editStatus = false
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        switch sender.tag {
        case 10001:
            if totalSum <= 1 {
                return
            }
            totalSum -= 1
            break
        case 10002:
            totalSum += 1
            break
        default:
            break
        }
        xib_editCount.text = "\(totalSum)"
    }
}

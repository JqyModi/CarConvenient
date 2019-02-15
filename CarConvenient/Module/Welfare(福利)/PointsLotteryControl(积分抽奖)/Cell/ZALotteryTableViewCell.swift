//
//  ZALotteryTableViewCell.swift
//  ZhongAiHealth
//
//  Created by 微标杆 on 2018/10/29.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit

class ZALotteryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func updateCell(model:ZALotteryModel) {
        titleLabel.text = "\(model.prizename!):\(model.remark!)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

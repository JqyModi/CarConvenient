//
//  CCVehicleRecordsTypeOneBtnTableViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/14.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCVehicleRecordsTypeOneBtnTableViewCell: UITableViewCell {

    @IBOutlet weak var xib_title: UILabel!
    @IBOutlet weak var xib_content: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(model: [String: String]) {
        let title = model["title"]
        let ph = model["placeholder"]
        xib_title.text = title
        xib_content.setTitle(ph, for: .normal)
        if let value = model["value"], value != "" {
            xib_content.setTitle(value, for: .normal)
        }
    }
}

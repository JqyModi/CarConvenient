//
//  CCOwnersCertificationTableViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/14.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCOwnersCertificationTableViewCell: UITableViewCell {

    @IBOutlet weak var xib_title: UILabel!
    @IBOutlet weak var xib_content: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(model: [String: String]) {
        let title = model["title"]
        let ph = model["placeholder"]
        
        xib_title.text = title
        xib_content.placeholder = ph
        if let value = model["value"], value != "" {
            xib_content.text = value
        }
    }
    
}

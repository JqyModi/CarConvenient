//
//  CCServicePopTableViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCServicePopTableViewCell: UITableViewCell {

    @IBOutlet weak var xib_title: UILabel!
    @IBOutlet weak var xib_content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(model: [String: String]) {
        let title = model["title"]
        let content = model["content"]
        xib_title.text = title
        xib_content.text = content
    }

}

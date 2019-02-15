//
//  CCWelfareMenuCollectionViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/15.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCWelfareMenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var xib_image: UIImageView!
    @IBOutlet weak var xib_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(model: [String: String]) {
        let title = model["title"]
        xib_title.text = title
        if let img = model["image"] {
            //设置图片
            xib_image.image = UIImage(named: img)
        }
    }
}

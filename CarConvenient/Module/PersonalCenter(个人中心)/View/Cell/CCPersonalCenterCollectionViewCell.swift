//
//  CCPersonalCenterCollectionViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/11.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCPersonalCenterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var xib_img: UIImageView!
    @IBOutlet weak var xib_title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(dic: [String: String]) {
        let title = dic["title"]
        let img = dic["img"]
        xib_img.image = UIImage(named: img ?? "")
        xib_title.text = title
    }

}

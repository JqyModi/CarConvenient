//
//  CCConfirmOrderCollectionViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCConfirmOrderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var xib_image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(model: String) {
        //设置图片
        xib_image.kf.setImage(with: URL(string: model), placeholder: #imageLiteral(resourceName: "print_load"))
    }
}

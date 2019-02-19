//
//  CollectionViewCell.swift
//  WechatTimeLineXib
//
//  Created by Modi on 2018/12/2.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(model: CollectionModel) {
        image.image = model.image
    }
    
}
class CollectionModel {
    var image: UIImage?
    
    init(image: UIImage?) {
        self.image = image
    }
}

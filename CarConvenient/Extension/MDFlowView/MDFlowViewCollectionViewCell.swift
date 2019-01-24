//
//  MDFlowViewCollectionViewCell.swift
//  AMFC
//
//  Created by Modi on 2018/8/1.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit

class MDFlowViewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var xib_image: UIImageView! {
        didSet {
            xib_image.layer.cornerRadius = xib_image.width/2
            xib_image.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var xib_name: UILabel!
    @IBOutlet weak var xib_desc: UILabel!
    @IBOutlet weak var xib_number: UILabel!
    @IBOutlet weak var xib_phone: UILabel!
    
    var model: MDFlowViewCollectionViewCellVModel? {
        didSet {
            //设置图片
            if let img = model?.vm_image, img != "" {
                let imgUrl = API.baseImageURL + img
                xib_image.kf.setImage(with: URL(string: imgUrl), placeholder: UIImage(named: "img_face_min"), options: nil, progressBlock: nil, completionHandler: nil)
            }
            
            if let name = model?.vm_name {
                xib_name.text = name
            }
            
            if let desc = model?.vm_desc {
                xib_desc.text = desc
            }
            
            if let number = model?.vm_number {
                xib_number.text = number
            }
            
            if let phone = model?.vm_phone {
                xib_phone.text = phone
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupStyle()
    }

}
extension MDFlowViewCollectionViewCell {
    
    private func setupStyle() {
        xib_name.textColor = UIColor.black
        xib_name.font = UIFont.systemFont(ofSize: FontSize.md_DescFontSize)
        xib_desc.textColor = Color.md_BtnDisableTitleColor
        xib_desc.font = UIFont.systemFont(ofSize: 10)
        
        xib_number.textColor = UIColor.black
        xib_number.font = UIFont.systemFont(ofSize: 10)
        xib_phone.textColor = UIColor.black
        xib_phone.font = UIFont.systemFont(ofSize: 10)
    }
}

struct MDFlowViewCollectionViewCellVModel {
    var vm_image = ""
    var vm_name = ""
    var vm_desc = ""
    var vm_number = ""
    var vm_phone = ""
}

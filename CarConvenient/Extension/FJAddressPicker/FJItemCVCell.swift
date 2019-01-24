//
//  FJItemCVCell.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/23.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJItemCVCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
//    open var click: ((_ address: String) -> Void)?
    
    var model:AddressModel? {
        didSet {
            if let text = model?.name {
                titleLabel.text = text
//                click!(text)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

//
//  STServiceCCell.swift
//  CarConvenient
//
//  Created by suteer on 2019/2/13.
//  Copyright © 2019 modi. All rights reserved.
//

import UIKit

class STServiceCCell: UICollectionViewCell {

    @IBOutlet weak var picI: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //STServiceViewControllerMode
    func updateCell(mode:STServiceViewControllerMode){
        picI.image = UIImage(named: mode.pic)
        titleL.text = mode.title
    }
    
}

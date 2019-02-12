//
//  CCMyWalletHeaderView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/11.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCMyWalletHeaderView: BaseView {

    @IBOutlet weak var xib_userInfoBgView: UIView! {
        didSet {
//            xib_userInfoBgView.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg_img_bargain")!)
            xib_userInfoBgView.contentMode = .scaleAspectFill
            xib_userInfoBgView.layer.contents = UIImage(named: "bg_img_bargain")?.cgImage
        }
    }

}

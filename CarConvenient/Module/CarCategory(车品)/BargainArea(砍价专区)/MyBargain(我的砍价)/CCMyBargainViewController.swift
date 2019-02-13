//
//  CCMyGroupViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCMyBargainViewController: BaseViewController {

    @IBOutlet weak var xib_topBgView: UIView! {
        didSet {
            xib_topBgView.contentMode = .scaleAspectFill
            xib_topBgView.layer.contents = UIImage(named: "bg_img_bargain")?.cgImage
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "我的砍价"
    }


}

//
//  CCBargainDetailViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCBargainDetailViewController: BaseViewController {

    @IBOutlet weak var topBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "砍价详情"

        view.contentMode = .scaleAspectFill
        view.layer.contents = UIImage(named: "img_bargain_n")?.cgImage
    }

}

//
//  CCCooperationViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCCooperationViewController: BaseViewController {

    @IBOutlet weak var xib_nameBgView: UIView!  {
        didSet {
            xib_nameBgView.layer.borderWidth = 1
            xib_nameBgView.layer.borderColor = UIColor(rgba: "#DDDDDD").cgColor
        }
    }
    @IBOutlet weak var xib_phoneBgView: UIView! {
        didSet {
            xib_phoneBgView.layer.borderWidth = 1
            xib_phoneBgView.layer.borderColor = UIColor(rgba: "#DDDDDD").cgColor
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "招商加盟"
    }

}

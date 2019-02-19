//
//  CCActivityDetailViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/19.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCRidersClubDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "俱乐部详情"
    }

    @IBAction func btn_DidClicked(_ sender: UIButton) {
        let pv = CCApplyView.md_viewFromXIB() as! CCApplyView
        pv.autoresizingMask = .flexibleWidth
        HFAlertController.showCustomView(view: pv)
    }
}

//
//  CCPushSuccessViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/3/1.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCPushSuccessViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "富力盈凯店"
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        let config = MDAlertConfig()
        config.title = "  " 
        config.desc = "确认取消发布的洗车需求？"
        config.negativeTitle = "再等等"
        config.positiveTitle = "确定"
        config.negativeTitleColor = UIColor(rgba: "#4BB3F0")
        config.positiveTitleColor = UIColor(rgba: "#1B82D2")
        config.isShowCancel = true
        let alert = HFAlertController.alertController(config: config, ConfirmCallBack: {
            
        }, CancelCallBack: {})
        self.present(alert, animated: true, completion: nil)
    }
}

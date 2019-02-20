//
//  CCWashCarBillingViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/20.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCWashCarBillingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "代洗账单"
    }

    @IBAction func btn_DidClicked(_ sender: UIButton) {
        let pv = CCPayPopView.md_viewFromXIB() as! CCPayPopView
        pv.autoresizingMask = .flexibleWidth
        pv.frame = CGRect(origin: .zero, size: CGSize(width: pv.width, height: pv.height + SaveAreaHeight))
        HFAlertController.showCustomView(view: pv, type: HFAlertType.ActionSheet)
        
        // 监听键盘改变事件
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: nil) { (notify) in
            // 改变view的高度
            let keyBY = (notify.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! CGRect).origin.y
            let y = keyBY - SCREEN_HEIGHT - pv.height
            pv.top = SCREEN_HEIGHT + y
        }
        
        pv.clickBlock = {(sender) in
            if let pw = sender as? String {
                if pw.count != 6 {
                    SVProgressHUD.showInfo(withStatus: "请输入6位数字支付密码")
                }
            }
        }
    }
    
}

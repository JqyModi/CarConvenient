//
//  CCModifyPasswordByPhoneViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/24.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit
import SVProgressHUD

class CCModifyPasswordByPhoneViewController: BaseViewController {

    @IBOutlet weak var xib_phone: UITextField!  {
        didSet {
            xib_phone.changeCursorLeftDistance(distance: 20)
            xib_phone.verificationCode = true
            if let btn = xib_phone.rightView as? UIButton {
                btn.addTarget(self, action: #selector(sendCode), for: .touchUpInside)
            }
        }
    }
    @IBOutlet weak var xib_code: UITextField!{
        didSet {
            xib_code.changeCursorLeftDistance(distance: 20)
        }
    }
    @IBOutlet weak var xib_password: UITextField!{
        didSet {
            xib_password.changeCursorLeftDistance(distance: 20)
        }
    }
    @IBOutlet weak var xib_passwordTwo: UITextField!{
        didSet {
            xib_passwordTwo.changeCursorLeftDistance(distance: 20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        title = "修改登录密码"
    }
    
}
// MARK: - 发送验证码
extension CCModifyPasswordByPhoneViewController {
    @objc private func sendCode(sender: UIButton) {
        guard let phone = xib_phone.text else {
            SVProgressHUD.showInfo(withStatus: "请输入手机号码")
            return
        }
        
        //        "发送验证码测试".Log()
        AppEngine?.runGeneralTimerTimer(duration: 30, callback: { (time, _) in
            if time == 0 {
                sender.setTitle(NSLocalizedString("获取验证码", comment: ""), for: .normal)
                sender.isEnabled = true
                return
            }
            sender.setTitle("\(time)s", for: .normal)
            sender.isEnabled = false
        })
        
    }
}

//
//  CCRegisterViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/23.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit
import SVProgressHUD

class CCRegisterViewController: BaseViewController {

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
    @IBOutlet weak var xib_inviteCode: UITextField!{
        didSet {
            xib_inviteCode.changeCursorLeftDistance(distance: 20)
        }
    }
    @IBOutlet weak var xib_protocol: UIButton!  {
        didSet {
            let text = "点击注册并登录，代表您已同意《车便捷用户协议》"
            let ats = text.md_setLabelColorByCount(count: 14, leftColor: UIColor(rgba: "#333333"), rightColor: UIColor(rgba: "#0026FF"))
            xib_protocol.setAttributedTitle(ats, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



}
// MARK: - 发送验证码
extension CCRegisterViewController {
    @objc private func sendCode(sender: UIButton) {
        guard let phone = xib_phone.text else {
            SVProgressHUD.showInfo(withStatus: "请输入手机号码")
            return
        }
        
//        "发送验证码测试".Log()
        let pv = CCSendCodePopView.md_viewFromXIB() as! CCSendCodePopView
        pv.autoresizingMask = .flexibleWidth
        pv.showInfo = "发送验证码成功"
        HFAlertController.showCustomView(view: pv)
        
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

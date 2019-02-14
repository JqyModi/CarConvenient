//
//  CCLoginViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/23.
//  Copyright © 2019年 modi. All rights reserved.//
//

import UIKit

class CCLoginViewController: BaseViewController {

    @IBOutlet weak var xib_phone: UITextField! {
        didSet {
            xib_phone.changeCursorLeftDistance(distance: 20)
        }
    }
    @IBOutlet weak var xib_password: UITextField! {
        didSet {
            xib_password.changeCursorLeftDistance(distance: 20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func setupStyle() {
        super.setupStyle()
        
        title = "登录"
        addLeftItem(title: "", imageName: "global_btn_cancel_n", fontColor: Color.md_NavBarTintColor)
        addRightItem(title: "注册", imageName: "", fontColor: UIColor(rgba: "#23ADE5"))
    }
    
    override func clickLeft() {
        super.clickLeft()
        HFAppEngine.shared.gotoMainController()
    }
    
    override func clickRight(sender: UIButton) {
        super.clickRight(sender: sender)
        let vc = CCRegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - 忘记密码
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        let vc = CCForgetPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

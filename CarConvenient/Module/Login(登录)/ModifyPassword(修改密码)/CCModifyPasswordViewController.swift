//
//  CCModifyPasswordViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/24.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCModifyPasswordViewController: BaseViewController {
    
    @IBOutlet weak var xib_originPassword: UITextField!{
        didSet {
            xib_originPassword.changeCursorLeftDistance(distance: 20)
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

//
//  CCPersonalCenterHeaderView.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/29.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCPersonalCenterHeaderView: BaseView {

    @IBOutlet weak var xib_userInfoBgView: UIView! {
        didSet {
//            xib_userInfoBgView.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg_img_bargain")!)
            xib_userInfoBgView.contentMode = .scaleAspectFill
            xib_userInfoBgView.layer.contents = UIImage(named: "bg_img_bargain")?.cgImage
        }
    }
    
    @IBOutlet weak var xib_normalBgView: UIView!
    @IBOutlet weak var xib_loginBgView: UIView!
    
    @IBOutlet weak var xib_userMoneyBgView: UIView!
    @IBOutlet weak var xib_userMoneyBgViewH: NSLayoutConstraint!
    
    var headerViewH: CGFloat = SCREEN_WIDTH * ((104+104+112)/375) + 16
    
    /// 是否登录标记
    var markLogin: Bool = false {
        didSet {
            if markLogin {
                loginStyle()
            }else {
                normalStyle()
            }
            layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        markLogin = false
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        if let b = self.clickBlock {
            b(sender)
        }
    }
    

}
extension CCPersonalCenterHeaderView {
    private func loginStyle() {
        xib_loginBgView.isHidden = false
        xib_normalBgView.isHidden = true
        
        headerViewH += SCREEN_WIDTH*(119/375)
        xib_userMoneyBgViewH.constant = SCREEN_WIDTH*(119/375)
        xib_userMoneyBgView.isHidden = false
    }
    
    private func normalStyle() {
        xib_loginBgView.isHidden = true
        xib_normalBgView.isHidden = false
        
        xib_userMoneyBgViewH.constant = 0
        xib_userMoneyBgView.isHidden = true
    }
}

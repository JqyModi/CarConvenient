//
//  CCPayPopView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/20.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCPayPopView: BaseView {

    var pwv = MDPasswordView()
    
    @IBOutlet weak var passwordView: UIView! {
        didSet {
            let pw = MDPasswordView.md_viewFromXIB() as! MDPasswordView
            pw.autoresizingMask = .flexibleWidth
            pwv = pw
            passwordView.addSubview(pw)
            pw.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        if sender.tag == 10001 {
            if let sv = self.superview {
                sv.removeFromSuperview()
            }
        }else {
            if let b = clickBlock {
                b(pwv.pwTF.text)
            }
        }
    }
    
}

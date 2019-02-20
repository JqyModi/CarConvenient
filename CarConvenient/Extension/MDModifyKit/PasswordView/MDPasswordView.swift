//
//  MDPasswordView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/20.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

@IBDesignable
class MDPasswordView: BaseView {
    
    var keyboardShow: Bool = true {
        didSet {
            if keyboardShow {
                pwTF.becomeFirstResponder()
            }else {
                pwTF.resignFirstResponder()
            }
        }
    }
    
    /// 密码颜色
    var pwDotColor: UIColor = UIColor.black

    @IBOutlet weak var pwTF: UITextField!
    
    @IBOutlet var dots: [UIView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        keyboardShow = true
        pwTF.isHidden = true
//        pwTF.keyboardType = .decimalPad
        pwTF.delegate = self
        
        for item in dots {
            item.backgroundColor = pwDotColor
        }
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        self.keyboardShow = !self.keyboardShow
    }
}
extension MDPasswordView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location > 5 {
            let subString = textField.text! as NSString
            textField.text = subString.substring(to: 6)
            return false
        }
        // 隐藏或者显示当前的点
        if string != "" {
            dots[range.location].isHidden = false
        }else {
            dots[range.location].isHidden = true
        }
        return true
    }
}

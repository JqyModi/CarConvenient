//
//  CCSendCodePopView.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/24.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCSendCodePopView: BaseView {

    @IBOutlet weak var xib_text: UILabel!
   
    var showInfo: String = "操作成功" {
        didSet {
            xib_text.text = showInfo
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.bounds = CGRect(origin: .zero, size: CGSize(width: SCREEN_WIDTH-175, height: 44))
        xib_text.text = showInfo
    }
}

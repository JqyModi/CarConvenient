//
//  LTWebViewController.swift
//  LT
//
//  Created by Modi on 2018/7/9.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit
import SVProgressHUD

enum WebFromType {
    case FromPostProject, FromPayMember, none
}

class LTWebViewController: HFWebViewController {

    var fromType: WebFromType = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showInfo()
        
        /// 测试富文本
        let reStr = "<section class=\"_editor\">\r\n    <p style=\"text-align: center;\">\r\n        <img src=\"http://newcdn.96weixin.com/mmbiz.qlogo.cn/mmbiz_gif/Ljib4So7yuWjcdqu442ReJV66YBRzzZ2JicDJsXftBrJ4TkT7ULbLFcibrXH6KNEfMv54ZL0IEneAnB9qFC9ZU9Cw/640?wx_fmt=gif\"/>\r\n    </p>\r\n</section>\r\n<section class=\"_editor\">\r\n    <section style=\"overflow:hidden;\">\r\n        <section style=\"width: 20px; height: 20px; border-top: 2px solid rgb(216, 40, 33); border-left: 2px solid rgb(216, 40, 33); display: inline-block; float: left; box-sizing: border-box;\"></section>\r\n        <section style=\"width: 20px; height: 20px; border-top: 2px solid rgb(216, 40, 33); border-right: 2px solid rgb(216, 40, 33); display: inline-block; float: right; box-sizing: border-box;\"></section>\r\n    </section>\r\n    <section style=\"border: 2px dotted rgb(216, 40, 33); margin: -20px 0px; padding: 15px; box-sizing: border-box;\">\r\n        <section></section>\r\n        <section style=\"color:#444;line-height:25px;text-align: justify;letter-spacing: 2px;\">\r\n            <p style=\"font-size: 14px;\">\r\n                阳光下蜻蜓飞过来,一片片绿油油的稻田 水彩蜡笔和万花筒,画不出天边那一条彩虹,什么时候才能像高年级的同学,有张成熟与长大的脸,盼望着假期,盼望着明天,盼望长大的童年 一天又一天,一年又一年,盼望长大的童年。\r\n            </p>\r\n        </section>\r\n    </section>\r\n    <section style=\"overflow:hidden;\">\r\n        <section style=\"width: 20px; height: 20px; border-left: 2px solid rgb(216, 40, 33); border-bottom: 2px solid rgb(216, 40, 33); display: inline-block; float: left; box-sizing: border-box;\"></section>\r\n        <section style=\"width: 20px; height: 20px; border-right: 2px solid rgb(216, 40, 33); border-bottom: 2px solid rgb(216, 40, 33); display: inline-block; float: right; box-sizing: border-box;\"></section>\r\n    </section>\r\n</section>\r\n<p></p>"
        
        let reStr1 = "<p><img src=\"http://test.catrongzi.com/uploads/ueditor/php/upload/image/20180614/1528944014596403.png\" title=\"1528944014596403.png\" alt=\"1-14.png\" width=\"645\" height=\"445\" style=\"width: 645px; height: 445px;\"/><br/></p><p><span style=\"color: rgb(102, 102, 102);\">京东平台卖家销售并发货的商品，由平台卖家提供发票和相应的售后服务。请您放心购买！</span><br/></p><p><span style=\"color: rgb(102, 102, 102); font-family: tahoma, arial, \" microsoft=\"\" hiragino=\"\" sans=\"\" font-size:=\"\" background-color:=\"\">注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！</span></p><p><img src=\"http://test.catrongzi.com/uploads/ueditor/php/upload/image/20180614/1528944023481404.png\" title=\"1528944023481404.png\" alt=\"1-15.png\" width=\"641\" height=\"441\" style=\"width: 641px; height: 441px;\"/><br/></p>"
        
//        self.HTMLStr = reStr1
//        super.loadHTMLString()
    }
    
    private func showInfo() {
        switch fromType {
        case .FromPostProject:
            self.title = "发布项目须知"
//            MyCent?.requestProjectInstruction(complete: { (isSucceed, msg, content) in
//                switch isSucceed {
//                case true:
//                    self.HTMLStr = content
//                    super.loadHTMLString()
//                    break
//                case false:
//                    SVProgressHUD.showError(withStatus: msg)
//                    break
//                }
//            })
            break
        case .FromPayMember:
            self.title = "会员特权"
//            MyCent?.requestMemberPrivilege(complete: { (isSucceed, msg, content) in
//                switch isSucceed {
//                case true:
//                    self.HTMLStr = content
//                    super.loadHTMLString()
//                    break
//                case false:
//                    SVProgressHUD.showError(withStatus: msg)
//                    break
//                }
//            })
            break
        default:
            break
        }
    }

}

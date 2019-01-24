//
//  LTLocationBottomView.swift
//  LT
//
//  Created by Modi on 2018/7/8.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit

class LTLocationBottomView: BaseHeaderView {

    @IBOutlet weak var xib_Title: UILabel!
    @IBOutlet weak var xib_Desc: UILabel!
    @IBOutlet weak var xib_Ok: UIButton!
    
    var model: LocationFromType = .none {
        didSet {
            switch model {
            case let .FromHome(btnTitle: title, addr: address):
                setupShow(title: title, address: address)
                break
            case let .FromMaterialDetail(btnTitle: title, addr: address):
                xib_Title.text = "店铺位置"
                setupShow(title: title, address: address)
                break
            case let .FromPushPro(btnTitle: title, addr: address):
                setupShow(title: title, address: address)
                break
            case let .FromConfirmWorker(btnTitle: title, addr: address):
                setupShow(title: title, address: address)
                break
            case let .FromConfirmBoss(btnTitle: title, addr: address):
                setupShow(title: title, address: address)
                break
            default:
                break
            }
        }
    }
    
    private func setupShow(title: String, address: String) {
        xib_Desc.text = address
        xib_Ok.setTitle(title, for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xib_Title.text = "我的位置"
    }
    
    @IBAction func xib_Ok(_ sender: UIButton) {
        if let b = clickBlock {
            switch model {
            case .FromHome(btnTitle: _, addr: _):
                sender.tag = 10001
                break
            case .FromMaterialDetail(btnTitle: _, addr: _):
                sender.tag = 10002
                break
            case .FromPushPro(btnTitle: _, addr: _):
                sender.tag = 10003
                break
            case .FromConfirmWorker(btnTitle: _, addr: _):
                sender.tag = 10004
                break
            case .FromConfirmBoss(btnTitle: _, addr: _):
                sender.tag = 10005
                break
            default:
                break
            }
            b(sender)
        }
    }
}

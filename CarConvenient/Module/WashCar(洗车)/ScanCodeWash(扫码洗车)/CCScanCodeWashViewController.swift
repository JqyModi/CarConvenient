//
//  CCScanCodeWashViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/20.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCScanCodeWashViewController: BaseViewController {

    @IBOutlet weak var navView: UIView! {
        didSet {
            navView.layer.borderWidth = 1
            navView.layer.borderColor = UIColor(rgba: "#DDDDDD").cgColor
            navView.layer.cornerRadius = 20
            navView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var scanView: UIView! {
        didSet {
            scanView.viewClipCornerDirection(radius: 98, direct: clipCornerDirection.top, fillColor: UIColor(rgba: "#1B82D2"))
        }
    }
    
    @IBOutlet weak var navBgView: UIView! {
        didSet {
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
            swipeGesture.direction = .down
            navBgView.addGestureRecognizer(swipeGesture)
        }
    }
    
    @objc private func swipeDown() {
        HFAppEngine.shared.gotoMainController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /// 点击导航右按钮
    @objc override func clickRight(sender: UIButton) {
        // 添加左右按钮
        let vc = CCMessageOutSideViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 点击导航右按钮
    @objc override func clickLeft() {
        // 添加左右按钮
        let vc = CCPersonalCenterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        switch sender.tag {
        case 10001:
            self.clickLeft()
            break
        case 10002:
            let vc = CCSelectCarViewController.init(nibName: "CCSelectCarViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 10003:
            self.clickRight(sender: sender)
            break
        case 10004:
            break
        case 10005:
            let vc = ScanViewController.init(nibName: "ScanViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 10006:
            break
        default:
            break
        }
    }
}

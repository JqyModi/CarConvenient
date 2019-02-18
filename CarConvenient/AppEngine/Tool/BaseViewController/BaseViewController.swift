//
//  BaseViewController.swift
//  MingChuangWine
//
//  Created by Modi on 2018/6/5.
//  Copyright © 2018年 江启雨. All rights reserved.
//

import UIKit
import Alamofire

class BaseViewController: UIViewController, PlaceholderViewDelegate {
    
    /// 是否隐藏导航栏 - 默认不隐藏
    open var hiddenNavBar:Bool = false {
        didSet{
            if hiddenNavBar {
                navigationController?.setNavigationBarHidden(true, animated: true)
            }else {
                navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    }
    
    /// 导航栏title颜色
    open var titleColor:UIColor = UIColor.white {
        didSet{
            let dict:NSDictionary = [NSAttributedStringKey.foregroundColor:UIColor.white,NSAttributedStringKey.font :UIFont.boldSystemFont(ofSize: 18)]
            navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey:AnyObject]
            
        }
    }
    
    /// 导航栏设置字体颜色 - 默认 18
    open var titleSize : CGFloat = 18 {
        didSet{
            let dict:NSDictionary = [NSAttributedStringKey.foregroundColor:UIColor.white,NSAttributedStringKey.font :UIFont.boldSystemFont(ofSize: titleSize)]
            navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey:AnyObject]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupStyle()
    }

    open func setupStyle() {
        // 添加左右按钮
        if let vcs = self.navigationController?.viewControllers {
            if vcs.count > 1 {
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "global_btn_return_n"), style: .plain, target: self, action: #selector(clickBack))
            }else {
                addLeftItem(title: "", imageName: "btn_my_n1", fontColor: Color.md_NavBarTintColor)
                addRightItem(title: "", imageName: "btn_system_n1", fontColor: Color.md_NavBarTintColor)
            }
        }
       
    }
    
    /// 返回
    @objc func clickBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 设置导航栏左按钮
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - imageName: 图片
    func addRightItem(title:String,selectTitle: String = "",imageName:String = "",fontColor: UIColor = UIColor.white) {
//        let rightButton = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(clickRight))
//        let dic = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)]
//        rightButton.setTitleTextAttributes(dic, for: .normal)
//        rightButton.setTitleTextAttributes(dic, for: .highlighted)
//        rightButton.tintColor = fontColor
//        rightButton.image = UIImage.init(named: imageName)
//        self.navigationItem.rightBarButtonItem = rightButton
        
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitle(title, for: UIControlState.normal)
        btn.setTitle(selectTitle, for: .selected)
        btn.setTitleColor(fontColor, for: UIControlState.normal)
        btn.setTitleColor(fontColor, for: UIControlState.selected)
        btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(clickRight(sender:)), for: .touchUpInside)
        
        let rightButton = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    /// 点击导航右按钮
    @objc func clickRight(sender: UIButton) {
        // 添加左右按钮
        if let vcs = self.navigationController?.viewControllers {
            if vcs.count == 1 {
                let vc = CCMessageOutSideViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    /// 设置导航栏左按钮
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - imageName: 图片
    func addLeftItem(title:String,imageName:String,fontColor: UIColor = UIColor.white) {
//        let leftButton = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(clickLeft))
//        let dic = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)]
//        leftButton.setTitleTextAttributes(dic, for: .normal)
//        leftButton.setTitleTextAttributes(dic, for: .highlighted)
//        leftButton.tintColor = fontColor
//        leftButton.image = UIImage.init(named: imageName)
        
//        let leftButton = UIBarButtonItem(image: UIImage(named: imageName), style: UIBarButtonItemStyle.done, target: self, action: #selector(clickLeft))
//        leftButton.tintColor = UIColor.black
        
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitle(title, for: UIControlState.normal)
        btn.setTitleColor(fontColor, for: UIControlState.normal)
        btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(clickLeft), for: .touchUpInside)
        
        let leftButton = UIBarButtonItem(customView: btn)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
    /// 点击导航右按钮
    @objc func clickLeft() {
        // 添加左右按钮
        if let vcs = self.navigationController?.viewControllers {
            if vcs.count == 1 {
                let vc = CCPersonalCenterViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    //设置状态栏颜色
    @objc open func setStatusBarBackgroundColor(color: UIColor) {
        let statusBarView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar = statusBarView.value(forKey: "statusBar") as! UIView
        
        statusBar.backgroundColor = color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let net = NetworkReachabilityManager()
        if net?.isReachable ?? false {
            for view in self.view.subviews {
                if view.isKind(of: PlaceholderView.self) {
                    view.removeFromSuperview()
                }
            }
        }else {
            self.showNoNetworkView()
        }

    }
    
    func showNoNetworkView() {
        let noNetworkView = PlaceholderView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 49))
        noNetworkView.delegate = self
        self.view.addSubview(noNetworkView)
    }

    func requestData() {
        debugPrint("base reloadData ~")
    }
}
extension BaseViewController {
    
}

extension UIViewController {
    
    func showAlerView(showView:UIView,layoutType:PopupLayoutType = .center){
        self.sl_popupController = SnailPopupController()
        self.sl_popupController.layoutType = layoutType //default center
        self.sl_popupController.transitStyle = .default//default
        self.sl_popupController.allowPan = true //default = NO
        self.sl_popupController.presentContentView(showView, duration: 0.75, elasticAnimated: true)
    }
    
}

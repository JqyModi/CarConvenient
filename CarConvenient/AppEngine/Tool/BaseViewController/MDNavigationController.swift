//
//  HWNavigationController.swift
//  HandWriting
//
//  Created by mac on 17/9/11.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class MDNavigationController: UINavigationController {
    
    var rightClickBlock: RightItemClickedHandler?
    
    typealias RightItemClickedHandler =  (() -> Void)?
    
    convenience init(vc: UIViewController) {
        self.init(rootViewController: vc)
        //配置导航栏样式
        self.setupNavgationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /// 配置导航栏样式
    private func setupNavgationBar() {
        
        self.navigationBar.isTranslucent = false
        
        let bar = UINavigationBar.appearance()
        bar.barTintColor = Color.md_NavBarBgColor
        bar.tintColor = Color.md_NavBarTintColor
        bar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Color.md_TitleColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: FontSize.md_NavBarFontSize)]
        let line:UIImage = UIImage(color: Color.md_NavBarBgColor, size: CGSize(width: 500, height: 1))!
        bar.shadowImage = line;
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-100, 0), for:UIBarMetrics.default)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            self.interactivePopGestureRecognizer?.delegate = self
            self.interactivePopGestureRecognizer?.isEnabled = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "global_btn_return_n"), style: .plain, target: self, action: #selector(navigationBackClick))
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    @objc func navigationBackClick() {
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        popViewController(animated: true)
    }
    
    /// 设置导航栏左按钮
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - imageName: 图片
    func addRightItem(title:String,imageName:String) {
        let rightButton = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(clickRight))
        let dic = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)]
        rightButton.setTitleTextAttributes(dic, for: .normal)
        rightButton.setTitleTextAttributes(dic, for: .highlighted)
        rightButton.tintColor = UIColor.white
        rightButton.image = UIImage.init(named: imageName)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    
    /// 点击导航右按钮
    @objc func clickRight() {
        if let b = rightClickBlock {
            b!()
        }
    }
    
    /// 设置导航栏右按钮
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - imageName: 图片
    func addLeftItem(title:String,imageName:String) {
        self.interactivePopGestureRecognizer?.delegate = self
        self.interactivePopGestureRecognizer?.isEnabled = true
        let leftButton = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(navigationBackClick))
        let dic = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)]
        leftButton.setTitleTextAttributes(dic, for: .normal)
        leftButton.setTitleTextAttributes(dic, for: .highlighted)
        leftButton.tintColor = UIColor.white
        leftButton.image = UIImage.init(named: imageName)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    /// 点击导航左按钮
    @objc func clickLeft() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var shouldAutorotate: Bool{
        get{
            return false
        }
    }

}

extension MDNavigationController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count == 1 {
            return false
        }else{
            return true
        }
    }
}

extension MDNavigationController {
    ///自动隐藏BottomBar
    /*
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count >= 1{
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
        
        if self.childViewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = false
        }
    }
    */
}

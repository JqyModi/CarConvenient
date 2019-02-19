//
//  CCGroupViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/19.
//  Copyright © 2019年 modi. All rights reserved.
//

/*
import UIKit

class CCGroupViewController: UITabBarController {

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
    func addNavItem(title:String = "",imageName:String = "",fontColor: UIColor = UIColor.white, position: Int = 0) {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitle(title, for: UIControlState.normal)
        btn.setTitleColor(fontColor, for: UIControlState.normal)
        btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(clickLeft), for: .touchUpInside)

        if position == 0 {
            let leftButton = UIBarButtonItem(customView: btn)
            self.navigationItem.leftBarButtonItem = leftButton
        }else {
            let rightButton = UIBarButtonItem(customView: btn)
            self.navigationItem.rightBarButtonItem = rightButton
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupStyle()
        // Do any additional setup after loading the view.
        self.addChildViewController(CCCarGroupViewController())
        self.addChildViewController(CCRidersClubOutSideViewController())
        self.addChildViewController(CCActivityGroupViewController())
        self.selectedIndex = 0
    }

    private func setupStyle() {

        // 添加左右按钮
        addNavItem(title: "", imageName: "btn_my_n1", fontColor: Color.md_NavBarTintColor, position: 0)
        addNavItem(title: "", imageName: "btn_system_n1", fontColor: Color.md_NavBarTintColor, position: 1)

        // 隐藏tabbar
        self.tabBar.frame = CGRect(origin: .zero, size: .zero)
        self.isHiddenTabbar = true

        let tb = UITabBar(frame: .zero)
        setValue(tb, forKeyPath: "tabBar")
        self.tabBar.superview?.removeFromSuperview()

        let nav = CCCarGroupNavView.md_viewFromXIB() as! CCCarGroupNavView
        nav.autoresizingMask = .flexibleWidth
        self.navigationItem.titleView = nav

        nav.clickBlock = {(sender) in
            if let sgm = sender as? UISegmentedControl {
                self.selectedIndex = sgm.selectedSegmentIndex
            }
        }
    }

}
extension UITabBarController {
    var isHiddenTabbar: Bool {
        get {
            return false
        }
        set {
            if newValue {
                // 隐藏tabbar
                tabBar.removeFromSuperview()
            }
        }
    }
}
*/

import UIKit
import LTScrollView

class CCGroupViewController: BaseViewController {
    
    private lazy var viewControllers: [UIViewController] = {
        var vcs = [UIViewController]()
        vcs.append(CCCarGroupViewController())
        vcs.append(CCRidersClubOutSideViewController())
        vcs.append(CCActivityGroupViewController())
        return vcs
    }()
    
    private lazy var titles: [String] = {
        return ["车友圈", "俱乐部", "活动群"]
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.sliderHeight = 0
        layout.showsHorizontalScrollIndicator = false
        return layout
    }()
    
    private lazy var pageView: LTPageView = {
        let H: CGFloat = (SCREEN_HEIGHT - NavBarHeight - TabBarHeight)
        let pageView = LTPageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: H), currentViewController: self, viewControllers: viewControllers, titles: titles, layout: layout)
        pageView.isClickScrollAnimation = true
        return pageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pageView)
        
        pageView.didSelectIndexBlock = {(_, index) in
            print("pageView.didSelectIndexBlock", index)
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        let nav = CCCarGroupNavView.md_viewFromXIB() as! CCCarGroupNavView
        nav.autoresizingMask = .flexibleWidth
        self.navigationItem.titleView = nav

        nav.clickBlock = {(sender) in
            if let sgm = sender as? UISegmentedControl {
                self.pageView.scrollToIndex(index: sgm.selectedSegmentIndex)
            }
        }
    }
}


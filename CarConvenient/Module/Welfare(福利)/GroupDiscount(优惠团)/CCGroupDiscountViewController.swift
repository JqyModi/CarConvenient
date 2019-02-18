//
//  CCGroupDiscountViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/15.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit
import LTScrollView

class CCGroupDiscountViewController: BaseViewController {

    private lazy var viewControllers: [UIViewController] = {
        var vcs = [UIViewController]()
        vcs.append(CCInvitationViewController())
        vcs.append(CCMyTeamViewController())
        return vcs
    }()
    
    private lazy var titles: [String] = {
        return ["邀请成团", "我的团队"]
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.sliderWidth = 30
        layout.titleMargin = 5.0
        layout.titleFont = UIFont.systemFont(ofSize: 14)
        layout.titleColor = UIColor.init(rgba: "#333333")
        layout.titleSelectColor = UIColor.init(rgba: "#1B82D2")
        layout.titleViewBgColor = UIColor.white
        layout.bottomLineColor = UIColor(rgba: "#1B82D2")
        layout.bottomLineHeight = 1
        // （屏幕宽度 - 标题总宽度 - 标题间距宽度） / 2 = 最左边以及最右边剩余
        let lrMargin = (view.bounds.width - (CGFloat(titles.count) * layout.sliderWidth + CGFloat(titles.count - 1) * layout.titleMargin)) * 0.5
        layout.lrMargin = lrMargin
        layout.lrMargin = 8
        layout.isAverage = true
        layout.showsHorizontalScrollIndicator = false
        return layout
    }()
    
    private lazy var pageView: LTPageView = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let tabbarH: CGFloat = 0
        let Y: CGFloat = statusBarH + 44 + tabbarH
        let H: CGFloat = IPHONEX ? (SCREEN_HEIGHT - Y - 34) : (SCREEN_HEIGHT - Y)
        let pageView = LTPageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: H), currentViewController: self, viewControllers: viewControllers, titles: titles, layout: layout)
        pageView.isClickScrollAnimation = true
        return pageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "优惠团"
        
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pageView)
        
        pageView.didSelectIndexBlock = {(_, index) in
            print("pageView.didSelectIndexBlock", index)
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        addRightItem(title: "成团规则", fontColor: UIColor(rgba: "#1B82D2"))
    }
    
    override func clickRight(sender: UIButton) {
        super.clickRight(sender: sender)
        
        let vc = CCTeamRuleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

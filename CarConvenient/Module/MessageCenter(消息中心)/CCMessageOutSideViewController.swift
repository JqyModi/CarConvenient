//
//  CCMessageOutSideViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/14.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit
import LTScrollView

class CCMessageOutSideViewController: BaseViewController {

    private lazy var viewControllers: [UIViewController] = {
        var vcs = [UIViewController]()
        vcs.append(CCMessageViewController())
        vcs.append(CCMessageViewController())
        vcs.append(CCMessageViewController())
        return vcs
    }()
    
    private lazy var titles: [String] = {
        return ["优惠活动", "订单助手", "系统消息"]
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
        return layout
    }()
    
    private lazy var pageView: LTPageView = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let tabbarH: CGFloat = 44
        let Y: CGFloat = statusBarH + 44 + tabbarH
        let H: CGFloat = IPHONEX ? (SCREEN_HEIGHT - Y - 34) : (SCREEN_HEIGHT - Y)
        let pageView = LTPageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: H), currentViewController: self, viewControllers: viewControllers, titles: titles, layout: layout)
        pageView.isClickScrollAnimation = true
        return pageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "账单明细"
        
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pageView)
        
        pageView.didSelectIndexBlock = {(_, index) in
            print("pageView.didSelectIndexBlock", index)
        }
    }
}

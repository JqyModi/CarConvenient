//
//  CCWashCarOutSideViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/19.
//  Copyright © 2019年 modi. All rights reserved.
//

/*
import UIKit
import LTScrollView

class CCWashCarOutSideViewController: BaseViewController {

    private lazy var viewControllers: [UIViewController] = {
        var vcs = [UIViewController]()
        vcs.append(CCWashCarViewController())
        vcs.append(CCWashCarViewController())
        vcs.append(CCWashCarViewController())
        return vcs
    }()
    
    private lazy var titles: [String] = {
        return ["全部", "不可预约", "可预约"]
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.sliderWidth = 30
        layout.sliderHeight = 40
        layout.titleMargin = 5.0
        layout.titleFont = UIFont.systemFont(ofSize: 14)
        layout.titleColor = UIColor.init(rgba: "#333333")
        layout.titleSelectColor = UIColor.init(rgba: "#23ADE5")
        layout.titleViewBgColor = UIColor.white
        layout.bottomLineColor = UIColor(rgba: "#23ADE5")
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
        let H: CGFloat = (SCREEN_HEIGHT - NavBarHeight - TabBarHeight)
        let pageView = LTPageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: H), currentViewController: self, viewControllers: viewControllers, titles: titles, layout: layout)
        pageView.backgroundColor = UIColor.red
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
}
*/
import UIKit
import LTScrollView

class CCWashCarOutSideViewController: BaseViewController {
    
    private let headerHeight: CGFloat = 180.0
    
    private lazy var viewControllers: [UIViewController] = {
        var vcs = [UIViewController]()
        vcs.append(CCWashCarViewController())
        vcs.append(CCWashCarViewController())
        vcs.append(CCWashCarViewController())
        return vcs
    }()
    
    private lazy var titles: [String] = {
        return ["全部", "不可预约", "可预约"]
    }()
    
    private lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: headerHeight))
        return headerView
    }()
    
    private lazy var headerImageView: UIView = {
        let hv = CCWashCarHeaderView.md_viewFromXIB() as! CCWashCarHeaderView
        hv.autoresizingMask = .flexibleWidth
        
        hv.clickBlock = {(sender) in
            if let btn = sender as? UIButton {
                switch btn.tag {
                case 10001: // 地区选择
                    let vc = MCSelectLocalController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 10002: // 搜索
                    let vc = CCSearchViewController.init(nibName: "CCSearchViewController", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    break
                }
            }
        }
        return hv
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.sliderWidth = 30
        layout.sliderHeight = 40
        layout.titleMargin = 5.0
        layout.titleFont = UIFont.systemFont(ofSize: 14)
        layout.titleColor = UIColor.init(rgba: "#333333")
        layout.titleSelectColor = UIColor.init(rgba: "#23ADE5")
        layout.titleViewBgColor = UIColor.white
        layout.bottomLineColor = UIColor(rgba: "#23ADE5")
        layout.bottomLineHeight = 1
        // （屏幕宽度 - 标题总宽度 - 标题间距宽度） / 2 = 最左边以及最右边剩余
        let lrMargin = (view.bounds.width - (CGFloat(titles.count) * layout.sliderWidth + CGFloat(titles.count - 1) * layout.titleMargin)) * 0.5
        layout.lrMargin = lrMargin
        layout.lrMargin = 8
        layout.isAverage = true
        layout.showsHorizontalScrollIndicator = false
        return layout
    }()
    
    private lazy var simpleManager: LTSimpleManager = {
        let Y: CGFloat = 0.0
        let H: CGFloat = view.bounds.height - NavBarHeight - TabBarHeight
        let simpleManager = LTSimpleManager(frame: CGRect(x: 0, y: Y, width: view.bounds.width, height: H), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout)
        
        /* 设置悬停位置 */
        simpleManager.hoverY = NavBarHeight
        
        return simpleManager
    }()
    
    var statusBarStyle: UIStatusBarStyle = .lightContent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(simpleManager)
        simpleManagerConfig()
    }
    
    deinit {
        print("LTSimpleManagerDemo < --> deinit")
    }
}


extension CCWashCarOutSideViewController {
    
    //MARK: 具体使用请参考以下
    private func simpleManagerConfig() {
        //MARK: headerView设置
        simpleManager.configHeaderView {[weak self] in
            guard let strongSelf = self else { return nil }
            strongSelf.headerView.addSubview(strongSelf.headerImageView)
            return strongSelf.headerView
        }
        
        //MARK: pageView点击事件
        simpleManager.didSelectIndexHandle { (index) in
            print("点击了 \(index) 😆")
        }
        
    }
}


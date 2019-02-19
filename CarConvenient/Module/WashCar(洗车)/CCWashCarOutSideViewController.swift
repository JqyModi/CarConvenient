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
import MJRefresh
import LTScrollView

class CCWashCarOutSideViewController: BaseViewController {
    
    private let headerHeight: CGFloat = 180.0
    //防止侧滑的时候透明度变化
    private var currentProgress: CGFloat = 0.0
    private let navHeight: CGFloat = UIApplication.shared.statusBarFrame.height + 44
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.alpha = currentProgress
//        navigationController?.navigationBar.barTintColor = UIColor.white
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18.0)]
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.barStyle = .default
//        navigationController?.navigationBar.alpha = 1.0
//    }
    
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
        let H: CGFloat = IPHONEX ? (view.bounds.height - 34) : view.bounds.height
        let simpleManager = LTSimpleManager(frame: CGRect(x: 0, y: Y, width: view.bounds.width, height: H), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout)
        simpleManager.backgroundColor = UIColor.red
        
        /* 设置代理 监听滚动 */
//        simpleManager.delegate = self
        
        /* 设置悬停位置 */
        simpleManager.hoverY = navHeight
        
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
    
    @objc private func tapLabel(_ gesture: UITapGestureRecognizer)  {
        print("tapLabel☄")
    }
}
/*
extension CCWashCarOutSideViewController: LTSimpleScrollViewDelegate {
    
    //MARK: 滚动代理方法
    func glt_scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        var headerImageViewY: CGFloat = offsetY
        var headerImageViewH: CGFloat = headerHeight - offsetY
        if offsetY <= 0.0 {
            navigationController?.navigationBar.alpha = 0
            currentProgress = 0.0
        }else {
            
            headerImageViewY = 0
            headerImageViewH = headerHeight
            
            let adjustHeight: CGFloat = headerHeight - navHeight
            let progress = 1 - (offsetY / adjustHeight)
            //设置状态栏
            navigationController?.navigationBar.barStyle = progress > 0.5 ? .black : .default
            
            //设置导航栏透明度
            navigationController?.navigationBar.alpha = 1 - progress
            currentProgress = 1 - progress
            
        }
        headerImageView.frame.origin.y = headerImageViewY
        headerImageView.frame.size.height = headerImageViewH
    }
    
    //MARK: 控制器刷新事件代理方法
    func glt_refreshScrollView(_ scrollView: UIScrollView, _ index: Int) {
        //注意这里循环引用问题。
        scrollView.mj_header = MJRefreshNormalHeader {[weak scrollView] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                print("对应控制器的刷新自己玩吧，这里就不做处理了🙂-----\(index)")
                scrollView?.mj_header.endRefreshing()
            })
        }
    }
}
*/

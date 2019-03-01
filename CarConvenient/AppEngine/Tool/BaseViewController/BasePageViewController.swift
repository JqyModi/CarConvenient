//
//  STPageViewController.swift
//  LotteryWinner
//
//  Created by suteer on 2019/2/28.
//  Copyright © 2019 suteer. All rights reserved.
//

import UIKit
import SnapKit

class BasePageViewController: BaseViewController {
    
    private var titles : [String]?
    private var viewControllers : [UIViewController] = Array()
    
    var delegate : STPageDelegate?
    
    private var currentIndex: Int = 0
    
    ///跳转其他控制器
    func pageToViewController(index:Int) {
        var direction = UIPageViewControllerNavigationDirection.forward
        if index > currentIndex {
            direction = .reverse
        }
        pageVC.setViewControllers([viewControllers[index]], direction: direction, animated: true, completion: nil)
    }
    
    init(Titles:[String],vc:[UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        titles = Titles
        viewControllers = vc   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addChildViewController(pageVC)
        view.addSubview(pageVC.view)
        view.addSubview(titleToolView)

        aulaout()
        
        setTitleToolView()
    }
    
   private func aulaout() {
        titleToolView.snp.makeConstraints { (make:ConstraintMaker!) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }
        pageVC.view.snp.makeConstraints { (make:ConstraintMaker!) in
            make.top.equalTo(titleToolView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    private func setTitleToolView(){
        
        if delegate == nil {
            titleToolView.addSubview(viewSegment)
        }else{
            let Segment = delegate!.pageViewControllerToolView()
            titleToolView.addSubview(Segment)
            
            if  let hei = delegate!.pageViewControllerToolViewHeight?() { 
                titleToolView.snp.updateConstraints { (make:ConstraintMaker!) in
                   make.height.equalTo(hei) 
              }
            }
            
            Segment.snp.makeConstraints { (make:ConstraintMaker!) in
                make.top.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        } 
    }
    
    lazy var titleToolView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        return view
    }()
    
    lazy var pageVC : UIPageViewController = {
        let page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        page.dataSource = self
        page.delegate = self
        page.setViewControllers([viewControllers.first!], direction: .forward, animated: true, completion: nil)
        return page
    }()
    
    lazy var viewSegment : FYLSegmentView = {
       let segment = FYLSegmentView(titles: self.titles)
        segment!.delegate = self
        return segment!
    }()
    
}

//MARK:---UIPageViewControllerDataSource,UIPageViewControllerDelegate
extension BasePageViewController :UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    //MARK:---UIPageViewControllerDataSource
    //上一个
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index : Int = viewControllers.index(of: viewController)!
        
        if index == 0 {
            return nil
        }
        index -= 1
        currentIndex = index
        return viewControllers[index]
    }
    //下一个
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index : Int = viewControllers.index(of: viewController)!
        index += 1 
        if index == viewControllers.count  {
            return nil
        }
        currentIndex = index
        return viewControllers[index]
    } 
    
    //MARK:---UIPageViewControllerDelegate
//    func pageViewControllerPreferredInterfaceOrientationForPresentation(_ pageViewController: UIPageViewController) -> UIInterfaceOrientation {
//        return .portrait
//    }
    ///开始翻页
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let index = viewControllers.index(of:pendingViewControllers.first!)
        print("开始翻页:",index!)
        if delegate == nil {
            viewSegment.setOffsetOfIndex(0, withCurrentIndex: index!)
        }
    }
    
    /// 翻页完成调用
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let index = viewControllers.index(of:pageViewController.viewControllers!.first!)
        print("翻页完成调用:",index!)
    }
    
}



//MARK:---FYLSegmentViewDelegate
extension BasePageViewController : FYLSegmentViewDelegate {

    func fylSegmentView(_ segmentView: FYLSegmentView!, didClickTagAt index: Int) {
        pageToViewController(index: index)
        viewSegment.setOffsetOfIndex(0, withCurrentIndex: index)
    }

}

//MARK:---设置导航View
@objc protocol STPageDelegate{
    ///设置导航View
    func pageViewControllerToolView()->UIView
    @objc optional func pageViewControllerToolViewHeight()->Int
}

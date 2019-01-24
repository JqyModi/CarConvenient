//
//  HFWebViewController.swift
//  SmallTradePlatform
//
//  Created by baibeimini on 16/11/23.
//  Copyright © 2016年 pmec. All rights reserved.
//

import UIKit
//import MBProgressHUD
//import NJKWebViewProgress
import SVProgressHUD
import WebKit

@objc enum HFWebViewEnter: NSInteger {
    case push
    case present
}

protocol HFWebViewControllerDelegate: class {
    

    
   func webViewControllerDidStartLoad(_ webView: WKWebView)
    
   func webViewControllerDidFinishLoad(_ webView: WKWebView)
    
   func webViewController(_ webView: WKWebView, shouldStartLoadWithRequest request: URLRequest) -> Bool
    
   func webViewController(_ webView: WKWebView, didFailLoadWithError error: NSError?)

}

open class HFWebViewController: UIViewController , UINavigationBarDelegate, UIGestureRecognizerDelegate, WKNavigationDelegate{
    
    //MARK: - 成员变量
    
    // 连接超时时间
    internal var timeout = 5.0
    // 导航栏按钮字体大小
    private let textFontSize: CGFloat = UIFont.systemFontSize
    // 导航栏按钮颜色
    private let titleColor = UIColor.black
    // WKWebView
    private let webView = WKWebView()
    // 请求的URL
    private var url: URL?
    // HTML代码
    var HTMLStr: String?
    // 进入方式
    var enter: HFWebViewEnter?
    // 提交标记
    private var submit: Bool = false
    
    // 需要暂停的计时器
    internal weak var pauseTimer: Timer?
    // 回调代理
    private weak var delegate: HFWebViewControllerDelegate?
    
    // 导航栏标题文字
    private var navTitle: String? {
        didSet{
            self.navigationController?.navigationBar.topItem?.title = self.navTitle
        }
    }
    
    // 进度条
    private lazy var progressView: UIProgressView = {
        
        let obj = UIProgressView()
        obj.trackTintColor = UIColor.white
        obj.progressTintColor = UIColor.blue
        
        return obj
    }()
    //    var webViewProgress: NJKWebViewProgress?
    // 关闭按钮
    private var escBtn: UIBarButtonItem?
    
    // 返回按钮
    private lazy var leftBtn: UIBarButtonItem = {
        
        let obj = UIBarButtonItem()
        let btn = UIButton(type: UIButtonType.custom)
//        let image = UIImage(named:"ico_back").scaleImage(0.25)
        let image = UIImage(named:"btn_back")
        image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        btn.imageView?.tintColor = self.view.tintColor
        btn.setImage(image, for: UIControlState())
        btn.setTitle(" 返回", for: UIControlState())
        btn.addTarget(self, action: #selector(HFWebViewController.leftBtnBackCall), for: UIControlEvents.touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: self.textFontSize)
        btn.setTitleColor(self.titleColor, for: .normal)
        //        btn.sizeToFit()
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0)
        //        btn.tintColor = self.view.tintColor
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        obj.customView = btn
        
        return obj
    }()
    
    
    //MARK: - 构造函数
    
    /// 跳转至网页
    ///
    /// - Parameters:
    ///   - controller: 起点控制器
    ///   - URLStr: URL
    class func showWebViewController(controller: UIViewController, URLStr:String) {
        let obj = HFWebViewController(URLStr: URLStr, Enter: .present)
        controller.present(UINavigationController(rootViewController: obj), animated: true, completion: nil)
    }
    
    /// Pust方式跳转至网页（需要起点控制器有导航控制器）
    ///
    /// - Parameters:
    ///   - controller: 起点控制器
    ///   - URLStr: URL
    class func showPushWebViewController(controller: UIViewController, URLStr:String) {
        let obj = HFWebViewController(URLStr: URLStr, Enter: .push)
        if controller.navigationController == nil {return}
        controller.navigationController?.pushViewController(obj, animated: true)
    }
    
    init(URLStr:String, Enter: HFWebViewEnter){
        super.init(nibName: nil, bundle: nil)
        self.url = URL(string: URLStr)
        self.enter = Enter
        
    }
    
    init(URLStr:String, Enter: HFWebViewEnter, timer: Timer?){
        super.init(nibName: nil, bundle: nil)
        self.url = URL(string: URLStr)
        self.enter = Enter
        self.pauseTimer = timer
        
    }
    
    init(HTMLString:String, Enter: HFWebViewEnter){
        super.init(nibName: nil, bundle: nil)
        self.HTMLStr = HTMLString
        self.enter = Enter
    }
    
    init(HTMLString:String, Enter: HFWebViewEnter, submitForm: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.HTMLStr = HTMLString
        self.enter = Enter
        self.submit = submitForm
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //        self.navigationController?.navigationBar.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - 生命周期（主干）
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.webView.scrollView.bounces = false
        self.view.addSubview(webView)
        self.view.backgroundColor = UIColor.white
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        settingNavBar()
        if self.url != nil {
            loadRequest()
        }else if self.HTMLStr != nil {
            loadHTMLString()
        }
        
        settingProgressBar()
        
        self.navigationController?.navigationBar.addSubview(self.progressView)
//        self.navigationController?.navigationBar.tag = 11
        if self.pauseTimer != nil {
            self.pauseTimer!.fireDate = Date.distantFuture
        }
        // 开启侧滑返回
//        self.navigationController!.interactivePopGestureRecognizer!.enabled = true
//        self.navigationController!.interactivePopGestureRecognizer!.delegate = self
//        self.openGestureBack(self)
        
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController!.setNavigationBarHidden(true,animated:animated)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        // 清理缓存
        URLCache.shared.removeAllCachedResponses()
        SVProgressHUD.dismiss()
        if self.pauseTimer != nil {
            self.pauseTimer!.fireDate = Date()
        }
        self.progressView.removeFromSuperview()
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
    }
    
    
    //MARK: - 自定义函数
    
    
    func loadRequest() {
        let request: URLRequest = URLRequest(url: url!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: timeout)
        self.webView.navigationDelegate = self
        self.webView.load(request)
    }
    
    func loadHTMLString() {
        self.webView.navigationDelegate = self
        if self.HTMLStr != nil {
            self.webView.loadHTMLString(self.HTMLStr!, baseURL: nil)
        }
    }
    
    /**
     创建进度条
     */
    func settingProgressBar() {
        
        let navBounds = self.navigationController?.navigationBar.bounds
        self.progressView.frame = CGRect(x: 0, y: navBounds!.size.height - 1, width: UIScreen.main.bounds.size.width, height: 2)
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
       
    }
    
    /**
     KVO回调
     - 进度条设置进度
     */
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
//            let progress = change![NSKeyValueChangeKey.newKey] as! Float
            let progress = (change![NSKeyValueChangeKey.newKey] as! NSNumber).floatValue
            if progress >= 1.0 {
                self.progressView.setProgress(progress, animated: true)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: UIViewAnimationOptions(), animations: {
                    self.progressView.alpha = 0.0
                    }, completion: { (_) in
                        self.progressView.setProgress(0.0, animated: false)
                })
            }else {
                self.progressView.alpha = 1.0
                self.progressView.setProgress(progress, animated: true)
            }
        }
        
    }
    
    /**
     设置导航栏按钮
     */
    func settingNavBar() {
        
        
        self.navigationItem.leftBarButtonItem = leftBtn
        let btn = UIButton(type: UIButtonType.custom)
        btn.imageView?.tintColor = self.view.tintColor
        btn.setTitle("关闭", for: UIControlState())
        btn.addTarget(self, action: #selector(HFWebViewController.escBtnBackCall), for: UIControlEvents.touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: self.textFontSize)
        btn.setTitleColor(self.titleColor, for: .normal)
        btn.center.y = (leftBtn.customView?.center.y)!
        btn.frame.size = (self.leftBtn.customView?.frame.size)!
        if self.submit != true {
            btn.isHidden = true
        }
        escBtn = UIBarButtonItem(customView: btn)
        
        self.navigationItem.leftBarButtonItems = [leftBtn,escBtn!]
    
        
//        if self.submit == false {
//            self.navigationItem.leftBarButtonItems = [leftBtn]
//        }else {
//            self.navigationItem.leftBarButtonItems = [leftBtn,escBtn!]
//        }
        
    }
    
    
    //MARK: - 回调
    
    /**
     返回按钮回调
     */
    @objc func leftBtnBackCall() {
        if self.webView.canGoBack == true {
            webView.goBack()
            URLCache.shared.removeAllCachedResponses()
            return
        }else if self.enter == HFWebViewEnter.push {
            self.navigationController?.popViewController(animated: true)
        }else if self.enter == HFWebViewEnter.present {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    /**
     关闭按钮回调
     */
    @objc func escBtnBackCall() {
        
        if self.enter == HFWebViewEnter.push {
            self.navigationController?.popViewController(animated: true)
        }else if self.enter == HFWebViewEnter.present {
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    
    //MARK: - UIWebViewDelegate
    
    
//
//    public func webViewDidStartLoad(webView: UIWebView) {
//        
//        if self.delegate != nil {
//            self.delegate?.webViewControllerDidStartLoad(webView)
//        }
//        
//    }
    open func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if self.delegate != nil {
            self.delegate?.webViewControllerDidStartLoad(webView)
        }
    }
//
//    public func webViewDidFinishLoad(webView: UIWebView) {
//        print(self.webView.canGoBack)
//        if self.webView.canGoBack == true {
////            self.navigationItem.leftBarButtonItems = [leftBtn,escBtn!]
//            escBtn?.customView?.hidden = false
//        }else if self.submit != true {
//            escBtn?.customView?.hidden = true
//        }
//
//        if self.HTMLStr != nil && self.submit == true {
//            self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById(\"pay_form\").submit();")
//        }
//    }
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if self.webView.canGoBack == true {
            //            self.navigationItem.leftBarButtonItems = [leftBtn,escBtn!]
            escBtn?.customView?.isHidden = false
        }else if self.submit != true {
            escBtn?.customView?.isHidden = true
        }
        
        self.navTitle = self.webView.title
        if self.HTMLStr != nil && self.submit == true {
            self.webView.evaluateJavaScript("document.getElementById(\"pay_form\").submit();", completionHandler: nil)
        }
    }
    //
//    public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        DDLogDebug("HFWebView正在加载的请求为：\(request.URLString)")
//        if self.delegate != nil {
//           return (self.delegate?.webViewController(webView, shouldStartLoadWithRequest: request, navigationType: navigationType))!
//        }
//
//        
//        return true
//    }
    //
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        var s: Bool?
        print("HFWebView正在加载的请求为：\(navigationAction.request.url!.absoluteString)")
        if self.delegate != nil {
            s =  (self.delegate?.webViewController(webView, shouldStartLoadWithRequest: navigationAction.request))!
        }
        
        if s == false {
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
        
    }
//    public func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
//        DDLogError("网络连接失败")
//        SVProgressHUD.showErrorWithStatus("网络不给力！", duration: 1)
//        if self.delegate != nil {
//            self.delegate?.webViewControllerDidFinishLoad(webView)
//        }
//    }
//    
//    didFailProvisionalNavigation
    open func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("网络连接失败")
        SVProgressHUD.showInfo(withStatus: "网络不给力！")
        if self.delegate != nil {
            self.delegate?.webViewControllerDidFinishLoad(webView)
        }
    }
//    //MARK: - NJKWebViewProgressDelegate
//    public func webViewProgress(webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
//        
//        self.webViewProgressView?.setProgress(progress, animated: true)
//        self.navTitle = webView.stringByEvaluatingJavaScriptFromString("document.title")
//        
//    }
    
    
    //MARK: - 其他设置
    
    /**
     禁止屏幕旋转
     */
    override open var shouldAutorotate : Bool {
        return false
    }
    
}

//
//  MDWebViewController.swift
//  AMFC
//
//  Created by Modi on 2018/9/12.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class MDWebViewController: BaseViewController {

    @IBOutlet weak var xib_webBgView: WKWebView! {
        didSet {
            xib_webView = WKWebView()
            xib_webBgView.addSubview(xib_webView)
            xib_webView.snp.makeConstraints { (make) in
                make.edges.equalTo(xib_webBgView)
            }
        }
    }
    var xib_webView: WKWebView!
    
    var url: String = API.baseURL
    
    var text: String = API.baseURL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.htmlAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        SVProgressHUD.show()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func htmlAction() {
//        xib_webView.loadHTMLString(url, baseURL: nil)
        if url != API.baseURL, url.contains("http") {
            if let reUrl = URL(string: self.url) {
                let urlReq = URLRequest(url: reUrl)
                xib_webView.load(urlReq)
            }
        }else {
            xib_webView.loadHTMLString(self.text, baseURL: nil)
        }
        xib_webView.navigationDelegate = self
    }

}
extension MDWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
    }
}

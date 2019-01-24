//
//  HFStartViewController.swift
//  Ecosphere
//
//  Created by 姚鸿飞 on 2017/6/13.
//  Copyright © 2017年 encifang. All rights reserved.
//

import UIKit

class HFStartViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.imageView.image = UIImage(named: self.splashImage())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    //播放启动画面动画
//    private func launchAnimation() {
//        let statusBarOrientation = UIApplication.shared.statusBarOrientation
//        if let img = splashImageForOrientation(orientation: statusBarOrientation,
//                                               size: self.view.bounds.size) {
//            //获取启动图片
//            let launchImage = UIImage(named: img)
//            let launchview = UIImageView(frame: UIScreen.main.bounds)
//            launchview.image = launchImage
//            //将图片添加到视图上
////            self.view.addSubview(launchview)
//            let delegate = UIApplication.shared.delegate
//            let mainWindow = delegate?.window
//            mainWindow!!.addSubview(launchview)
//            
//            //播放动画效果，完毕后将其移除
//            UIView.animate(withDuration: 1, delay: 1.5, options: .beginFromCurrentState,
//                                       animations: {
//                                        launchview.alpha = 0.0
//                                        launchview.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
//            }) { (finished) in
//                launchview.removeFromSuperview()
//            }
//        }
//    }
    

    //获取启动图片名（根据设备方向和尺寸）
    func splashImage() -> String {
        
        var launchImageName = ""
        let screenHeight = UIScreen.main.bounds.size.height

            
        switch screenHeight {
        case 812:
            launchImageName = "LaunchImage-1100-Portrait-2436h"
        case 480:
            launchImageName = "LaunchImage-700"
        case 568:
            launchImageName = "LaunchImage-700-568h"
        case 667:
            launchImageName = "LaunchImage-800-667h"
        case 736:
            launchImageName = "LaunchImage-800-Portrait-736h"
        case 480:
            launchImageName = "LaunchImage-700"
        default:
            launchImageName = "LaunchImage-800-667h"
        }
        
        return launchImageName
        
        
    }

}

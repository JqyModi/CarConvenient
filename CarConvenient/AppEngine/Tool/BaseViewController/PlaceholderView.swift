//
//  PlaceholderView.swift
//  MingChuangWine
//
//  Created by Modi on 2018/6/4.
//  Copyright © 2018年 江启雨. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

protocol PlaceholderViewDelegate {
    func requestData()
}

class PlaceholderView: UIView {
    
    var delegate: PlaceholderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        //404图片
        self.backgroundColor = UIColor.white
//        self.backgroundColor = UIColor.red
        let noNetworkImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
        noNetworkImageView.center = CGPoint(x: self.width/2, y: self.height/2)
        self.addSubview(noNetworkImageView)
//        noNetworkImageView.image = UIImage(named: "404network")
        noNetworkImageView.image = #imageLiteral(resourceName: "404network")
        //重新请求按钮
        let checkButton = UIButton(frame: CGRect(x: 0, y: noNetworkImageView.bottom + 24, width: 115, height: 30))
        checkButton.centerX = self.width/2
        self.addSubview(checkButton)
        checkButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
//        checkButton.backgroundColor = UIColor(red: 0.00, green: 0.76, blue: 0.66, alpha: 1.00)
        checkButton.backgroundColor = Color.md_ThemeColor
        checkButton.setTitle("重新查看", for: .normal)
        checkButton.setTitleColor(UIColor.white, for: .normal)
        checkButton.addTarget(self, action: #selector(self.checkNetworkButtonClicked), for: .touchUpInside)
        //图片上面两个Label1
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        label1.text = "尝试刷新一下~"
        label1.font = UIFont.systemFont(ofSize: 14)
//        label1.textColor = UIColor(red: 0.00, green: 0.77, blue: 0.68, alpha: 1.00)
        label1.textColor = Color.md_ThemeColor
        label1.backgroundColor = UIColor.clear
        label1.textAlignment = .center
        label1.sizeToFit()
        label1.centerX = self.width/2
        label1.bottom = noNetworkImageView.top - 21
        self.addSubview(label1)
        //图片上面两个Label2
        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 15))
        label2.text = "您似乎迷路了~"
        label2.font = UIFont.systemFont(ofSize: 19)
//        label2.textColor = UIColor(red: 0.00, green: 0.77, blue: 0.67, alpha: 1.00)
        label2.textColor = Color.md_ThemeColor
        label2.backgroundColor = UIColor.clear
        label2.textAlignment = .center
        label2.sizeToFit()
        label2.centerX = self.width/2
        label2.bottom = label1.top - 21
        self.addSubview(label2)
        
    }
    
    @objc private func checkNetworkButtonClicked() {
        let net = NetworkReachabilityManager()
        if net?.isReachable ?? false {
            for view in (HFAppEngine.shared.currentViewController()?.view.subviews)! {
                if view.isMember(of: PlaceholderView.self) {
                    view.removeFromSuperview()
                }
            }
            if self.delegate != nil {
                self.delegate?.requestData()
            }
        }else{
            SVProgressHUD.showInfo(withStatus: "请检查你的网络连接")
        }
    
    }

    class func placeholderImageWithSize(size: CGSize, imgName: String = "print_load") -> UIImage {
        let color = UIColor.white
        let img = UIImage(named: imgName)
        let logoWH = (size.width > size.height ? size.height : size.width) * 0.5
        let logoSize = CGSize(width: logoWH, height: logoWH)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        color.set()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let imgX = (size.width / 2) - (logoSize.width / 2)
        let imgY = (size.height / 2) - (logoSize.height / 2)
        
        img?.draw(in: CGRect(x: imgX, y: imgY, width: logoSize.width, height: logoSize.height))
        
        let resImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resImg!
    }
    
}

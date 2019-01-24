//
//  TLWelcomeCollectionViewCell.swift
//  TangLongFitnessCenter
//
//  Created by 微标杆 on 2018/4/27.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit


class TLWelcomeCollectionViewCell: UICollectionViewCell {
    
    
    private let welcomeImageView = UIImageView()
    private let enterHomeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        enterHomeButton.layer.cornerRadius = 15
        enterHomeButton.backgroundColor = UIColor.red
        enterHomeButton.setTitleColor(UIColor.white, for: .normal)
        enterHomeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        enterHomeButton.setTitle("点击进入", for: .normal)
        enterHomeButton.isHidden = true
        
        self.contentView.addSubview(welcomeImageView)
        self.contentView.addSubview(enterHomeButton)
        
        welcomeImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        enterHomeButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
    }
    
    func updateCell(imageName:String,row:Int,totalCount:Int) {
        
        if imageName.contains("http") || imageName.contains("https") {
            //设置图片
            welcomeImageView.kf.setImage(with: URL(string: imageName), placeholder: nil)
        }else {
            welcomeImageView.image = UIImage.init(named: imageName)
        }
        
//        if row == totalCount {
//            enterHomeButton.isHidden = false
//        }else{
//            enterHomeButton.isHidden = true
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

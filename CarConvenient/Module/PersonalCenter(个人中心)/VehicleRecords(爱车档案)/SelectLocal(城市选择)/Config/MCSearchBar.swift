//
//  MCSearchBar.swift
//  ZhongAiHealth
//
//  Created by 毛诚 on 2018/8/22.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit

typealias rightImageBlock = (_ isSelect:Bool)->()

class MCSearchBar: UITextField {

    private lazy var searchImageView = UIImageView()
    private lazy var rightImageView = UIImageView()
    
    var rightBlock:rightImageBlock?
    
    var openTap:Bool? {
        didSet{
            if openTap == true {
                rightImageView.isUserInteractionEnabled = true
            }else {
                rightImageView.isUserInteractionEnabled = false
            }
        }
    }
    
    
    
    var leftImageStr:String? {
        didSet{
            guard let imageStr = leftImageStr else { return }
            searchImageView.image = UIImage(named: imageStr)
        }
    }
    
    var rightImageStr:String? {
        didSet{
            guard let imageStr = rightImageStr else { return  }
            rightImageView.image = UIImage(named: imageStr)
        }
    }
    
    var holdStr: String?{
        didSet{
            placeholder = holdStr
        }
    }
    
   
    
    var leftSize:CGSize? {
        didSet{
            guard let tempSize = leftSize else { return  }
            searchImageView.frame = CGRect(x: 15, y: 15, width: tempSize.width, height: tempSize.height)
        }
    }
    
    var leftMargin:CGFloat? {
        didSet{
            guard let margin = leftMargin else { return  }
            leftView?.frame = CGRect(x: margin, y: 15, width: 30, height: 30)
        }
    }
    var rightMargin:CGFloat? {
        didSet{
            guard let margin = rightMargin else { return  }
            if let tempView = rightView {
                rightView?.frame = CGRect(x: tempView.left + margin, y: 15, width: 8, height: 16)
            }
            
        }
    }
    
    var rightSize:CGSize? {
        didSet{
            guard let tempSize = leftSize else { return  }
            rightImageView.frame = CGRect(x: 15, y: 15, width: tempSize.width, height: tempSize.height)
        }
    }
    
    
    var placeHolderFont:UIFont?{
        didSet{
            font = placeHolderFont
        }
    }
    
    var hiddenRight:Bool? {
        didSet{
            if hiddenRight == true {
                rightImageView.isHidden = true
            }else {
                rightImageView.isHidden = false
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    
    
    
    private func createUI() {
        
        isSecureTextEntry = false
        
        
        font = Fount.bigFontT8
        borderStyle = .none
        
        
        searchImageView.image = UIImage(named: "ic_search")
        searchImageView.contentMode = .right
        searchImageView.frame = CGRect.init(x: 25, y: 15, width: 44, height: 44)
        
        rightImageView.contentMode = .left
        rightImageView.frame = CGRect.init(x: 25, y: 15, width: 44, height: 44)
        
        
        
        rightImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
        rightImageView.addGestureRecognizer(tap)
        
        
        leftView = searchImageView
        rightView = rightImageView
        leftViewMode = .always
        rightViewMode = .always
    }
    
    @objc private func tapClick(tap:UITapGestureRecognizer){
        
        if isSecureTextEntry == true {
            isSecureTextEntry = false
            
            guard let tempBlock = rightBlock else {return}
            tempBlock(false)
            
        }else {
            isSecureTextEntry = true
            guard let tempBlock = rightBlock else {return}
            tempBlock(true)
        }
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

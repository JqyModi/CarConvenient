//
//  MDHorizontalCircleMenuView.swift
//  LT
//
//  Created by Modi on 2018/6/25.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit

struct MDHorizontalCircleMenuModel {
    var title: String
    var icon: String
}

protocol MDHorizontalCircleMenuViewDelegate: class {
    func itemDidSelected(index: Int, model: MDHorizontalCircleMenuCellModel)
}

class MDHorizontalCircleMenuView: UICollectionReusableView,UICollectionViewDataSource, UICollectionViewDelegate {
    
    weak var delegate: MDHorizontalCircleMenuViewDelegate?
    
    var updateFrameBlock: ((_ height: CGFloat) -> Void)?
    
    var defaultHeight:CGFloat = 80
    
    var defaultLabelHeight:CGFloat = 0
    
    var rowItemCount: CGFloat = 5
    
    var collectionView: UICollectionView?
    //
    var data: [MDHorizontalCircleMenuCellModel]! {
        didSet {
            self.collectionView?.reloadData()
            
            // 更新布局
            if let b = updateFrameBlock {
                b(self.collectionView?.height ?? self.height)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, margin: CGFloat, rowItemCount: CGFloat) {
        self.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        //最大5个最小1个
        let count = CGFloat.maximum(1, CGFloat.minimum(rowItemCount, 5))
        self.rowItemCount = count
        debugPrint("count --------------------------> \(count)")
        let width = (frame.width - margin * (count + 1)) / count
        debugPrint("width --------------------------> \(width)")
        let height = width + defaultLabelHeight
        debugPrint("height --------------------------> \(height)")
        layout.itemSize = CGSize(width: width, height: height)
        
        // 如果高度为0 设置默认高度
//        var tempFrame = frame
//        if frame.height == 0 {
//            tempFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: defaultHeight)
//        }
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView?.register(MDHorizontalCircleMenuCell.self, forCellWithReuseIdentifier: cellStr)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
//        collectionView?.backgroundColor = UIColor.init(white: 0.93, alpha: 1.0)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.isScrollEnabled = false
        
        self.addSubview(collectionView!)
        
        // 自动布局
        collectionView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellStr, for: indexPath) as! MDHorizontalCircleMenuCell
        cell.model = data[indexPath.row]
        
        // 设置collectionView高度自适应
        if indexPath.row == data.count - 1 {
            let cHeight = cell.bottom
            debugPrint("cHeight --------------------------> \(cHeight)")
            self.collectionView?.frame = CGRect(x: self.left, y: self.top, width: self.right, height: cHeight)
            self.collectionView?.layoutIfNeeded()
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let content = data[indexPath.row]
        self.delegate?.itemDidSelected(index: indexPath.row, model: content)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let content = data[indexPath.row]
//        self.delegate?.itemDidSelected(index: indexPath.row, model: content)
//    }
    
}

//extension MDHorizontalCircleMenuView: UICollectionViewDataSource, UICollectionViewDelegate {
//
//}

class MDHorizontalCircleMenuCellModel: NSObject {
    var content : String = ""
    var size : CGSize = CGSize.zero
    var title: String = ""
    var icon: String = ""
    
    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
    }
}

fileprivate let cellStr = "MDHorizontalCircleMenuCell"

fileprivate class MDHorizontalCircleMenuCell: UICollectionViewCell {
    
    var model: MDHorizontalCircleMenuCellModel? {
        didSet {
            if let m = model {
//                self.imageView?.image = UIImage(named: m.icon)?.md_image2Circle()
                self.imageView?.image = UIImage(named: m.icon)
                self.titleLabel?.text = m.title
                self.layoutIfNeeded()
                self.updateConstraintsIfNeeded()
            }
        }
    }
    
    var imageView: UIImageView?
    var titleLabel: UILabel?
    
    let defaultLabelHeight = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.clipsToBounds = true
//        self.layer.cornerRadius = cellHeight / 2
//        self.contentView.backgroundColor = UIColor.lightGray
        
        imageView = UIImageView()
        self.contentView.addSubview(imageView!)
        
        //
        let margin = 5
        
        titleLabel = UILabel()
        titleLabel?.textAlignment = .center
        //        titleLabel?.sizeToFit()
        titleLabel?.font = UIFont.systemFont(ofSize: FontSize.md_MenuFontSize)
        self.contentView.addSubview(titleLabel!)
        
        imageView?.snp.makeConstraints({ (make) in
//            make.left.top.equalTo(self.contentView).offset(margin * 3)
//            make.right.equalTo(self.contentView).offset(-margin * 5)
            make.centerX.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView).offset(-defaultLabelHeight)
            make.height.equalTo((imageView?.snp.width)!)
        })
        
        titleLabel?.snp.makeConstraints({ (make) in
//            make.right.bottom.equalTo(self.contentView).offset(-margin)
            make.height.equalTo(defaultLabelHeight)
            make.left.equalTo(self.contentView).offset(margin)
            make.top.equalTo((imageView?.snp.bottom)!).offset(margin)
            make.right.equalTo(self.contentView).offset(-margin)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


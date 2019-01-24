//
//  HotSearchView.swift
//  MingChuangWine
//
//  Created by Modi on 2018/6/15.
//  Copyright © 2018年 江启雨. All rights reserved.
//

import UIKit

class HotSearchView: UIView {

    var defaultHeight:CGFloat = 80
    var collectionView: UICollectionView?
    var data: [String] = ["测试","云标签","历史记录","测试","妈妈说标题要长","机智的手哥"] {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, data: [String]?) {
        self.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout()
        
        // 如果高度为0 设置默认高度
        var tempFrame = frame
        if frame.height == 0 {
            tempFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: defaultHeight)
        }
        collectionView = UICollectionView(frame: tempFrame, collectionViewLayout: layout)
        
        collectionView?.register(HotSearchCell.self, forCellWithReuseIdentifier: cellStr)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor.init(white: 0.93, alpha: 1.0)
        
        self.addSubview(collectionView!)
        
        self.data = data!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
extension HotSearchView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellStr, for: indexPath) as! HotSearchCell
        cell.keyword = data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cell = collectionView.cellForItem(at: indexPath) as? HotSearchCell
        if cell == nil {
            cell = HotSearchCell(frame: CGRect.zero)
        }
        cell?.keyword = data[indexPath.row]
        return (cell?.sizeForCell())!
    }
    
}

fileprivate let cellStr = "HotSearchCell"

fileprivate class HotSearchCell: UICollectionViewCell {
    
    var cellHeight: CGFloat = 35
    
    var keyword: String = "" {
        didSet {
            self.titleLabel?.text = keyword
            self.layoutIfNeeded()
            self.updateConstraintsIfNeeded()
        }
    }
    
    var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = cellHeight / 2
        self.contentView.backgroundColor = UIColor.lightGray
        
        titleLabel = UILabel()
        titleLabel?.sizeToFit()
        self.contentView.addSubview(titleLabel!)
        
        titleLabel?.snp.makeConstraints({ (make) in
            make.center.equalTo(self.contentView.center)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sizeForCell() -> CGSize {
        let margin: CGFloat = 5
        //宽度加 heightForCell 为了两边圆角。
        //        return CGSizeMake([_titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + heightForCell, heightForCell);
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        return CGSize(width: (titleLabel?.sizeThatFits(size).width)! + cellHeight, height: cellHeight)
    }
}

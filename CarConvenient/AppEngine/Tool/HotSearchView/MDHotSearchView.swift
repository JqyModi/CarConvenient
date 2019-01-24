//
//  MDHotSearchView.swift
//  MingChuangWine
//
//  Created by Modi on 2018/6/15.
//  Copyright © 2018年 江启雨. All rights reserved.
//

import UIKit

protocol MDHotSearchViewDelegate: class {
    func itemDidSelected(index: Int, content: String)
}

class MDHotSearchView: UICollectionReusableView {
    
    weak var delegate: MDHotSearchViewDelegate?
    
    var defaultHeight:CGFloat = 80
    var collectionView: UICollectionView?
    var data: [String] = ["测试","云标签","历史记录","测试","妈妈说标题要长","机智的手哥","iPhone X","iPad Air", "iMac Pro"] {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(data: [String]?, type: AlignType, margin: CGFloat) {
        self.init(frame: CGRect.zero)
        
        let layout = MDEqualCellSpaceFlowLayout(type, margin)
        
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
        
        // 自动布局
        collectionView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        if let d = data {
            self.data = d
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension MDHotSearchView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellStr, for: indexPath) as! HotSearchCell
        cell.keyword = data[indexPath.row]
        
        // 设置collectionView高度自适应
        if indexPath.row == data.count - 1 {
            let cHeight = cell.bottom
            debugPrint("cHeight --------------------------> \(cHeight)")
            self.collectionView?.frame = CGRect(x: self.left, y: self.top, width: self.right, height: cHeight)
            self.collectionView?.layoutIfNeeded()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cell = collectionView.cellForItem(at: indexPath) as? HotSearchCell
        if cell == nil {
            cell = HotSearchCell(frame: CGRect.zero)
        }
        cell?.keyword = data[indexPath.row]
//        debugPrint("size --------------------------> \(cell?.sizeForCell())")
        return (cell?.sizeForCell())!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let content = data[indexPath.row]
        self.delegate?.itemDidSelected(index: indexPath.row, content: content)
    }
    
}

fileprivate class HotSearchCellModel: NSObject {
    var content : String = ""
    var size : CGSize = CGSize.zero
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
        titleLabel?.textAlignment = .center
//        titleLabel?.sizeToFit()
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

enum AlignType : NSInteger {
    case left = 0
    case center = 1
    case right = 2
}

fileprivate class MDEqualCellSpaceFlowLayout: UICollectionViewFlowLayout {
    //两个Cell之间的距离
    var betweenOfCell : CGFloat{
        didSet{
            self.minimumInteritemSpacing = betweenOfCell
        }
    }
    //cell对齐方式
    var cellType : AlignType = AlignType.center
    //在居中对齐的时候需要知道这行所有cell的宽度总和
    var sumCellWidth : CGFloat = 0.0
    
    override init() {
        betweenOfCell = 5.0
        super.init()
        scrollDirection = UICollectionViewScrollDirection.vertical
        minimumLineSpacing = 5
        sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
    }
    convenience init(_ cellType:AlignType){
        self.init()
        self.cellType = cellType
    }
    convenience init(_ cellType: AlignType, _ betweenOfCell: CGFloat){
        self.init()
        self.cellType = cellType
        self.betweenOfCell = betweenOfCell
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes_super : [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect) ?? [UICollectionViewLayoutAttributes]()
        let layoutAttributes:[UICollectionViewLayoutAttributes] = NSArray(array: layoutAttributes_super, copyItems:true)as! [UICollectionViewLayoutAttributes]
        var layoutAttributes_t : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        for index in 0..<layoutAttributes.count{
            
            let currentAttr = layoutAttributes[index]
            let previousAttr = index == 0 ? nil : layoutAttributes[index-1]
            let nextAttr = index + 1 == layoutAttributes.count ?
                nil : layoutAttributes[index+1]
            
            layoutAttributes_t.append(currentAttr)
            sumCellWidth += currentAttr.frame.size.width
            
            let previousY :CGFloat = previousAttr == nil ? 0 : previousAttr!.frame.maxY
            let currentY :CGFloat = currentAttr.frame.maxY
            let nextY:CGFloat = nextAttr == nil ? 0 : nextAttr!.frame.maxY
            
            if currentY != previousY && currentY != nextY{
                if currentAttr.representedElementKind == UICollectionElementKindSectionHeader{
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                }else if currentAttr.representedElementKind == UICollectionElementKindSectionFooter{
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                }else{
                    self.setCellFrame(with: layoutAttributes_t)
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                }
            }else if currentY != nextY{
                self.setCellFrame(with: layoutAttributes_t)
                layoutAttributes_t.removeAll()
                sumCellWidth = 0.0
            }
        }
        return layoutAttributes
    }
    
    /// 调整Cell的Frame
    ///
    /// - Parameter layoutAttributes: layoutAttribute 数组
    func setCellFrame(with layoutAttributes : [UICollectionViewLayoutAttributes]){
        var nowWidth : CGFloat = 0.0
        switch cellType {
        case AlignType.left:
            nowWidth = self.sectionInset.left
            for attributes in layoutAttributes{
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.betweenOfCell
            }
            break;
        case AlignType.center:
            nowWidth = (self.collectionView!.frame.size.width - sumCellWidth - (CGFloat(layoutAttributes.count - 1) * betweenOfCell)) / 2
            for attributes in layoutAttributes{
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.betweenOfCell
            }
            break;
        case AlignType.right:
            nowWidth = self.collectionView!.frame.size.width - self.sectionInset.right
            for var index in 0 ..< layoutAttributes.count{
                index = layoutAttributes.count - 1 - index
                let attributes = layoutAttributes[index]
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth - nowFrame.size.width
                attributes.frame = nowFrame
                nowWidth = nowWidth - nowFrame.size.width - betweenOfCell
            }
            break;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

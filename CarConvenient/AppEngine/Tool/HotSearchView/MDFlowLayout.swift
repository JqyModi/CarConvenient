//
//  MDFlowLayout.swift
//  MingChuangWine
//
//  Created by Modi on 2018/6/14.
//  Copyright © 2018年 江启雨. All rights reserved.
//

import UIKit

class MDFlowLayout: UICollectionViewFlowLayout {
    
    
    var centerBlock: ((_ point: CGPoint) -> Void)?
    
    //来控制cell的大小
//    var setSize:()->(Array<CGSize>) = { return []}
    var setSize:()->(Array<UIImage>) = { return []}
    
    /// 列数，默认为两列
    var queueNum: Int = 2
    
    /// 列数，默认为两列
    var rowNum: Int = 2
    
    /// 实际高度集合
    var hs: Array<CGFloat>!
    
    /// 实际宽度集合
    var ws: Array<CGFloat>!
    
    /// 总Item个数
    private var totalNum: Int!
    
    /// 每个Item的attributes
    private var layoutAttributes: Array<UICollectionViewLayoutAttributes>!
    
    /// 重写做一些初始化操作
    override func prepare() {
        super.prepare()
        hs = []
        ws = []
        for _ in 0..<queueNum {
            hs.append(5)
        }
        
        for _ in 0..<rowNum {
            ws.append(5)
        }
        
        totalNum = collectionView?.numberOfItems(inSection: 0)
        layoutAttributes = []
        var indexpath: NSIndexPath!
        for index in 0..<totalNum {
            indexpath = NSIndexPath(row: index, section: 0)
            let attributes = layoutAttributesForItem(at: indexpath as IndexPath)
            layoutAttributes.append(attributes!)
        }
    }
    
    /// 间隔，缝隙大小
    private let gap:CGFloat = 5
    
    /// item宽度
    private var width:CGFloat!
    
    /// item高度
    private var height:CGFloat!
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //根据水平和垂直计算宽高
        var attributes: UICollectionViewLayoutAttributes!
        /// 通过宽高 + 中心点坐标 = 定位Item位置
        if scrollDirection == .vertical {
            // 计算宽高
            height = (collectionView!.bounds.size.height-gap*(CGFloat(rowNum)-1))/CGFloat(rowNum)
            attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let sizes = setSize()
            width = sizes[indexPath.row].size.width*height/sizes[indexPath.row].size.height
            attributes.size = CGSize(width: width, height: height)
            debugPrint("size --------------------------> \(attributes.size)")
            // 计算中心坐标
            var minIndex:CGFloat = 0
            var w:CGFloat = 0
            (minIndex,w) = minW(wws: ws)
            print("minIndex--->\(minIndex) w-->\(w)")
            attributes.center = CGPoint(x:w+(height/attributes.size.height*attributes.size.width+gap)/2, y:(minIndex+0.5)*(gap+height))
            if centerBlock != nil {
                centerBlock!(attributes.center)
            }
            ws[Int(minIndex)] = w+height/attributes.size.height*attributes.size.width+gap
        }else if scrollDirection == .horizontal {
            width = (collectionView!.bounds.size.width-gap*(CGFloat(queueNum)-1))/CGFloat(queueNum)
            attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let sizes = setSize()
            attributes.size = CGSize(width: width, height: sizes[indexPath.row].size.height*width/sizes[indexPath.row].size.width)
            var nub:CGFloat = 0
            var h:CGFloat = 0
            (nub,h) = minH(hhs: hs)
            attributes.center = CGPoint(x:(nub+0.5)*(gap+width), y:h+(width/attributes.size.width*attributes.size.height+gap)/2)
            hs[Int(nub)] = h+width/attributes.size.width*attributes.size.height+gap
            print("nub--->\(nub) h-->\(h)")
        }
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    //    override func collectionViewContentSize() -> CGSize {
    //        return CGSize(width: (collectionView?.bounds.width)!, height: maxH(hhs: hs))
    //    }
    //swift3.0废弃了上面这个方法，所以我们改成重写collectionViewContentSize属性
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: maxW(wws: ws), height: maxH(hhs: hs))
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    
    /// 获取最小高度对应的下标
    ///
    /// - Parameter hhs: 所有高度集合
    /// - Returns: 最小值&下标
    private func minH(hhs:Array<CGFloat>)->(CGFloat,CGFloat){
        var num = 0
        var min = hhs[0]
        for i in 1..<hhs.count{
            if min>hhs[i] {
                min = hhs[i]
                num = i
            }
        }
        return (CGFloat(num),min)
    }
    
    /// 获取最小宽度对应的下标
    ///
    /// - Parameter hhs: 所有宽度集合
    /// - Returns: 最小值&下标
    private func minW(wws:Array<CGFloat>)->(CGFloat,CGFloat){
        var num = 0
        var min = wws[0]
        for i in 1..<wws.count{
            if min>wws[i] {
                min = wws[i]
                num = i
            }
        }
        return (CGFloat(num),min)
    }
    
    func maxH(hhs:Array<CGFloat>)->CGFloat{
        var max = hhs[0]
        for i in 1..<hhs.count{
            if max<hhs[i] {
                max = hhs[i]
            }
        }
        return max
    }
    
    func maxW(wws:Array<CGFloat>)->CGFloat{
        var max = wws[0]
        for i in 1..<wws.count{
            if max<wws[i] {
                max = wws[i]
            }
        }
        return max
    }
    
    // 画圆点
    func drawCircle(point: CGPoint) {
        let bPath = UIBezierPath()
        bPath.addArc(withCenter: point, radius: 10, startAngle: 0, endAngle: CGFloat(Double.pi * 2 * 10), clockwise: true)
        UIColor.red.set()
        bPath.lineWidth = 5
        bPath.stroke()
    }

}

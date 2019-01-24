//
//  HPYStarView.swift
//  HPYStarView
//
//  Created by 洪鹏宇 on 16/4/10.
//  Copyright © 2016年 HPY. All rights reserved.
//

import UIKit

@IBDesignable
class HPYStarView: UIControl {
    
    @IBInspectable var maxCount:Int = 5
    @IBInspectable var selectedCount:CGFloat = 0.0
    @IBInspectable var starColor:UIColor = UIColor.yellow
    @IBInspectable var space:CGFloat = 2.0
    @IBInspectable var lineWidth:CGFloat = 1.0
    @IBInspectable var halfOfStar:Bool = false
    
    var tap:(()->())?
    
    var starPathArr = [UIBezierPath]()
    
    var starWidth:CGFloat {
        let sw = (self.bounds.width - CGFloat(space * CGFloat(maxCount+1))) / CGFloat(maxCount)
        let sh = self.bounds.height - space * 2
        return min(sw, sh)
    }
    
    var starPath:UIBezierPath {

        let frame = CGRect(x: 0, y: (self.bounds.height - starWidth)/2, width: starWidth, height: starWidth)
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.04000 * frame.height))
        starPath.addLine(to: CGPoint(x: frame.minX + 0.67634 * frame.width, y: frame.minY + 0.29729 * frame.height))
        starPath.addLine(to: CGPoint( x: frame.minX + 0.97553 * frame.width, y: frame.minY + 0.38549 * frame.height))
        starPath.addLine(to: CGPoint( x: frame.minX + 0.78532 * frame.width, y: frame.minY + 0.63271 * frame.height))
        starPath.addLine(to: CGPoint( x: frame.minX + 0.79389 * frame.width, y: frame.minY + 0.94451 * frame.height))
        starPath.addLine(to: CGPoint( x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.84000 * frame.height))
        starPath.addLine(to: CGPoint( x: frame.minX + 0.20611 * frame.width, y: frame.minY + 0.94451 * frame.height))
        starPath.addLine(to: CGPoint( x: frame.minX + 0.21468 * frame.width, y: frame.minY + 0.63271 * frame.height))
        starPath.addLine(to: CGPoint( x: frame.minX + 0.02447 * frame.width, y: frame.minY + 0.38549 * frame.height))
        starPath.addLine(to: CGPoint( x: frame.minX + 0.32366 * frame.width, y: frame.minY + 0.29729 * frame.height))
        starPath.close()
        
        return starPath
    }
    
    var starsPath:UIBezierPath {
        let path = UIBezierPath()
        for i in 0 ..< maxCount {
            path.move(to: CGPoint(x: space + CGFloat(i) * (starWidth + space), y: (self.bounds.height - starWidth)/2))
            let sp = starPath
            sp.apply(CGAffineTransform.identity.translatedBy(x: space + CGFloat(i) * (starWidth + space), y: 0))
            starPathArr.append(sp)
            path.append(sp)
        }
        path.close()
        return path
    }
    
    lazy var fullLayer:CALayer = {
        [unowned self] in
        let layer = CALayer()
        layer.backgroundColor = self.starColor.cgColor
        if self.halfOfStar {
            let temp = self.selectedCount - floor(self.selectedCount)
            self.selectedCount =  temp <= 0.5 ? floor(self.selectedCount) + 0.5 : ceil(self.selectedCount)
        }else {
            self.selectedCount = ceil(self.selectedCount)
        }
        layer.frame = CGRect(x: 0, y: 0, width: self.space * ceil(self.selectedCount) + self.starWidth * self.selectedCount, height: self.bounds.height)
        layer.mask = self.maskLayer
        
        return layer
    }()
    
    lazy var maskLayer:CAShapeLayer = {
        [unowned self] in
        let layer = CAShapeLayer()
        layer.path = self.starsPath.cgPath
        
        return layer
    }()
    

    lazy var starsLayer:CAShapeLayer = {
        [unowned self] in
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.path = self.starsPath.cgPath
        layer.strokeColor = self.starColor.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = self.lineWidth
        
        return layer
    }()
    
    
    convenience init(frame: CGRect,starColor:UIColor,maxCount:Int,selectedCount:CGFloat,lineWidth:CGFloat,starSpace:CGFloat,enabled:Bool,isHalf:Bool) {
        self.init(frame: frame)
        self.starColor = starColor
        self.maxCount = maxCount
        self.selectedCount = selectedCount
        self.lineWidth = lineWidth
        self.space = starSpace
        self.isEnabled = enabled
        self.halfOfStar = isHalf
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.addSublayer(fullLayer)
        self.layer.addSublayer(starsLayer)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        let touchP = touch?.location(in: self)
        for path in starPathArr {
            if path.contains(touchP!) {
                if halfOfStar {
                    if touchP!.x < path.bounds.midX {
                        self.fullLayer.frame = CGRect(x: 0, y: 0, width: path.bounds.midX, height: self.bounds.height)
                        self.selectedCount = CGFloat(starPathArr.index(of: path)!) + 0.5;
                    }else {
                        self.fullLayer.frame = CGRect(x: 0, y: 0, width: path.bounds.maxX, height: self.bounds.height)
                        self.selectedCount = CGFloat(starPathArr.index(of: path)! + 1);
                    }
                }else {
                    self.fullLayer.frame = CGRect(x: 0, y: 0, width: path.bounds.maxX, height: self.bounds.height)
                    self.selectedCount = CGFloat(starPathArr.index(of: path)! + 1)
                }
            }
        }

        if let tap = tap {
            tap()
        }
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

        if starsPath.contains(point){
            return true
        }
        return false
    }
}

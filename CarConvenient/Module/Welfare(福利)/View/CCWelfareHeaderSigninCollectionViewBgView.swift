//
//  CCWelfareHeaderSigninCollectionViewBgView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/15.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCWelfareHeaderSigninCollectionViewBgView: BaseView {

    /// 起点
    lazy var leftPoint: CGPoint = {
        let x = (self.width/7)/2
        let y = (self.height)/2 - 10
        let leftPoint = CGPoint(x: x, y: y)
        return leftPoint
    }()
    
    /// 终点
    lazy var rightPoint: CGPoint = {
        let x = (self.width/7)/2
        let y = (self.height)/2 - 10
        let x1 = (self.width - (self.width/7)) + x
        let rightPoint = CGPoint(x: x1, y: y)
        return rightPoint
    }()
    
    /// 正常色
    lazy var normalColor: UIColor = UIColor(rgba: "#DDDDDD")
    
    /// 高亮线段终点
    var rightDot: CGPoint = .zero {
        didSet {
            self.highLightLine = true
            // 刷新view
            setNeedsDisplay()
        }
    }
    
    /// 是否绘制高亮线段
    private var highLightLine: Bool = false
    /// 高亮色
    var lineColor: UIColor = UIColor(rgba: "#FFA118")
    /// 线宽
    var lineWidth: CGFloat = 2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(lineWidth)
        context?.setAllowsAntialiasing(true)
        context?.setStrokeColor(normalColor.cgColor)
        context?.beginPath()
        context?.move(to: leftPoint)
        context?.addLine(to: rightPoint)
        context?.strokePath()
        
        // 是否绘制黄色线段
        if highLightLine {
            drawSelectedLine(context: context)
        }
    }
    
    private func drawSelectedLine(context: CGContext?) {
//        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(lineWidth)
        context?.setAllowsAntialiasing(true)
        context?.setStrokeColor(lineColor.cgColor)
        context?.beginPath()
        context?.move(to: leftPoint)
        context?.addLine(to: rightDot)
        context?.strokePath()
    }
    
}

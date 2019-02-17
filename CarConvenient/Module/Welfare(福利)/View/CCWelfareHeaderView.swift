//
//  CCWelfareHeaderView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/15.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

private let menuIdentifier = "CCWelfareMenuCollectionViewCell"
private let signinIdentifier = "CCWelfareSigninCollectionViewCell"

@objc protocol CCWelfareHeaderViewDelegate {
    func menuItemDidSelected(_ index: Int)
    @objc optional func prizeDidSelected()
    @objc optional func ruleDidSelected()
}

class CCWelfareHeaderView: BaseView {
    
    var delegate: CCWelfareHeaderViewDelegate?
    
    /// 菜单数据源
    private var signinDataSources: [[String: String]] = {
        var temps = [[String: String]]()
        let titles = ["10积分", "20积分", "30积分", "40积分", "50积分", "60积分", "70积分"]
        let imgs = ["btn_gold_s", "btn_gold_s", "btn_gold_s", "btn_gold_n", "btn_gold_n", "btn_gold_n", "btn_gold_n"]
        let status = ["1", "1", "1", "0", "0", "0", "0"]
        for i in 0..<titles.count {
            let dic = ["title": titles[i], "image": imgs[i], "status": status[i]]
            temps.append(dic)
        }
        return temps
    }()
    /// 签到数据源
    private var menuDataSources: [[String: String]] = {
        var temps = [[String: String]]()
        let titles = ["赚积分", "兑积分", "优惠券", "优惠团"]
        let imgs = ["btn_make_money", "btn_conversion_n", "btn_discount_coupon", "btn_group_purchase"]
        for i in 0..<titles.count {
            let dic = ["title": titles[i], "image": imgs[i]]
            temps.append(dic)
        }
        return temps
    }()
    
    @IBOutlet weak var menuCollectionView: UICollectionView! {
        didSet {
            menuCollectionView.dataSource = self
            menuCollectionView.delegate = self
            menuCollectionView.register(UINib(nibName: menuIdentifier, bundle: nil), forCellWithReuseIdentifier: menuIdentifier)
        }
    }
    
    /// 签到背景View
    var signinCollectionViewBgView = CCWelfareHeaderSigninCollectionViewBgView()
    @IBOutlet weak var signinCollectionView: UICollectionView! {
        didSet {
            signinCollectionView.dataSource = self
            signinCollectionView.delegate = self
            signinCollectionView.backgroundColor = UIColor.clear
            signinCollectionView.register(UINib(nibName: signinIdentifier, bundle: nil), forCellWithReuseIdentifier: signinIdentifier)
//            drawGrayLine()
            let bgv = CCWelfareHeaderSigninCollectionViewBgView()
            signinCollectionViewBgView = bgv
            bgv.frame = signinCollectionView.frame
            bgv.backgroundColor = UIColor(rgba: "#FFFDEF")
            signinCollectionView.backgroundView = bgv
            
            // 绘制已经签到的背景线段
            var firstNormalCellIndex = -1
            for i in 0..<signinDataSources.count {
                if signinDataSources[i]["status"] == "0" {
                    firstNormalCellIndex = i-1
                    self.drawLine(index: firstNormalCellIndex)
                    break
                }
            }
        }
    }
    
    @IBOutlet weak var xib_prize: UIButton! {
        didSet {
            xib_prize.viewClipCornerDirectionRight(radius: 5, direct: clipCornerDirection.bottomRight, fillColor: UIColor(rgba: "#1B82D2"))
        }
    }
    @IBOutlet weak var xib_rule: UIButton! {
        didSet {
            xib_rule.viewClipCornerDirectionRight(radius: 5, direct: clipCornerDirection.bottomRight, fillColor: UIColor(rgba: "#999999"))
        }
    }
    
    var prizeView = ZXDrawPrizeView()
    
    var prizeDataSources = ["地狱游", "iPhoneX Maxs", "天堂游", "再来一次", "谢谢惠顾", "女朋友一枚"]
    
    @IBOutlet weak var xib_prizeBgView: UIView! {
        didSet {
            setupPrizeUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        if let b = delegate {
            if sender.tag == 10001 {
                b.prizeDidSelected!()
            }else {
                b.ruleDidSelected!()
            }
        }
    }
}
// MARK: - 抽奖UI设置、delegate
extension CCWelfareHeaderView: ZXDrawPrizeDataSource, ZXDrawPrizeDelegate {
    
    private func setupPrizeUI() {
        let prizev = ZXDrawPrizeView(.zero, width: xib_prizeBgView.width)
        prizev.dataSource = self
        prizev.delegate = self
        prizeView = prizev
        xib_prizeBgView.addSubview(prizev)
    }
    
    // MARK: - ZXDrawPrizeDataSource
    func zxDrawPrize(prizeView: ZXDrawPrizeView, labelAt index: NSInteger) -> String? {
        return prizeDataSources.randomElement()
    }
    
    func zxDrawPrize(prizeView: ZXDrawPrizeView, imageAt index: NSInteger) -> UIImage? {
        return nil
    }
    
    func zxDrawPrize(prizeView: ZXDrawPrizeView, imageUrlAt index: NSInteger) -> String? {
        return nil
    }
    
    ///奖品格子数，不得小于三个
    func numberOfPrize(for drawprizeView: ZXDrawPrizeView) -> NSInteger {
        return prizeDataSources.count
    }
    ///某一项奖品抽完（不需要，直接return false 即可）
    func zxDrawPrize(prizeView: ZXDrawPrizeView, drawOutAt index: NSInteger) -> Bool {
        return false
    }
    ///指针图片
    func zxDrawPrizeButtonImage(prizeView: ZXDrawPrizeView) -> UIImage {
        return #imageLiteral(resourceName: "img_turntable_go")
    }
    ///大背景
    func zxDrawPrizeBackgroundImage(prizeView: ZXDrawPrizeView) -> UIImage? {
        return #imageLiteral(resourceName: "img_turntable_round")
    }
    ///滚动背景 （if nil , fill with color）
    func zxDrawPrizeScrollBackgroundImage(prizeView: ZXDrawPrizeView) -> UIImage? {
        return nil
    }
    
    // MARK: - ZXDrawPrizeDelegate
    ///点击抽奖按钮
    func zxDrawPrizeStartAction(prizeView: ZXDrawPrizeView) {
        prizeView.drawPrize(at: Int.random(from: 1, to: prizeDataSources.count)) { (finished) in
            
        }
    }
    ///动画执行结束
    func zxDrawPrizeEndAction(prizeView: ZXDrawPrizeView, prize index: NSInteger) {
        
    }
}
// MARK: - Delegate
extension CCWelfareHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCollectionView {
            return menuDataSources.count
        }else if collectionView == signinCollectionView {
            return signinDataSources.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == menuCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuIdentifier, for: indexPath)
            (cell as! CCWelfareMenuCollectionViewCell).updateCell(model: menuDataSources[indexPath.row])
        }else if collectionView == signinCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: signinIdentifier, for: indexPath)
            (cell as! CCWelfareSigninCollectionViewCell).updateCell(model: signinDataSources[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize.zero
        if collectionView == menuCollectionView {
            size = CGSize(width: collectionView.width/4, height: collectionView.height)
        }else if collectionView == signinCollectionView {
            size = CGSize(width: collectionView.width/7, height: collectionView.height)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollectionView {
            if let b = delegate {
                b.menuItemDidSelected(indexPath.row)
            }
        }else if collectionView == signinCollectionView {
            
            /// 标记第一个正常
            var firstNormalCellIndex = -1
            for i in 0..<signinDataSources.count {
                if signinDataSources[i]["status"] == "0" {
                    firstNormalCellIndex = i
                    break
                }
            }
            if firstNormalCellIndex == indexPath.row {
                signinDataSources[indexPath.row]["status"] = "1"
                collectionView.reloadItems(at: [indexPath])
                
                drawLine(index: firstNormalCellIndex)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /// 绘制线段
    ///
    /// - Parameter indexPath: 0 ~ 目标indexPath
    private func drawLine(index: Int) {
        let x = (signinCollectionView.width/CGFloat(signinDataSources.count))/2
        let y = (signinCollectionView.height)/2 - 10
        let x1 = CGFloat(index)*(signinCollectionView.width/CGFloat(signinDataSources.count)) + x
        let rightPoint = CGPoint(x: x1, y: y)
        signinCollectionViewBgView.rightDot = rightPoint
    }
    
}

//
//  CCConfirmOrderHeaderView.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/13.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit
private let identifier = "CCConfirmOrderCollectionViewCell"
class CCConfirmOrderHeaderView: BaseView {

    private lazy var dataSources: [String] = {
        var temps = [String]()
        for item in 0..<5 {
            temps.append("print_load")
        }
        return temps
    }()
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        if let b = clickBlock {
            b(sender)
        }
//        switch sender.tag {
//        case 10001: // 地址
//            break
//        case 10002: // 商品列表
//            break
//        case 10003: // 优惠券
//            break
//        case 10004: // 发票
//            break
//        default:
//            break
//        }
    }
    
}
// MARK: - 设置collectionView
extension CCConfirmOrderHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CCConfirmOrderCollectionViewCell
        cell.updateCell(model: dataSources[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginTotal: CGFloat = CGFloat((dataSources.count-1)*2)
        let width = (collectionView.width - marginTotal)/5
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}

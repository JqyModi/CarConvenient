//
//  CCCarCategoryHeaderView.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit
import FSPagerView

protocol CCCarCategoryHeaderViewDelegate: class {
    func itemDidSelect(index: Int)
}

class CCCarCategoryHeaderView: BaseView {
    
    weak var delegate: CCCarCategoryHeaderViewDelegate!

    lazy var imgNameDataSource: [String] = {
        let ds = [
            "btn_trim_n",
            "btn_disinfect_n",
            "btn_outdoors_n",
            "btn_cushion_n",
            "btn_individuality_n",
            "",
            "",
            "btn_capacity_n",
            "btn_engine_oil",
            "btn_filter_n",
            "btn_outburst_n",
            "btn_more_n",
        ]
        return ds
    }()
    
    lazy var titleDataSource: [String] = {
        let ds = [
            "内饰精品",
            "消毒净化",
            "自驾户外",
            "坐垫脚垫",
            "个性加装",
            "",
            "",
            "智能升级",
            "机油",
            "滤清器",
            "应急用品",
            "应急用品",
            ]
        return ds
    }()
    
    lazy var bannerModels: [String] = {
        let bms = ["placeholder", "placeholder", "placeholder"]
        return bms
    }()

    @IBOutlet weak var xib_bannerView: FSPagerView! {
        didSet {
            self.xib_bannerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    let identifier = "CCCarCategoryHeaderCollectionViewCell"
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        }
    }
    
    lazy var centerView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "btn_supermarket_n"))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        xib_bannerView.dataSource = self
        xib_bannerView.delegate = self
        
        addSubview(centerView)
        
        let width = (collectionView.width/4)
        let height = width
        centerView.snp.makeConstraints { (make) in
            make.center.equalTo(collectionView)
            make.width.equalTo(width*2)
            make.height.equalTo(height)
        }
        
    }
    
}
extension CCCarCategoryHeaderView: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return bannerModels.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: bannerModels[index])
        cell.imageView?.contentMode = .scaleAspectFill
        // 取消阴影
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        cell.contentView.layer.shadowRadius = 0
        cell.contentView.layer.shadowOpacity = 0
        cell.contentView.layer.shadowOffset = .zero
        return cell
    }
    
    
}
extension CCCarCategoryHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CCCarCategoryHeaderCollectionViewCell
        
        let title = titleDataSource[indexPath.row]
        let imageName = imgNameDataSource[indexPath.row]
        
        cell.xib_image.image = UIImage(named: imageName)
        cell.xib_title.text = title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.width/4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        QYTools.shared.Log(log: "\(indexPath.row)")
        if let d = delegate {
            d.itemDidSelect(index: indexPath.row)
        }
    }
}

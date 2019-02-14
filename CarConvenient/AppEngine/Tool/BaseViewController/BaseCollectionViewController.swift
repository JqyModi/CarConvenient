//
//  BaseCollectionViewController.swift
//  LT
//
//  Created by Modi on 2018/6/22.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh

//private let reuseIdentifier = "Cell"

class BaseCollectionViewController: BaseViewController {

    // MARK: - TableView
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        self.layout = layout
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    /// 向外提供布局变量
    open var layout: UICollectionViewFlowLayout?
    
    override func loadView() {
        
        super.loadView()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
            make.bottom.equalTo(self.view.safeArea.bottom)
        }
//        collectionView.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalToSuperview()
//        }
    }
    
    open var identifier: String = "UICollectionViewCell" {
        didSet {
            if let _ = Bundle.main.path(forResource: identifier, ofType: "nib") {
                let nib = UINib(nibName: identifier, bundle: nil)
                collectionView.register(nib, forCellWithReuseIdentifier: identifier)
            }else {
                if let cls = NSClassFromString(identifier) {
                    collectionView.register(cls, forCellWithReuseIdentifier: identifier)
                }
            }
        }
    }
    
    open var dataSource: [Any] = Array() {
        didSet{
            if dataSource.count == 0 {
                print("无数据///上线前删掉")
                dataSource = ["假数据一","假数据二","假数据三","假数据四","假数据五"]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    open func setupCollectionView() {
        setupCollectionHeaderView()
        setupCollectionFooterView()
    }
    
    /// 刷新数据
    @objc open func refreshData() {}
    
    /// 数据翻页
    @objc open func pageTurning() {}
    
    open func setupCollectionHeaderView() {
        
    }
    
    open func setupCollectionFooterView() {
        
    }

}
extension BaseCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
extension BaseCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

//
//  MDFlowView.swift
//  AMFC
//
//  Created by Modi on 2018/8/1.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit

private let cellWithReuseIdentifier = "MDFlowViewCollectionViewCell"

protocol MDFlowViewDelegate: class {
//    func pre()
//    func next()
    
    func didSelectItemAt(collectionView: UICollectionView, indexPath: IndexPath)
    
}

class MDFlowView: UIView {

    weak var delegate: MDFlowViewDelegate?
    
    var xib_collectionView: UICollectionView!
    
    var xib_flowLayout: UICollectionViewFlowLayout!
    
    var itemWidth: CGFloat = SCREEN_WIDTH
    var itemHeight: CGFloat = SCREEN_HEIGHT
    
    var data: [MDFlowViewCollectionViewCellVModel]? {
        didSet {
//            data1 = data
            xib_collectionView.reloadData()
        }
    }
    
    var data1: [MDFlowViewCollectionViewCellVModel]? {
        get {
            var tempData = [MDFlowViewCollectionViewCellVModel]()
            for i in 0..<10 {
                let temp = MDFlowViewCollectionViewCellVModel(vm_image: "image_\(i)", vm_name: "name_\(i)", vm_desc: "desc_\(i)", vm_number: "number_\(i)", vm_phone: "phone_\(i)")
                tempData.append(temp)
            }
            return tempData
        }
        
        set {
            self.data1 = newValue
        }
    }
    
    convenience init(frame: CGRect, data: [MDFlowViewCollectionViewCellVModel]?) {
        self.init(frame: frame)
        self.data = data
        
        setupCollectionView(frame: frame)
        
        setupLeftAndRigthBtn()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension MDFlowView {
    
    private func setupCollectionView(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        xib_flowLayout = layout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
//        itemWidth = frame.width / 2
//        itemHeight = frame.height
//        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        layout.scrollDirection = .horizontal
        
        xib_collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        xib_collectionView.backgroundColor = UIColor.clear
        xib_collectionView.dataSource = self
        xib_collectionView.delegate = self
        
        xib_collectionView.isPagingEnabled = true
        xib_collectionView.showsVerticalScrollIndicator = false
        xib_collectionView.showsHorizontalScrollIndicator = false
        xib_collectionView.register(UINib(nibName: "MDFlowViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellWithReuseIdentifier)
        
        addSubview(xib_collectionView)
        
        xib_collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    private func setupLeftAndRigthBtn() {
        let leftBtn = UIButton()
        leftBtn.setTitle("", for: .normal)
        leftBtn.setImage(#imageLiteral(resourceName: "ic_pull_left_black"), for: .normal)
        leftBtn.tag = 10001
        let rightBtn = UIButton()
        rightBtn.setTitle("", for: .normal)
        rightBtn.setImage(#imageLiteral(resourceName: "ic_pull_right_black"), for: .normal)
        rightBtn.tag = 10002
        addSubview(leftBtn)
        addSubview(rightBtn)
        
        leftBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(-5)
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftBtn)
            make.right.equalTo(self.snp.right).offset(-5)
        }
        
        leftBtn.addTarget(self, action: #selector(btnClicked(sender:)), for: .touchUpInside)
        rightBtn.addTarget(self, action: #selector(btnClicked(sender:)), for: .touchUpInside)
    }
    
    @objc private func btnClicked(sender: UIButton) {
        switch sender.tag {
        case 10001:
            debugPrint("上一页 --------------------------> \(sender.tag)")
            
            if xib_collectionView.contentOffset.x == 0 {
                xib_collectionView.contentOffset.x = 0
            }else {
                xib_collectionView.contentOffset.x -= self.width
            }
            break
        case 10002:
            let page: Int = (data?.count)!/2 - 1
            if page < 0 {
                return
            }
            debugPrint("下一页 --------------------------> \(page)")
            if xib_collectionView.contentOffset.x == CGFloat(page) * self.width {
                xib_collectionView.contentOffset.x = CGFloat(page) * self.width
            }else {
                xib_collectionView.contentOffset.x += self.width
            }
            break
        default:
            break
        }
    }
}
extension MDFlowView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellWithReuseIdentifier, for: indexPath) as! MDFlowViewCollectionViewCell
        
        // 解决复用时图片没有清除问题
        cell.xib_image.image = #imageLiteral(resourceName: "img_face_min")
        cell.model = data?[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data == nil ? 0 : (data?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width/2, height: collectionView.height)
    }
    
    // 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let d = self.delegate {
            d.didSelectItemAt(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
}



//
//  STPlaceOfOwnershipVC.swift
//  CarConvenient
//
//  Created by suteer on 2019/2/18.
//  Copyright © 2019 modi. All rights reserved.
//

import UIKit

class STPlaceOfOwnershipVC: UIView {
    let identifier = "STTitleCCell"
    var dataArr  = NSArray(contentsOfFile: Bundle.main.path(forResource: "STPlaceOfOwnershipVC", ofType: "plist")!) as! [String]
    var  delegate :  AnyDelegate?
    lazy var collection :UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        let szie = (SCREEN_WIDTH-8)/9
        layout.itemSize = CGSize(width: szie, height: szie)
        let coll = UICollectionView(frame: self.bounds, collectionViewLayout:layout)
        coll.delegate = self 
        coll.dataSource = self 
        coll.backgroundColor = Color.md_DDDDDD
        let nib = UINib(nibName:identifier, bundle: Bundle.main)
        coll.register(nib, forCellWithReuseIdentifier:identifier)
        return coll
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collection)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
//MARK:---UICollectionViewDelegate,UICollectionViewDataSource代理
extension STPlaceOfOwnershipVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! STTitleCCell
        cell.titleL.text = dataArr[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.delegateCilckBtns!(data: dataArr[indexPath.row])
        
    }
    
}




//代理设置
@objc protocol AnyDelegate{
    @objc optional func delegateCilckBtns(data:Any)
}

//
//  CCIntegralMallViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/12.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCIntegralMallViewController: BaseCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "积分商城"
    }
    
    override func setupCollectionView() {
        super.setupCollectionView()
        
        self.identifier = "CCIntegralMallCollectionViewCell"
        self.collectionView.backgroundColor = UIColor(rgba: "#EEEEEE")
    }
    
    override func setupCollectionHeaderView() {
        super.setupCollectionHeaderView()
        
        let hv = CCIntegralMallHeaderView.md_viewFromXIB() as! CCIntegralMallHeaderView
        hv.autoresizingMask = .flexibleRightMargin
        collectionView.addSubview(hv)
        
        hv.clickBlock = {(sender) in
            if let btn = sender as? UIButton {
                let vc = CCExchangeRecordViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

}
extension CCIntegralMallViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as! CCIntegralMallCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH-5)/2, height: 202)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: SCREEN_WIDTH*(200/375))
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

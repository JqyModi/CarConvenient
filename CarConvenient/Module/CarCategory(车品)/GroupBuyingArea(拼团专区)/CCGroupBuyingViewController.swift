//
//  CCGroupBuyingViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/28.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCGroupBuyingViewController: BaseCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        title = "拼团专区"
    }

    override func setupCollectionView() {
        super.setupCollectionView()
        
        collectionView.backgroundColor = UIColor.white
        self.identifier = "CCGroupBuyingCollectionViewCell"
        
    }
    
    override func setupCollectionFooterView() {
        super.setupCollectionFooterView()

//        let fv = CCGroupBuyingFooterView.md_viewFromXIB() as! CCGroupBuyingFooterView
//        fv.autoresizingMask = .flexibleWidth
//        self.view.addSubview(fv)
//        let saveAreaHeight = IPONEX ? SaveAreaHeight : 0
//        let height = SCREEN_WIDTH*(50/375)+saveAreaHeight
//        fv.snp.makeConstraints { (make) in
//            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(height)
//        }
//
//        collectionView.snp.makeConstraints{ (make) in
//            make.height.equalTo(collectionView.height-height)
//        }
        view.sendSubview(toBack: collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
            make.bottom.equalTo(self.view.safeArea.bottom).offset(-(SCREEN_WIDTH*(50/375)))
        }
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        switch sender.tag {
        case 10001:
            
            break
        case 10002:
            let vc = CCMyGroupViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
    

}
extension CCGroupBuyingViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CCGroupBuyingCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.width/2
        let height = width + 8*5 + (18 + 15*2 + 21)
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//
//  CCServiceViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/22.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

class CCServiceViewController: BaseCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let Source = NSArray(contentsOfFile: Bundle.main.path(forResource: "CCServiceViewController", ofType: "plist")!) as! [[[String:String]]]
        dataSource = Mapper<STServiceViewControllerMode>().mapArrayOfArrays(JSONObject: Source)!
        
        navigationItem.titleView = titlePic
        collectionView.register(CCServiceHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: UICollectionElementKindSectionHeader)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: UICollectionElementKindSectionFooter)
        identifier = "STServiceCCell"
        
    }
    

    lazy var titlePic : UIImageView = {
        let imge = UIImageView()
        imge.image = UIImage(named: "icon_name_n-1")
        return imge
    }()
    

}
extension CCServiceViewController {
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return   dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataSource[section] as! [CCServiceViewController]).count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dictArr = dataSource as! [[STServiceViewControllerMode]]
        let mode = dictArr[indexPath.section][indexPath.row]
        let cell : STServiceCCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! STServiceCCell
        cell.updateCell(mode: mode)
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = STRoadsideAssistanceVC(nibName: "STRoadsideAssistanceVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension CCServiceViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH/4, height: SCREEN_WIDTH/4)
    } 
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
         if section == dataSource.count - 1 {//最后一个
           return CGSize.zero
        }else{
           return CGSize(width: SCREEN_WIDTH, height: 1) 
        }
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 {
            return CGSize(width: SCREEN_WIDTH, height: SCREEN_WIDTH*0.35)//562
        }else{
            return CGSize.zero
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let ReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind , for: indexPath)
        
        if kind == UICollectionElementKindSectionHeader {
           
        }else{
            ReusableView.backgroundColor = Color.md_DDDDDD
        }
        return ReusableView
    }
    
    
    
}


class CCServiceHeader : UICollectionReusableView {
    
    lazy var pic : UIImageView = {
        let imge = UIImageView(image: UIImage(named: "print_load"))
        imge.frame = bounds
        return imge
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(pic)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

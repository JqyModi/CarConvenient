//
//  ZAGoodsCatogeryTableViewCell.swift
//  ZhongAiHealth
//
//  Created by 微标杆 on 2018/10/8.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit

private let identifier = "CCCarTypeCollectionViewCell"

class CCCarTypeDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = UIColor.white
            collectionView.isScrollEnabled = false
            collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        }
    }
    
    var dataSource = [String]()
    
    
}
extension CCCarTypeDetailTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CCCarTypeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CCCarTypeCollectionViewCell
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

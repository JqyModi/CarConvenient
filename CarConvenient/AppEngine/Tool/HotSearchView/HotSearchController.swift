//
//  HotSearchController.swift
//  MingChuangWine
//
//  Created by Modi on 2018/6/15.
//  Copyright © 2018年 江启雨. All rights reserved.
//

import UIKit

class HotSearchController: UIViewController {

//    @property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//    @property (nonatomic, strong) HistoryViewCell *cell;
//    @property (nonatomic, strong) NSMutableArray *data;
    
//    var collectionView: UICollectionView?
//    var cell: HotSearchCell?
//    var data: [String] = ["测试","云标签","历史记录","测试","妈妈说标题要长","机智的手哥"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 0, y: 0, width: 375, height: 100)
        let data = ["哈哈", "呵呵呵", "略略略略", "嘻嘻嘻嘻嘻", "😔", "😝O(∩_∩)O哈哈~"]
        let v = MDHotSearchView(data: nil, type: .center, margin: 5)
        self.view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(300)
        }
    }

}

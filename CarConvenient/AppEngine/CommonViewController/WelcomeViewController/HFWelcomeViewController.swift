//
//  HFWelcomeViewController.swift
//  Ecosphere
//
//  Created by 姚鸿飞 on 2017/6/13.
//  Copyright © 2017年 encifang. All rights reserved.
//

import UIKit
import SnapKit


private let reuseIdentifier = "WelcomeCell"

class HFWelcomeViewController: UICollectionViewController {
    

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    private let welcomeArray: [String] = {
        var strs = [String]()
        strs = ["qb_guide_1",
                "qb_guide_2",
                "qb_guide_3"]
        return strs
    }()
    
    private let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(TLWelcomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.flowLayout.itemSize = UIScreen.main.bounds.size
        self.flowLayout.minimumLineSpacing = 0;
        self.flowLayout.minimumInteritemSpacing = 0;
        self.collectionView?.backgroundColor = UIColor.white
//        self.automaticallyAdjustsScrollViewInsets = false
        
        self.pageControl.numberOfPages = welcomeArray.count
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(self.pageControl)
        
        self.pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(-30)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return welcomeArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:TLWelcomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TLWelcomeCollectionViewCell
        cell.updateCell(imageName: welcomeArray[indexPath.row], row: indexPath.row, totalCount: welcomeArray.count - 1)
        
        let button = UIButton()
        button.addTarget(self, action: #selector(self.buttonClickOnCallBack), for: UIControlEvents.touchUpInside)
//        button.setTitle("点击进入", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button .setTitleColor(UIColor.orange, for: .normal)
        
//        for item in cell.contentView.subviews {
//            item.removeFromSuperview()
//        }

        cell.contentView.addSubview(button)

        button.snp.makeConstraints { (make) in
            make.edges.equalTo(cell.contentView)
        }
        button.isHidden = true;
        if indexPath.row == welcomeArray.count - 1{
            button.isHidden = false
        }
    
        return cell
    }
    
    @objc func buttonClickOnCallBack() {
        HFAppEngine.shared.gotoLoginViewController()
    }

    //MARK: ScrollViewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x/SCREEN_WIDTH)
    }
    
}

//
//  STRoadsideAssistanceVCViewController.swift
//  CarConvenient
//
//  Created by suteer on 2019/2/13.
//  Copyright © 2019 modi. All rights reserved.
//

import UIKit

class STRoadsideAssistanceVC: BaseViewController {
    
    @IBOutlet weak var contenL: UILabel!
    
    @IBOutlet weak var pirceL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = titleL
        addRightItem(title: "订单记录", imageName: "", fontColor: Color.md_1B82D2)
        ///导航栏黑线
        navigationController?.navigationBar.shadowImage =  UIImage(color: Color.md_DDDDDD, size: CGSize(width: SCREEN_WIDTH, height: 1))!
        // Do any additional setup after loading the view.
    }
    
    ///立即救援
    @IBAction func clickRescueBtn() {
        let vc = STRescueDataVC(nibName: "STRescueDataVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    ///订单记录
    override func clickRight(sender: UIButton) {
        
    }

    lazy var titleL : UILabel = {
        let tit = UILabel()
        tit.text = "车便捷救援"
        tit.font = UIFont.systemFont(ofSize: 17)
        tit.textColor = Color.md_333333
        return tit
    }()
    
}

//
//  STRescueDataVC.swift
//  CarConvenient
//
//  Created by suteer on 2019/2/15.
//  Copyright © 2019 modi. All rights reserved.
//

import UIKit

class STRescueDataVC: BaseViewController {
    
    
    @IBOutlet weak var carPic: UIImageView!
    ///北京奔驰GLC260
    @IBOutlet weak var carNameL: UILabel!
    ///2.0T 2018
    @IBOutlet weak var carTimeL: UILabel!
    
    ///"渝     "
    @IBOutlet weak var ascriptionBtn: UIButton!
    ///车牌号
    @IBOutlet weak var carNumberTF: UITextField!
    
    ///车牌
    @IBOutlet weak var phoneTF: UITextField!
    ///人姓名
    @IBOutlet weak var userNameTF: UITextField!
    ///广东省广州市天河区
    @IBOutlet weak var addressL: NSLayoutConstraint!
    ///详细地址
    @IBOutlet weak var addressTF: UITextField!
    
    ///经度113.33 纬度23.12
    @IBOutlet weak var longOrlat_itudeL: UILabel!
    
    
    lazy var placeView : STPlaceOfOwnershipVC = {
        
        let dataArr  = NSArray(contentsOfFile: Bundle.main.path(forResource: "STPlaceOfOwnershipVC", ofType: "plist")!) as! [String]
        ///行
        let hang = dataArr.count/9 + (dataArr.count%9 == 0 ? 0 : 1)
        let height = (SCREEN_WIDTH-8)/9 * CGFloat(hang) 
        let vie = STPlaceOfOwnershipVC(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: height + BottomSaveAreaHeight))
        return vie
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "立即救援"
        addRightItem(title: "重新定位", imageName: "", fontColor: Color.md_1B82D2)
        // Do any additional setup after loading the view.
    }
    
    ///换车
    @IBAction func clickChangeCarBtn(_ sender: UITapGestureRecognizer) {
        //carPic
        //carNameL
        //carTimeL
        
    }
    
    ///粤A
    @IBAction func clikcAscriptionBtn() {
        self.showAlerView(showView: placeView, layoutType: PopupLayoutType.bottom)
    }
    
    
    ///下一步
    @IBAction func clickNextStepBtn() {
        
    }
    
}

extension STRescueDataVC:AnyDelegate {
    
    func delegateCilckBtns(data:Any){
        self.sl_popupController.dismiss()
        ascriptionBtn.setTitle((data as! String), for: UIControlState.normal) 
    }
}






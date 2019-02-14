//
//  CCPersonalCenterViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/1/29.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCPersonalCenterViewController: BaseCollectionViewController {

    private lazy var dataSources: [[String: String]] = {
        var temps = [[String: String]]()
        
        var titles = ["车主认证", "爱车档案", "我的物业", "个人设置", "收货地址", "客服中心", "招商加盟", "关于我们"]
        var imgs = ["btn_attestation_n", "btn_my_record_n", "btn_setting_n", "btn_setting_n", "btn_setting_n", "btn_service_n", "btn_league_n", "btn_about_us_n"]
        for i in (0..<titles.count) {
            let dic = ["title": titles[i], "img": imgs[i]]
            temps.append(dic)
        }
        return temps
    }()
    
    var headerView: CCPersonalCenterHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人中心"
    }

    override func setupCollectionView() {
        super.setupCollectionView()
        
        self.identifier = "CCPersonalCenterCollectionViewCell"
        collectionView.backgroundColor = UIColor.white
        
        addRightItem(title: "", imageName: "btn_setting_n(1)")
    }
    
    override func clickRight(sender: UIButton) {
        super.clickRight(sender: sender)
        let vc = CCSettingViewController()
        vc.plistName = "setting"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func setupCollectionHeaderView() {
        super.setupCollectionHeaderView()
        let hv = CCPersonalCenterHeaderView.md_viewFromXIB() as! CCPersonalCenterHeaderView
        hv.autoresizingMask = .flexibleWidth
        hv.markLogin = true
        self.headerView = hv
        hv.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: hv.headerViewH)
        self.view.addSubview(hv)
        
        hv.clickBlock = {(sender) in
            if let btn = sender as? UIButton {
                switch btn.tag {
                case 10001: // 登录
                    HFAppEngine.shared.gotoLoginViewController()
                    break
                case 10002:
                    let vc = CCShoppingCartViewController.init(nibName: "CCShoppingCartViewController", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 10003:
                    break
                case 10004:
                    break
                case 10005:
                    let vc = CCMyWalletViewController()
                    vc.plistName = "myWallet"
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 10006:
                    break
                case 10007:
                    break
                case 10008:
                    break
                case 10009:
                    break
                case 10010:
                    break
                default:
                    break
                }
            }
        }
    }

}
extension CCPersonalCenterViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CCPersonalCenterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CCPersonalCenterCollectionViewCell
        cell.updateCell(dic: dataSources[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = CCOwnersCertificationViewController.init(nibName: "CCOwnersCertificationViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            break
        case 2:
            let vc = CCMyPropertyViewController.init(nibName: "CCMyPropertyViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = CCUserSettingViewController()
            vc.plistName = "usersetting"
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 4:
            let vc = CCManagerAddressViewController.init(nibName: "CCManagerAddressViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 5:
            break
        case 6:
            let vc = CCCooperationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 7:
            break
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: SCREEN_WIDTH*(90/375))
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        var height: CGFloat = 0
//        if headerView?.markLogin ?? false {
//            height = SCREEN_WIDTH * ((104+104+112+119)/375) + 16
//        }else {
//            height = SCREEN_WIDTH * ((104+104+112)/375) + 16
//        }
        return CGSize(width: SCREEN_WIDTH, height: headerView?.headerViewH ?? 0)
    }
}

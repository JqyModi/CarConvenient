//
//  LTCommentWorkerViewController.swift
//  LT
//
//  Created by Modi on 2018/7/4.
//  Copyright © 2018年 Modi. All rights reserved.
//

import UIKit
import SVProgressHUD
import AssetsLibrary

/// 评论来源
///
/// - CommonFromBoss: 评论需求方
/// - CommonFromWorker: 评论工人
enum CommonFromType {
    case CommonFromBoss(pt_id: String), CommonFromWorker(pt_id: String), none
}

class LTCommentViewController: BaseViewController {
    
    @IBOutlet weak var xib_content: UITextView!
    
    @IBOutlet weak var xib_star: HPYStarView!
    
    @IBOutlet weak var xib_imageContainerBgView: UIView!
    @IBOutlet weak var xib_imageContainerBgViewH: NSLayoutConstraint!
    
    let manager = HXPhotoManager(type: HXPhotoManagerSelectedType.photo)
    let config = HXPhotoConfiguration()
    
    var models = [PostInfoModel]()
    
    var imgPaths: [String] = []
    var imgPathStrs = ""
    
    var fromType: CommonFromType = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        handleImageSelect()
    }
    
    private func setupUI() {
        switch fromType {
        case .CommonFromBoss(pt_id: _):
            title = "评论需求方"
            break
        case .CommonFromWorker(pt_id: _):
            title = "评论工人"
            break
        default:
            break
        }
    }

    /// 发表评论
    ///
    /// - Parameter sender: -
    @IBAction func xib_Ok(_ sender: UIButton) {
        
        if xib_content.text.isEmpty {
            SVProgressHUD.showInfo(withStatus: "请输入评论信息")
            return
        }
        
        let score = (xib_star.selectedCount) * 20
        var ptid = "0"
        switch fromType {
        case .CommonFromBoss(pt_id: let ptID):
            ptid = ptID
            break
        case let .CommonFromWorker(pt_id: ptID):
            ptid = ptID
            break
        default:
            break
        }
        
//        MyCent?.requestCommon(type: fromType, pt_id: ptid, com_content: xib_content.text, com_imgs: getImgPaths(imgPathsArr: self.imgPaths), score: "\(score)", complete: { (isSucceed, msg) in
//            switch isSucceed {
//            case true:
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//                    self.navigationController?.popViewController(animated: true)
//                }
//                break
//            case false:
//                SVProgressHUD.showError(withStatus: msg)
//                break
//            }
//        })
    }
    
}

extension LTCommentViewController {
    
    /// 获取图片地址数组的拼接字符串
    ///
    /// - Parameter imgPathsArr: 图片地址数组
    /// - Returns: 拼接后字符串：,分隔
    private func getImgPaths(imgPathsArr: [String]) -> String {
        var tempStr: String = ""
        for i in 0..<imgPathsArr.count {
            let item = imgPathsArr[i]
            tempStr += "\(item)"
            if i != imgPathsArr.count - 1 {
                tempStr += ","
            }
        }
        debugPrint("paths ---> \(tempStr)")
        return tempStr
    }
    
    /// 上传单张图片并回调
    ///
    /// - Parameters:
    ///   - img: 图片
    ///   - finishBlock: 回调
    private func uploadImg(img: UIImage, finishBlock: ((_ path: String) -> Void)?) {
        SVProgressHUD.show()
        // 先清空原来的否则会重复上传图片路径
        self.imgPaths.removeAll()
        //上传图片获取返回地址
        CommonCent?.uploadImagesWith64(image: img, complete: { (isSucceed, msg, url) in
            switch isSucceed {
            case true:
                self.imgPaths.append(url!)
                SVProgressHUD.dismiss()

                finishBlock!(url!)

                break
            case false:
                SVProgressHUD.showError(withStatus: msg)
                break
            }
        })
    }
    
    /// 上传多张图片并回调
    ///
    /// - Parameters:
    ///   - img: 图片
    ///   - finishBlock: 回调
    private func uploadImgs(imgs: [UIImage], finishBlock: (() -> Void)?) {
        SVProgressHUD.show()
        // 先清空原来的否则会重复上传图片路径
        self.imgPaths.removeAll()
        for img in imgs {
            //上传图片获取返回地址
            CommonCent?.uploadImagesWith64(image: img, complete: { (isSucceed, msg, url) in
                switch isSucceed {
                case true:
                    debugPrint("url ------> \(url)")
                    self.imgPaths.append(url!)
                    break
                case false:
                    SVProgressHUD.showError(withStatus: msg)
                    break
                }
            })
        }
        SVProgressHUD.dismiss()
        if finishBlock != nil {
            finishBlock!()
        }
    }
}
extension LTCommentViewController: HXPhotoViewDelegate {
    
    // MARK: - 处理图片选择
    func handleImageSelect() {
        config.photoMaxNum = 3
        // 设置后才会走选择图片代理
        config.requestImageAfterFinishingSelection = true
        manager?.configuration = config
        
        self.automaticallyAdjustsScrollViewInsets = true
        let imageView = HXPhotoView(frame: CGRect(x: 0, y: 0, width: xib_imageContainerBgView.width, height: xib_imageContainerBgView.width/3.0), manager: manager)
        imageView?.delegate = self
        imageView?.backgroundColor = UIColor.white
        xib_imageContainerBgView.addSubview(imageView!)
    }
    
    // MARK: - HXPhotoViewDelegate
    func photoView(_ photoView: HXPhotoView!, updateFrame frame: CGRect) {
        xib_imageContainerBgViewH.constant = frame.size.height
    }
    
    func photoView(_ photoView: HXPhotoView!, imageChangeComplete imageList: [UIImage]!) {
        debugPrint("imageList --------------------------> \(imageList)")
        //上传多张图片
        self.uploadImgs(imgs: imageList, finishBlock: {
            //上传参数
        })
    }
    
}

//
//  HFImagePickerManager.swift
//  3HMall
//
//  Created by 姚鸿飞 on 2018/4/18.
//  Copyright © 2018年 姚鸿飞. All rights reserved.
//

import UIKit

class HFImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let shared: HFImagePickerManager = HFImagePickerManager()
    
    /// 当前显示的控制器
    fileprivate class var currentDisplayViewController: UIViewController? {
        get{ return HFImagePickerManager.currentViewController() }
    }
    
    var succeedCallBack: ((_ image: UIImage) -> Void)?
    
    func show(sourceType: UIImagePickerControllerSourceType = .photoLibrary, succeed:@escaping ((_ image: UIImage) -> Void)) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let imagePicker:UIImagePickerController = UIImagePickerController.init()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourceType
            HFImagePickerManager.currentDisplayViewController?.present(imagePicker, animated: true, completion: nil)
            self.succeedCallBack = succeed
        }else {
            print("模拟器中无法打开照相机或相册，请在真机上使用")
        }
    }
    
    /// 获取当前显示的控制器
    ///
    /// - Parameter base: 基控制器
    /// - Returns: 当前显示的控制器
    fileprivate class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //获取图片后的操作
        let backImage:UIImage = info["UIImagePickerControllerEditedImage"] as! UIImage
        picker.dismiss(animated: true, completion: nil)
        let imageData:NSData  = UIImageJPEGRepresentation(backImage, 0.1)! as NSData
        
        let image:UIImage = UIImage.init(data: imageData as Data)!
        self.succeedCallBack?(image)
    }
    
    
    
}

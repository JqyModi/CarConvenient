//
//  QYTools.swift
//  MingChuangWine
//
//  Created by Modi on 2018/6/11.
//  Copyright © 2018年 江启雨. All rights reserved.
//

import UIKit
import AssetsLibrary
//import MWPhotoBrowser
import Photos
import MJRefresh

class QYTools: NSObject {
    
    // 创建单例
    static let shared = QYTools()
    // 私有化初始化方法
    private override init() {
        
    }
    
    
    // MARK: - Load Assets: 获取系统相册所有图片
    
    // MWPhotoBrowser
    /*
    let photos = NSMutableArray()
    let thumbs = NSMutableArray()
    let photo,thumb: MWPhoto?
    var displayActionButton = true
    var displaySelectionButtons = false
    var displayNavArrows = false
    var enableGrid = true
    var startOnGrid = true
    var autoPlayOnAppear = false


    //设置成grid
    // Options
    displayActionButton = false
    displaySelectionButtons = true
    startOnGrid = indexPath.row == 4
    enableGrid = false

    let copy: NSMutableArray = self._assets
    if (NSClassFromString("PHAsset") != nil) {
        let screen = UIScreen.main
        let scale = screen.scale
        let imageSize = CGFloat.maximum(screen.bounds.size.width, screen.bounds.size.height) * 1.5
        let imageTargetSize = CGSize(width: imageSize * scale, height: imageSize * scale)
        let thumbTargetSize = CGSize(width: imageSize / 3.0 * scale, height: imageSize / 3.0 * scale)
        for asset in copy {
            photos.addObjects(from: [MWPhoto(asset: asset as! PHAsset, targetSize: imageTargetSize)])
            thumbs.addObjects(from: [MWPhoto(asset: asset as! PHAsset, targetSize: thumbTargetSize)])
        }
    }else {
        for asset in copy {
            let asset1 = asset as? ALAsset
            let photo = MWPhoto(url: asset1?.defaultRepresentation().url())
            photos.addObjects(from: [photo])
            let thumb = MWPhoto(image: UIImage(cgImage: asset1?.thumbnail() as! CGImage))
            thumbs.addObjects(from: [thumb])
            if (asset1?.value(forProperty: ALAssetPropertyType) as! String) == ALAssetTypeVideo {
                photo?.videoURL = asset1?.defaultRepresentation().url()
                thumb?.isVideo = true
            }
        }
    }

    self.photos = photos
    self.thumbs = thumbs
    debugPrint("photos -----> \(photos.count)")
    debugPrint("thumbs -----> \(thumbs.count)")

    // Create browser
    let browser = MWPhotoBrowser(delegate: self)
    browser?.displayActionButton = displayActionButton
    browser?.displayNavArrows = displayNavArrows;
    browser?.displaySelectionButtons = displaySelectionButtons;
    browser?.alwaysShowControls = displaySelectionButtons;
    browser?.zoomPhotosToFill = true;
    browser?.enableGrid = enableGrid;
    browser?.startOnGrid = startOnGrid;

    browser?.enableGrid = true;
    browser?.startOnGrid = true;

    browser?.enableSwipeToDismiss = false;
    browser?.autoPlayOnAppear = autoPlayOnAppear;
    browser?.setCurrentPhotoIndex(0)

    // Reset selections
    if (displaySelectionButtons) {
        self._selections = NSMutableArray()
        for i in 0..<photos.count {
            self._selections.addObjects(from: [NSNumber.init(value: false)])
        }
    }

    // 跳转到选择器
    // Modal
    let nc = UINavigationController(rootViewController: browser!)
    nc.modalTransitionStyle = .crossDissolve

    browser?.modalTransitionStyle = .crossDissolve
    self.present(nc, animated: true, completion: nil)
    */
    
    class func md_loadAssets() -> [UIImage] {
        var images: [UIImage]?
        if (NSClassFromString("PHAsset") != nil) {
            let status = PHPhotoLibrary.authorizationStatus()
            if status == PHAuthorizationStatus.notDetermined {
                PHPhotoLibrary.requestAuthorization { (status) in
                    if status == PHAuthorizationStatus.authorized {
                        images = self.md_performLoadAssets()
                    }
                }
            }else if status == PHAuthorizationStatus.authorized {
                images = self.md_performLoadAssets()
            }
        }else {
            images = self.md_performLoadAssets()
        }
        return images!
    }
    
    class func md_performLoadAssets() -> [UIImage] {
        let _assets = NSMutableArray.init()
        
        if (NSClassFromString("PHAsset") != nil) {
            DispatchQueue.global().async {
                let options = PHFetchOptions()
                options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                let fetchResults = PHAsset.fetchAssets(with: options)
                fetchResults.enumerateObjects({ (obj, idx, stop) in
                    _assets.addObjects(from: [obj])
                })
                if fetchResults.count > 0 {
                    //刷新
                    
                }
            }
        }else {
            let alAssetsLibrarys = ALAssetsLibrary.init()
            
            DispatchQueue.global().async {
                let assetGroups = NSMutableArray()
                let assetURLDictionaries = NSMutableArray()
                let assetEnumerator: (_ result: ALAsset, _ index: Int, _ stop: UnsafeMutablePointer<ObjCBool>?) -> Void = { (result, index, stop) in
                    if result != nil {
                        let assetType: NSString = result.value(forProperty: ALAssetPropertyType) as! NSString
                        if assetType.isEqual(to: ALAssetTypePhoto) || assetType.isEqual(to: ALAssetTypeVideo) {
                            assetURLDictionaries.addObjects(from: result.value(forProperty: ALAssetPropertyURLs) as! [Any])
                            let url = result.defaultRepresentation().url()
                            alAssetsLibrarys.asset(for: url, resultBlock: { (asset) in
                                if (asset != nil) {
                                    _assets.addObjects(from: [asset])
                                    if _assets.count == 1 {
                                        //刷新
                                    }
                                }
                            }, failureBlock: { (error) in
                                debugPrint("operation was not successfull!")
                            })
                        }
                    }
                }
                
                let assetGroupEnumerator: (_ group: ALAssetsGroup, _ stop: UnsafeMutablePointer<ObjCBool>?) -> Void = { (group, stop) in
                    if group != nil {
                        group.enumerateAssets(options: NSEnumerationOptions.reverse, using: assetEnumerator as! ALAssetsGroupEnumerationResultsBlock)
                        assetGroups.addObjects(from: [group])
                    }
                }
                
                alAssetsLibrarys.enumerateGroupsWithTypes(ALAssetsGroupAll, usingBlock: assetGroupEnumerator as! ALAssetsLibraryGroupsEnumerationResultsBlock, failureBlock: { (error) in
                    debugPrint("There is an error")
                })
                
            }
        }
        return _assets as! [UIImage]
    }
}
extension QYTools {
    // MARK: - UITextView提示文字
    class func md_placeHolderLabel(text: String = "请输入描述信息") -> UILabel {
        let label = UILabel()
        
        label.text = text
//        label.textColor = UIColor.lightGray
        label.textColor = UIColor.init(rgba: "#999999")
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }
    
    /// 将整型数组转字符串
    ///
    /// - Parameters:
    ///   - arr: 数组
    ///   - str: 分隔字符
    /// - Returns: 字符串
    class func md_getStrWithString(arr: [Int],str: String) -> String {
        var temp = ""
        for item in arr {
            temp += "\(item)\(str)"
        }
        if temp.count > 0 {
            temp.removeLast()
        }
        return temp
    }
}

extension QYTools {
    /// 刷新
    /// - Parameters:
    ///   - target: self
    ///   - scrollView: 刷新对像
    ///   - refresh: 刷新方法
    ///   - loadMore: 刷新方法
    class func refreshData(target: Any,scrollView:UIScrollView,refresh:Selector?,loadMore:Selector?) {
        if( refresh != nil ){
            let  header = MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: refresh)
            header?.stateLabel.font = UIFont.systemFont(ofSize: 14)
            header?.stateLabel.textColor = UIColor.darkGray
            //            header?.lastUpdatedTimeLabel.isHidden = true;
            header?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            header?.lastUpdatedTimeLabel.isHidden = false
            // 下拉可以刷新 ：松开立即刷新 ：正在刷新数据中...
            header?.setTitle(NSLocalizedString("下拉可以刷新", comment: ""), for: MJRefreshState.idle)
            header?.setTitle(NSLocalizedString("松开立即刷新", comment: ""), for: MJRefreshState.pulling)
            header?.setTitle(NSLocalizedString("正在刷新数据中...", comment: ""), for: MJRefreshState.refreshing)
            scrollView.mj_header = header
        }
        if( loadMore != nil ){
            let footer = MJRefreshAutoStateFooter(refreshingTarget: target, refreshingAction: loadMore)
            footer?.stateLabel.font = UIFont.systemFont(ofSize: 14)
            footer?.stateLabel.textColor = UIColor.darkGray
            // 点击或上拉加载更多 ：已经全部加载完毕 ：正在加载更多数据...
            footer?.setTitle(NSLocalizedString("点击或上拉加载更多", comment: ""), for: MJRefreshState.idle)
            footer?.setTitle(NSLocalizedString("已经全部加载完毕", comment: ""), for: MJRefreshState.noMoreData)
            footer?.setTitle(NSLocalizedString("正在加载更多数据...", comment: ""), for: MJRefreshState.refreshing)
            scrollView.mj_footer = footer
        }
        
    }
}
// MARK: - 封装打印Log
extension QYTools {
    func Log(log: String) {
        print("QYTools :: Log ====================== \(log)")
    }
}
extension String {
    func Log() {
        print("QYTools :: Log ====================== \(self)")
    }
}

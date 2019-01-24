//
//  FlowLayoutViewController.swift
//  MingChuangWine
//
//  Created by Modi on 2018/6/14.
//  Copyright © 2018年 江启雨. All rights reserved.
//

import Kingfisher
import SVProgressHUD

class FlowLayoutViewController: UIViewController {
    
    var width: CGFloat!
    var images: Array<UIImage>!
    var collectionView:UICollectionView!
    var maskView: UIView!
    var cellRect: CGRect!
    var changeRect: CGRect!
    //MARK: --life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        waterfallCollectionView()
    }
    private func waterfallCollectionView() {
        width = (view.bounds.size.width - 20)/3
        let layout = MDFlowLayout()
        images = []
        
        //从plist下载图片
        let plistPath = Bundle.main.path(forResource: "1.plist", ofType: nil)
//        let dic = NSData(contentsOfFile: plistPath!)
        let arr: [Dictionary<String, Any>] = NSArray.init(contentsOfFile: plistPath!) as! [Dictionary]
        debugPrint("arr ------> \(arr)")
        
        for item in arr {
            let dic = item
            let url: String = dic["img"] as! String
            //下载图片
            KingfisherManager.shared.retrieveImage(with: URL(string: url)!, options: nil, progressBlock: nil) { (img, _, _, _) in
                if let img = img {
                    self.images.append(img)
                }
            }
        }
        
        SVProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            SVProgressHUD.dismiss()
            layout.setSize = {
                return self.images
            }
            layout.scrollDirection = .horizontal
            
            layout.centerBlock = {(point) in
//                self.drawCircle(point: point)
            }
//            layout.scrollDirection = .vertical
            self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
            self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "newCell")
            self.collectionView.backgroundColor = UIColor.white
            self.collectionView.alwaysBounceVertical = true
            
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.view.addSubview(self.collectionView)
        }
        
//        for i in 1..<16 {
//            let image = UIImage(named: String.init(format: "%.2d.png", i))
//            images.append(image!)
//        }
        
        
        
    }
    
    @objc func showPic(btn:UIButton){
        UIView.animate(withDuration: 1, animations: {
            btn.frame = self.cellRect
        }) { (finish) in
            btn.removeFromSuperview()
            self.maskView.removeFromSuperview()
            self.maskView = nil
            self.cellRect = nil
        }
    }
}

extension FlowLayoutViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK: --UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newCell", for: indexPath as IndexPath)
        let imageView = UIImageView(frame: cell.bounds)
        imageView.image = images[indexPath.row]
        let bgView = UIView(frame:cell.bounds)
        bgView.addSubview(imageView)
        cell.backgroundView = bgView
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        maskView = UIView.init(frame: view.bounds)
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.5
        view.addSubview(maskView)
        
        //cell在veiw的位置
        cellRect = cell!.convert(cell!.bounds, to: view)
        let btn = WaterButton.init(frame: cellRect)
        let img = images[indexPath.row]
        btn.wImage = img
        btn.addTarget(self, action: #selector(showPic(btn:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
        //图片长宽的比例与屏幕长宽的比例的对比
        var changeH:CGFloat
        var changeW:CGFloat
        if img.size.width/img.size.height >= view.frame.size.width/view.frame.size.height{
            //对比图片实际宽与屏幕宽
            if img.size.width>view.frame.size.width {
                changeH = img.size.height*view.frame.size.width/img.size.width
                changeRect = CGRect(x: 0, y: (view.frame.size.height-changeH)/2, width:view.frame.size.width, height: changeH)
            }else{
                changeRect = CGRect(x: (view.frame.size.width-img.size.width)/2, y: (view.frame.size.height-img.size.height)/2, width: img.size.width,height: img.size.height)
            }
        }else{
            if img.size.height>view.frame.size.height {
                changeW = img.size.width*view.frame.size.height/img.size.height
                changeRect = CGRect(x: (view.frame.size.width-changeW)/2, y: 0, width: changeW, height: view.frame.size.height)
            }else{
                changeRect = CGRect(x: (view.frame.size.width-img.size.width)/2, y: (view.frame.size.height-img.size.height)/2, width: img.size.width,height: img.size.height)
            }
        }
        
        UIView.animate(withDuration: 1, animations: {
            btn.frame = self.changeRect
        })
        
    }
}

class WaterButton: UIButton {
    
    var wImage:UIImage!{
        didSet{
            wImageView.image = wImage
        }
    }
    private var wImageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        wImageView = UIImageView(frame:bounds)
        addSubview(wImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        wImageView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


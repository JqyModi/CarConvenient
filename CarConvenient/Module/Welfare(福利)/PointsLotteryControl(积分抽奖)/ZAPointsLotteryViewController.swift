//
//  ZAPointsLotteryViewController.swift
//  ZhongAiHealth
//
//  Created by 微标杆 on 2018/9/26.
//  Copyright © 2018年 WBG. All rights reserved.
//

import UIKit
import SVProgressHUD

class ZAPointsLotteryViewController: BaseViewController,ZXDrawPrizeDataSource,ZXDrawPrizeDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var pointsLabel: UILabel!
    private var drawPrizeView: ZXDrawPrizeView!
    private let cellId = "stateCellId"
    private lazy var tableView = UITableView()
    private var drawEnd = true
    private var lotteryArray = [ZALotteryModel]()
    private var drawModel = ZADrawLotteryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLeftItem(title: "", imageName: "ic_back")
     
        pointsLabel.text = "当前可用积分:\(0)"
        
        let offset:CGFloat = 30
        let contentWidth: CGFloat = UIScreen.main.bounds.size.width - offset * 2
        drawPrizeView = ZXDrawPrizeView.init(CGPoint(x: offset, y: (UIScreen.main.bounds.size.height - contentWidth) / 2 - 60), width: contentWidth)
        drawPrizeView.delegate = self
        drawPrizeView.dataSource = self
        self.view.addSubview(drawPrizeView)
        
        let tipsLabel = UILabel()
        tipsLabel.text = "奖品说明"
        tipsLabel.textColor = UIColor(rgba: "#E5000E")
        tipsLabel.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(tipsLabel)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ZALotteryTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(drawPrizeView.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.centerX.equalTo(self.view)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(tipsLabel.snp.bottom).offset(10)
            make.width.centerX.bottom.equalTo(self.view)
        }
        
        self.requestData()
        
    }

    //MARK:Method
    override func requestData() {
        
    }
    
    private func requestDrawLottery(){
        if drawEnd == false {
            return
        }
        
    }
    
    private func drawLottery(){
        var prizeIndex = 0
        for i in 0..<lotteryArray.count{
            if drawModel.prizeid == lotteryArray[i].id{
                prizeIndex = i
            }
        }
        //具体可根据业务数据，定位到index (顺时针顺序)
        //执行动画
        self.drawPrizeView.drawPrize(at: NSInteger(prizeIndex), reject: {
        [unowned self] reject in
        if !reject {
        self.drawEnd = false
        }
        })
    }
    
    private func refreshView() {
        tableView.reloadData()
        drawPrizeView.reloadData()
    }
    
    // MARK: - Event
    override func clickLeft() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lotteryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ZALotteryTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId) as! ZALotteryTableViewCell
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        cell.updateCell(model: lotteryArray[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 15
    }
    
    // MARK: - ZXDrawPrizeDataSource
    func zxDrawPrize(prizeView: ZXDrawPrizeView, labelAt index: NSInteger) -> String? {
        if lotteryArray.count > 0 {
            return lotteryArray[index].prizename!
        }else{
            return nil
        }
    }
    
    func zxDrawPrize(prizeView: ZXDrawPrizeView, imageAt index: NSInteger) -> UIImage? {
        return nil
    }
    
    func zxDrawPrize(prizeView: ZXDrawPrizeView, imageUrlAt index: NSInteger) -> String? {
        if lotteryArray.count > 0 {
            return lotteryArray[index].img!
        }else{
            return nil
        }
    }
    
    ///奖品格子数，不得小于三个
    func numberOfPrize(for drawprizeView: ZXDrawPrizeView) -> NSInteger {
        if lotteryArray.count > 0 {
            return lotteryArray.count
        }else{
            return 4
        }
    }
    ///某一项奖品抽完（不需要，直接return false 即可）
    func zxDrawPrize(prizeView: ZXDrawPrizeView, drawOutAt index: NSInteger) -> Bool {
        return false
    }
    ///指针图片
    func zxDrawPrizeButtonImage(prizeView: ZXDrawPrizeView) -> UIImage {
        return #imageLiteral(resourceName: "global_btn_return_n")
    }
    ///大背景
    func zxDrawPrizeBackgroundImage(prizeView: ZXDrawPrizeView) -> UIImage? {
        return #imageLiteral(resourceName: "img_bargain_n")
    }
    ///滚动背景 （if nil , fill with color）
    func zxDrawPrizeScrollBackgroundImage(prizeView: ZXDrawPrizeView) -> UIImage? {
        return nil
    }
    
    // MARK: - ZXDrawPrizeDelegate
    ///点击抽奖按钮
    func zxDrawPrizeStartAction(prizeView: ZXDrawPrizeView) {
        self.requestDrawLottery()
//        HFAlertController.showAlert(title: "确认抽奖", message: "确认消耗100积分进行抽奖吗?") { (str, str2) in
//            //这里是本地测试的 随机 奖品 index
//
//        }
        //不关注是否正在执行动画，直接调用这个
        //self.drawPrizeView.drawPrize(at: NSInteger(prizeIndex))
    }
    ///动画执行结束
    func zxDrawPrizeEndAction(prizeView: ZXDrawPrizeView, prize index: NSInteger) {
        //本地测试
        self.drawEnd = true
        SVProgressHUD.showSuccess(withStatus: "\(drawModel.prizename!)")
//        print("\(index)")
    }

}

//
//  FJSlectLocationView.swift
//  FJAddressPickerDemo
//
//  Created by jun on 2017/6/20.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let FJItemCVCellIdentifier = "fJItemCVCell"
fileprivate let FJAddressTVCellIdentifier = "fJAddressTVCell"

class FJSelectLocationView: UIView {
    /// 当前级
    fileprivate var level:Int = 1
    /// 所有地址数据源
    fileprivate var totaldataArray:[[AddressModel]] = []
    /// 地址列表TableView数据源
    fileprivate var tableViews:[UITableView] = []
    
    /// 确认选中的地址
    fileprivate var AdressString:String = ""
    
    /// 确认选中的地址--省
    fileprivate var AdressProvince:String = ""
    
    /// 确认选中的地址--市、县
    fileprivate var AdressCity:String = ""
    
    /// 确认选中的地址--区、镇
    fileprivate var AdressDistrict:String = ""
    
    open var seletedAdress: ((_ address: String,_ pro: String,_ city: String,_ dis: String) -> Void)?
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.removeFromSuperview()
//    }
    /// 菜单列表
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: 40), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FJItemCVCell", bundle: Bundle.main), forCellWithReuseIdentifier: FJItemCVCellIdentifier)
        return collectionView
    }()
    
    /// 创建分割线
    ///
    /// - Parameter frame: frame description
    /// - Returns: return value description
    func createLineView(frame:CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = FJSQLiteUtils.instance.arribute.separationColor
        return view
    }
    
    /// 创建地址选择列表
    func setupTableView() {
        let tableView = UITableView(frame: CGRect(x: SCREEN_WIDTH*CGFloat(tableViews.count), y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 161), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "FJAddressTVCell", bundle: Bundle.main), forCellReuseIdentifier: FJAddressTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableViews.append(tableView)
        scrollView.addSubview(tableView)
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH*CGFloat(tableViews.count), height: SCREEN_HEIGHT - 81)
    }
    
    /// 多级滚动视图
    fileprivate var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 81, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 81))
        scrollView.backgroundColor = UIColor.white
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 81)
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:SCREEN_HEIGHT))
        self.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

    //MARK: -配送标示
    fileprivate var distributionLable:UILabel = {
        
        let lable:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 10, width: SCREEN_WIDTH, height: 20))
        lable.textAlignment = NSTextAlignment.center
        lable.text = "配送至"
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = UIColor.lightGray
        return lable
    }()


// MARK: - UI界面
extension FJSelectLocationView {
    /// UI初始化
    func setupUI() {
        
        let button:UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH-50, y: 0, width: 50, height: 40))
        button.setImage(UIImage.init(named: "icon_deleted"), for: UIControlState.normal)
        button.contentMode = UIViewContentMode.redraw
        button.addTarget(self, action:#selector(deletedButtonClick),for:UIControlEvents.touchUpInside)
        addSubview(button)
        
        addSubview(distributionLable)
//        addSubview(createLineView(frame: CGRect(x: 0, y: 30, width: SCREEN_WIDTH, height: 0.5)))
        addSubview(collectionView)
//        addSubview(createLineView(frame: CGRect(x: 0, y: 70.5, width: SCREEN_WIDTH, height: 0.5)))
        addSubview(scrollView)
//        setupTableView()
        setupData()
    }
    ///关闭选择菜单
    @objc func deletedButtonClick(){
        
        FJSQLiteUtils.instance.itemArray.removeAll()
        self.removeFromSuperview()
    }
    
    /// 初始化数据
    func setupData() {
        //添加第一级数据源
//        MyCent?.requestProvLisetData(complete: { (status, msg, data) in
//
//            self.totaldataArray.append(data!)
//            //默认按钮
//            let model = AdressModel()
//            model.name = "请选择"
//            model.level = "1"
//            FJSQLiteUtils.instance.itemArray.append(model)
//            //刷新数据
//            self.setupTableView()
//            self.tableViews[0].reloadData()
//            self.collectionView.reloadData()
//        })
    }
}
extension FJSelectLocationView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FJSQLiteUtils.instance.itemArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FJItemCVCellIdentifier, for: indexPath) as! FJItemCVCell

        if FJSQLiteUtils.instance.itemArray.count > 0 {
            cell.model = FJSQLiteUtils.instance.itemArray[indexPath.row]
            var str:String = ""
            
            for fjModel:AddressModel in FJSQLiteUtils.instance.itemArray{
                str = str + fjModel.name!
            }
            AdressString = str
            // 选中状态
            cell.titleLabel.textColor = FJSQLiteUtils.instance.arribute.noSelectTextColor
            if level == indexPath.row || indexPath.row == FJSQLiteUtils.instance.itemArray.count - 1 {
                cell.titleLabel.textColor = FJSQLiteUtils.instance.arribute.selectTextColor
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = FJSQLiteUtils.instance.itemArray[indexPath.row]
//        if model.level == indexPath.row + 1 {
//            return
//        }
        // 选择低一级的移除数据和列表
        totaldataArray.removeSubrange(Range(indexPath.row + 1..<FJSQLiteUtils.instance.itemArray.count))
        scrollView.contentOffset = CGPoint(x: SCREEN_WIDTH*CGFloat(Int(model.level!)! - 1), y: scrollView.contentOffset.y)
        for (index,value) in tableViews.enumerated() {
            if index > Int(model.level!)! - 1 {
                value.removeFromSuperview()
            }
        }
        tableViews.removeSubrange(Range(indexPath.row + 1..<FJSQLiteUtils.instance.itemArray.count))
        FJSQLiteUtils.instance.itemArray.removeSubrange(Range(indexPath.row + 1..<FJSQLiteUtils.instance.itemArray.count))

        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 自适应
        let model = FJSQLiteUtils.instance.itemArray[indexPath.row]
        let width = widthForsize(text: model.name!, size: CGSize(width:10000, height:35), font: 14)
        return CGSize(width: width + 20, height:40)
    }
    /// 自适应宽度
    ///
    /// - Parameter size: size description
    func widthForsize(text:String, size:CGSize,font:CGFloat) -> CGFloat{
        let attrbute = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: font)]
        let nsStr = NSString(string: text)
        return nsStr.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading,.truncatesLastVisibleLine], attributes: attrbute, context: nil).size.width
    }
}
extension FJSelectLocationView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let dataArray = totaldataArray[tableViews.index(of: tableView)!]
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FJAddressTVCellIdentifier, for: indexPath) as! FJAddressTVCell
        cell.selectionStyle = .none
        let dataArray = totaldataArray[tableViews.index(of: tableView)!]
        let model = dataArray[indexPath.row]
        cell.model = model
        // 选中变色
        cell.titleLabel.textColor = FJSQLiteUtils.instance.arribute.noSelectTextColor
        cell.titleIV.isHidden = true
        if model.seleted == 1 {
            cell.titleLabel.textColor = FJSQLiteUtils.instance.arribute.selectTextColor
            cell.titleIV.isHidden = false
            if model.level == "1"{
                self.AdressProvince = model.id!
            }else if model.level == "2"{
                self.AdressCity = model.id!
            }else{
                self.AdressDistrict = model.id!
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let dataArray = totaldataArray[tableViews.index(of: tableView)!]
        let model = dataArray[indexPath.row]
        level = Int(model.level!)!
        
//        MyCent?.requestProvScendLisetData(aid:Int(model.id!)!,level:Int(model.level!)!, complete: { (status, msg, data) in
//            
//            let newDataArray:[AdressModel] = data!
//            self.level = Int(model.level!)!
//            if newDataArray.count > 0 {
//                if Int(model.level!)! + 1 > self.totaldataArray.count {
//                    //添加下一级数据是
//                    self.totaldataArray.append(newDataArray)
//                    //添加下一级列表
//                    self.setupTableView()
//                    //修改当前级别选择
//                FJSQLiteUtils.instance.itemArray[FJSQLiteUtils.instance.itemArray.count-1] = model
//                    //滚动
//                    self.scrollView.contentOffset = CGPoint(x: SCREEN_WIDTH*CGFloat(Int(model.level!)!), y: self.scrollView.contentOffset.y)
//                    //添加下一级默认按钮
//                    let item = AdressModel()
//                    item.name = "请选择"
//                    item.level = String(Int(model.level!)! + 1)
//                    FJSQLiteUtils.instance.itemArray.append(item)
//                    //刷新数据
//                    self.collectionView.reloadData()
//                }
//            }
//            else
//            {
//                FJSQLiteUtils.instance.itemArray[FJSQLiteUtils.instance.itemArray.count-1] = model
//                self.collectionView.reloadData()
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
//                    UIView.animate(withDuration: 0.1, animations: {
//                        FJSQLiteUtils.instance.itemArray.removeAll()
//                        self.removeFromSuperview()
//                        self.seletedAdress!(self.AdressString, self.AdressProvince,self.AdressCity,self.AdressDistrict)
//                    })
//                }
//            }
//            
//        })
        return indexPath
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var dataArray = totaldataArray[tableViews.index(of: tableView)!]
        for i in 0..<dataArray.count {
            let model:AddressModel = dataArray[i]
            if i == indexPath.row{
                model.seleted = 1
            }
            else{
                model.seleted = 0
            }
            dataArray[i] = model
            totaldataArray[tableViews.index(of: tableView)!] = dataArray
        }
        tableView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
}

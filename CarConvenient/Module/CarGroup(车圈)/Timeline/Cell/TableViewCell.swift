//
//  TableViewCell.swift
//  WechatTimeLineXib
//
//  Created by Modi on 2018/12/1.
//  Copyright © 2018年 modi. All rights reserved.
//

import UIKit

private let withReuseIdentifier = "CollectionViewCell"

private let tableViewIdentifier = "CCCommentTableViewCell"

class TableViewCell: UITableViewCell {

    var updateBlock: (() -> Void)?
    
    var model: TimelineModel?
    
    @IBOutlet weak var icon: UIImageView! {
        didSet {
            icon.layer.cornerRadius = icon.frame.width/2
            icon.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            
            collectionView.register(UINib(nibName: withReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: withReuseIdentifier)
        }
    }
    
    var subModels = [CollectionModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: tableViewIdentifier, bundle: nil), forCellReuseIdentifier: tableViewIdentifier)
            
            tableView.estimatedRowHeight = 20
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var tableViewH: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // 避免重用是数据显示错误
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    @IBAction func btn_DidClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    func updateData(model: TimelineModel) {
        
        self.model = model
        
        icon.image = model.icon
        name.text = model.name
        let attrStr = NSMutableAttributedString(string: model.content)
        let attrs = [NSAttributedString.Key.backgroundColor : UIColor.init(red: 0.6, green: 0.9, blue: 0.8, alpha: 1.0), NSAttributedString.Key.link : "http://www.weibo.com", NSAttributedString.Key.underlineColor: UIColor.init(red: 0.9, green: 0.7, blue: 0.8, alpha: 1.0)] as [NSAttributedString.Key : Any]
        // 图文混排添加图片
//        let attach = NSTextAttachment()
//        attach.image = UIImage(named: "icon")
//        attach.bounds = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
//        let imgAttr = NSAttributedString(attachment: attach)
//        attrStr.insert(imgAttr, at: 0)
        
        attrStr.addAttributes(attrs, range: NSRange(location: 0, length: model.content.count))
        content.attributedText = attrStr
        time.text = model.time
        self.subModels = model.subModels!
        
        // 设置tableview的高度
        tableViewH.constant = model.commentViewHeight
    }
}
extension TableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withReuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.updateData(model: subModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.frame.width/3
        var height = width
        if subModels.count == 1 {
            if let imgSize = subModels[indexPath.row].image?.size {
                width = collectionView.frame.width
                height = collectionView.frame.width * (imgSize.height/imgSize.width)
            }
        }else if subModels.count == 4 {
            width = collectionView.frame.width/2
            height = width
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension TableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.commentModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier) as! CCCommentTableViewCell
        if let commentModel = model?.commentModels[indexPath.row] {
            cell.updateCell(model: commentModel)
        }
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - 模型
class TimelineModel: NSObject {
    var icon: UIImage?
    var name: String = ""
    var content: String = ""
    var time: String = ""
    var subModels: [CollectionModel]?
    var commentModels = [[String: String]]()
    
    var commentViewHeight: CGFloat = 0
    var rowHeight: CGFloat = 0
    
    init(icon: UIImage?,name: String = "",content: String = "",time: String = "",subModels: [CollectionModel]?, rowHeight: CGFloat = 0) {
        self.icon = icon
        self.name = name
        self.content = content
        self.time = time
        self.subModels = subModels
        self.rowHeight = rowHeight
    }
    
    static func models() -> [TimelineModel] {
        
        let model = CollectionModel.init(image: UIImage(named: "bg_img_bargain"))
        
        var subs = [[model], [model, model], [model, model, model], [model, model, model, model], [model, model, model, model, model], [model, model, model, model, model, model], [model, model, model, model, model, model, model], [model, model, model, model, model, model, model, model], [model, model, model, model, model, model, model, model, model]]
        
        var models = [TimelineModel]()
        let contents = ["因为TableView执行reloadData方法时v🏠，会把所有cell从VisableCells池中移除，并从同一复用标识的复用池中取出Cell加入视图中，这个时候cell的高度已经确定好，但indexPath的row顺序有可能不是原来的，所以不能复用。也就是虽然每一个Cell功能一致，但是由于高度和里面图片数量不一样，并不能互相复用。在Storyboard中可以用静态cell分别放入collectionView实现。这里为了不重复放collectionView用了代码书写TableView。", "作者：Nemocdz链接：https://www.jianshu.com/p/b907c198473d來源：简书简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。", "AAAAAAAAAAAAAAAAAAAAAA", "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB", "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC", "DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD", "EEEEEEEEEEEEEEEEEEEEEEEEEE", "FFFFFFF", "GGGG"]
        
        for i in 0..<contents.count {
            var tempM = TimelineModel(icon: UIImage(named: "img_head_n"), name: "name_\(i)", content: contents[i], time: "2018年12月2日", subModels: subs[i])
            tempM.commentModels = self.tempComments()
            tempM.rowHeight = self.heightForItemModel(model: tempM, maxWidth: UIScreen.main.bounds.width-63)
            tempM.commentViewHeight = heightForCommentView(comments: tempM.commentModels, maxWidth: UIScreen.main.bounds.width-63)
            models.append(tempM)
        }
        return models
    }
    
    static func tempComments() -> [[String: String]] {
        var temps = [[String: String]]()
        let users = ["Alisa", "佩奇", "Modi", "Kiven", "Jask"]
        let contents = ["Alisa怀孕了？", "小可爱", "Modi，哈哈哈因为TableView执行reloadData方法时v🏠，会把所有cell从VisableCells池中移除，并从同一复用标识的复用池中取出Cell加入视图中", "Kiven，检察官", "Jask，舰长"]
        let tousers = ["", "Modi", "佩奇", "Jask", "Kiven"]
        for i in 0..<users.count {
            let dic = ["user": users[i], "content": contents[i], "touser": tousers[i]]
            temps.append(dic)
        }
        return temps
    }
    
    /// 计算cell的总高度
    ///
    /// - Parameters:
    ///   - model: 模型数据
    ///   - width: Label最大宽度
    /// - Returns: 高度
    static func heightForItemModel(model: TimelineModel, maxWidth width: CGFloat) -> CGFloat {
        var height: CGFloat = 0
        let margin: CGFloat = 12
        let timeHeight: CGFloat = 21
        let iconHeight: CGFloat = 40
        let nameHeight: CGFloat = 21
        let totalMargin = 5*margin
        
        let contentHeight = UILabel.heightForString(str: model.content, maxWidth: width, fontSize: 17)
        
        let commentHeight: CGFloat = heightForCommentView(comments: model.commentModels, maxWidth: width)
        
        height = nameHeight + timeHeight + totalMargin + contentHeight
        // 图片高度
        height += heightForPicView(pics: model.subModels!, maxWidth: width)
        // 评论高度
        height += commentHeight
        debugPrint("height --------------------------> \(height)")
        return height + 20
    }
    
    /// 计算配图视图高度
    ///
    /// - Parameter pics: 图片模型数组
    /// - Returns: 高度
    static func heightForPicView(pics: [CollectionModel], maxWidth width: CGFloat) -> CGFloat {
        var height: CGFloat = 0
        let topMargin: CGFloat = 12
        let collectionViewWidth = (width)
        var width = collectionViewWidth/3
        height = width
        if pics.count == 1 {
            if let imgSize = pics.first?.image?.size {
                width = collectionViewWidth
                height = width * (imgSize.height/imgSize.width)
            }
        }else if pics.count == 2 {
            height = width
        }else if pics.count == 4 {
            width = collectionViewWidth/2
            height = width * 2
        }else {
            let count = pics.count%3 == 0 ? pics.count/3 : pics.count/3 + 1
            height = CGFloat(count) * width
        }
        // 设置高度
        return height+topMargin
    }
    
    /// 计算评论视图高度
    ///
    /// - Parameter comments: 评论数组
    /// - Returns: 高度
    static func heightForCommentView(comments: [[String: String]], maxWidth width: CGFloat) -> CGFloat {
        var height: CGFloat = 0
        let topMargin: CGFloat = 5
        for item in comments {
            if let user = item["user"], let content = item["content"] {
                var tempStr = ""
                if let touser = item["touser"], touser != "" {
                    tempStr = user + "回复" + touser + "：" + content
                }else {
                    tempStr = user + "：" + content
                }
                let contentHeight = UILabel.heightForString(str: tempStr, maxWidth: width, fontSize: 13)
                height += contentHeight + (topMargin)
            }
        }
        // 设置高度
        return height + 20
    }

}

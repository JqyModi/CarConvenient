//
//  CCCommentTableViewCell.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/18.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit

class CCCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var xib_content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(model: [String: String]) {
        
        if let user = model["user"], let content = model["content"] {
            var tempStr = ""
            let nameColor = UIColor(rgba: "#1B82D2")
            let contentColor = UIColor(rgba: "#333333")
            let font = UIFont.systemFont(ofSize: 13)
            if let touser = model["touser"], touser != "" {
                tempStr = user + "回复" + touser + "：" + content
//                xib_content.attributedText = self.multiAttrText(content: tempStr)
                xib_content.attributedText = NSAttributedString.strForRichText(text: tempStr, colorText: [user, touser+"：", content], colors: [nameColor, nameColor, contentColor], fontSizes: [font, font, font])
            }else {
                tempStr = user + "：" + content
//                xib_content.attributedText = self.singleAttrText(content: tempStr)
                xib_content.attributedText = NSAttributedString.strForRichText(text: tempStr, colorText: [user+"：", content], colors: [nameColor, contentColor], fontSizes: [font, font])
            }
        }
    }
    
    /// 单个用户评论
    ///
    /// - Parameter content: 评论内容
    /// - Returns: 显示富文本属性
    private func singleAttrText(content: String) -> NSAttributedString {
        let nameColor = UIColor(rgba: "#1B82D2")
        let contentColor = UIColor(rgba: "#333333")
        let font = UIFont.systemFont(ofSize: 13)
        
        let attrStr = NSMutableAttributedString(string: content)
        let userattrs = [NSAttributedString.Key.foregroundColor : nameColor, NSAttributedString.Key.font : font] as [NSAttributedString.Key : Any]
        let contentattrs = [NSAttributedString.Key.foregroundColor : contentColor, NSAttributedString.Key.font : font] as [NSAttributedString.Key : Any]
        // 图文混排添加图片
        //        let attach = NSTextAttachment()
        //        attach.image = UIImage(named: "icon")
        //        attach.bounds = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        //        let imgAttr = NSAttributedString(attachment: attach)
        //        attrStr.insert(imgAttr, at: 0)
        
        if let range = content.nsranges(of: "：").first {
            attrStr.addAttributes(userattrs, range: NSRange(location: 0, length: range.location))
//            attrStr.addAttributes(contentattrs, range: NSRange(location: range.location + 1, length: content.count))
        }
        
        return attrStr
    }
    /// 多个用户评论
    ///
    /// - Parameter content: 评论内容
    /// - Returns: 显示富文本属性
    private func multiAttrText(content: String) -> NSAttributedString {
        let nameColor = UIColor(rgba: "#1B82D2")
        let contentColor = UIColor(rgba: "#333333")
        let font = UIFont.systemFont(ofSize: 13)
        
        let attrStr = NSMutableAttributedString(string: content)
        let userattrs = [NSAttributedString.Key.foregroundColor : nameColor, NSAttributedString.Key.font : font] as [NSAttributedString.Key : Any]
        let contentattrs = [NSAttributedString.Key.foregroundColor : contentColor, NSAttributedString.Key.font : font] as [NSAttributedString.Key : Any]
        
        if let range1 = content.nsranges(of: "：").first, let range2 = content.nsranges(of: "回复").first {
            attrStr.addAttributes(userattrs, range: NSRange(location: 0, length: range2.location))
            attrStr.addAttributes(userattrs, range: NSRange(location: range2.location, length: range1.location))
//            attrStr.addAttributes(contentattrs, range: NSRange(location: range1.location + 1, length: content.count))
        }
        
        return attrStr
    }
}

//
//  String+Extension.swift
//  MingChuangWine
//
//  Created by Modi on 2018/5/21.
//  Copyright © 2018年 江启雨. All rights reserved.
//

import Foundation
import CoreLocation

extension String {
    
    /// 通过count分段设置str的颜色
    ///
    /// - Parameters:
    ///   - count: 要分段的位置
    ///   - leftColor: 左边颜色
    ///   - rightColor: 右边颜色
    /// - Returns: 设置好的属性值
    func md_setLabelColorByCount(count: Int, leftColor: UIColor, rightColor: UIColor) -> NSMutableAttributedString {
        let strAttr:NSMutableAttributedString = NSMutableAttributedString(string: self)
        //leftColor
        let range = NSMakeRange(0, count)
        strAttr.addAttribute(NSAttributedStringKey.foregroundColor, value: leftColor, range: range)
        //rightColor
        let range2 = NSMakeRange(count, self.characters.count-count)
        strAttr.addAttribute(NSAttributedStringKey.foregroundColor, value: rightColor, range: range2)
        return strAttr
    }
}


/// 转换时间类型
///
/// - TimeYearType: 带年份
/// - TimeDayType: 只有天数
enum TimeType {
    case TimeYearType, TimeDayType
}

extension String {
    
    //时间转字符串
    func md_timeToString(type: TimeType) -> String {
        let df = DateFormatter()
        switch type {
        case .TimeYearType:
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            break
        case .TimeDayType:
            df.dateFormat = "dd天HH小时mm分ss秒"
            
            let time = (self as! NSString).doubleValue
            
            let timeStamp = lround(time)
            
            //天数计算
            let d = (timeStamp)/(24*3600)
            //秒计算
            let s = ((timeStamp)%(24*3600)) % 60
            //分钟计算
            let m = (timeStamp - s) / 60 % 60
            //小时计算
            let h = ((timeStamp - s) / 60 - m) / 60 % 24;
            
              //天数计算
//            let days = (timeStamp)/(24*3600);
              //小时计算
//            let hours = (num)%(24*3600)/3600;
              //分钟计算
//            let minutes = (num)%3600/60;
              //秒计算
//            let second = (num)%60;
            
            let time1 = String(format: "%.2d天%.2d小时%.2d分%.2d秒", d, h, m, s)
//            let time1 = String(format: "%.2d:%.2d:%.2d", (h+d*24), m, s)
            debugPrint(time1)
            
            debugPrint("date _ > time1  ---> \(df.string(from: Date(timeIntervalSinceNow: (self as! NSString).doubleValue)))")
            
            //转时间
            return time1
        }
//        let date = Date(timeIntervalSince1970: (self as! NSString).doubleValue)
        let date = Date(timeIntervalSinceNow: (self as! NSString).doubleValue)
        return df.string(from: date)
    }
    
    //时间转字符串
//    func timeToString() -> String {
//        let df = DateFormatter()
//        df.dateFormat = "dd天HH小时mm分ss秒"
//        let date = Date(timeIntervalSince1970: (self as! NSString).doubleValue)
//        return df.string(from: date)
//    }
    
    /// 加密密码：规则(pwd + "mcjp").md5().md5()
    ///
    /// - Returns: 加密后字符串
    func md_encryptionToMd5() -> String {
        let pwd = (self + "mcjp").md5().md5()
        return pwd
    }
    
    
    /// 字符串转拼音
    ///
    /// - Returns: 拼音字符串
    func md_transformToPinYin() -> String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "")
    }
    
    /// 判断给定时间与当前时间关系
    ///
    /// - Returns: 刚刚/x分钟前/今天/昨天
    func md_dateDistanceTimeWithBeforeTime() -> String {
        let beTime = (self as NSString).doubleValue
        let now = Date.timeIntervalBetween1970AndReferenceDate
        let distanceTime = now - beTime
        var distanceStr = ""
        let beDate = Date.init(timeIntervalSince1970: beTime)
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        let timeStr = df.string(from: beDate)
        df.dateFormat = "dd"
        let nowDay = df.string(from: Date())
        let lastDay = df.string(from: beDate)
        if distanceTime < 60 {
            distanceStr = "刚刚"
        }else if distanceTime < 60 * 60 {
            distanceStr = "\(distanceTime/60)分钟前"
        }else if distanceTime < 24 * 60 * 60 && (nowDay as NSString).intValue == (lastDay as NSString).intValue {
            distanceStr = "今天\(timeStr)"
        }else if distanceTime < 24 * 60 * 60 * 2 && (nowDay as NSString).intValue != (lastDay as NSString).intValue {
            if (nowDay as NSString).intValue - (lastDay as NSString).intValue == 1 || (lastDay as NSString).intValue - (nowDay as NSString).intValue > 10 && (nowDay as NSString).intValue == 1 {
                distanceStr = "昨天\(timeStr)"
            }else {
                df.dateFormat = "MM-dd HH:mm"
                distanceStr = df.string(from: beDate)
            }
        }else if distanceTime < 24*60*60*365 {
            df.dateFormat = "MM-dd HH:mm"
            distanceStr = df.string(from: beDate)
        }else {
            df.dateFormat = "yyyy-MM-dd HH:mm"
            distanceStr = df.string(from: beDate)
        }
        return distanceStr
    }
    
    /// 将字符串格式化成指定格式
    ///
    /// - Parameter format: 格式
    /// - Returns: 格式化后的字符串
    func md_dateDistanceTimeWithBeforeTime(format: String) -> String {
        let beTime = (self as NSString).doubleValue
        var distanceStr = ""
        let beDate = Date.init(timeIntervalSince1970: beTime)
        let df = DateFormatter(withFormat: format, locale: "en_US_POSIX")
        distanceStr = df.string(from: beDate)
        return distanceStr
    }
    
    // MARK: - 新增扩展方法
    
    /// 电话号码中间4位*显示
    ///
    /// - Parameter phoneNum: 电话号码
    /// - Returns: 如：135*****262
    static func md_getSecrectStringWithPhoneNumber(_ phoneNum: String) -> String? {
        if phoneNum.count == 11 {
            let newStr: NSMutableString = NSMutableString(string: phoneNum)
            let range: NSRange = NSMakeRange(3, 5)
            newStr.replaceCharacters(in: range, with: "*****")
            return newStr as String
        }
        return nil
    }
    
    /// 银行卡号中间8位*显示
    ///
    /// - Parameter accountNo: 银行卡号
    /// - Returns: 如：8888 ******** 8888
    static func md_getSecrectStringWithAccountNo(_ accountNo: String) -> String {
        let newStr: NSMutableString = NSMutableString(string: accountNo)
        let range: NSRange = NSMakeRange(4, 8)
        if newStr.length > 12 {
            newStr.replaceCharacters(in: range, with: " **** **** ")
        }
        return newStr as String
    }
    
    /// 转为手机格式，默认为 -
    ///
    /// - Parameter mobile: 手机号码
    /// - Returns: 如：156-8888-8888
    static func md_stringMobileFormat(_ mobile: String) -> String? {
        if mobile.count == 11 {
            let value: NSMutableString = NSMutableString(string: mobile)
            value.insert("-", at: 3)
            value.insert("-", at: 8)
            return value as String
        }
        return nil
    }
    
    //数组中文格式（几万）可自行添加
    
    /// 金额数字添加单位（暂时写了万和亿，有更多的需求请参考写法来自行添加）
    ///
    /// - Parameter value: 金额
    /// - Returns: 如：10000 = 1万, 100000000 = 1亿
    static func md_stringChineseFormat(_ value: CDouble) -> String {
        if value/100000000 >= 1 {
            return String(format: "%.0f亿", value/100000000)
        } else if value/10000 >= 1 && value/100000000 < 1 {
            return String(format: "%.0f万", value/10000)
        } else {
            return String(format: "%.0f", value)
        }
    }
    
    /// 添加数字的千位符
    ///
    /// - Parameter num: 数字
    /// - Returns: 如：10,000,000
    static func md_countNumAndChangeformat(_ num: String) -> String {
        let moneyFormatter: NumberFormatter = NumberFormatter()
        moneyFormatter.positiveFormat = "###,###"
        //如要增加小数点请自行修改为@"###,###,##"
        return moneyFormatter.string(from: num.md_toNumber())!
    }
    
    /// 计算文字高度
    ///
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - width: 最大宽度
    /// - Returns: 高度
    func md_heightWithFontSize(_ fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let attrs = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)]
        return self.boundingRect(with: CGSize(width: width, height: 0), options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine, .usesFontLeading], attributes: attrs, context: nil).size.height
    }
    
    /// 计算文字宽度
    ///
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - maxHeight: 最大高度
    /// - Returns: 高度
    func md_widthWithFontSize(_ fontSize: CGFloat, height maxHeight: CGFloat) -> CGFloat {
        let attrs = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)]
        return self.boundingRect(with: CGSize(width: 0, height: maxHeight), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], attributes: attrs, context: nil).size.width
    }
    
    /// NSString转为NSNumber
    ///
    /// - Returns: -
    func md_toNumber() -> NSNumber {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let number: NSNumber = formatter.number(from: self)!
        return number
    }
    
    
    /// 抹除运费小数末尾的0
    ///
    /// - Returns: -
    func md_removeUnwantedZero() -> String {
        if String(self[Range(NSRange(location: self.count - 3, length: 3), in: self)!]).isEqual("000") {
            return String(self[Range(NSRange(location: 0, length: self.count - 4), in: self)!])
            // 多一个小数点
        } else if String(self[Range(NSRange(location: self.count - 2, length: 2), in: self)!]).isEqual("00") {
            return String(self[Range(NSRange(location: 0, length: self.count - 2), in: self)!])
        } else if String(self[Range(NSRange(location: self.count - 1, length: 1), in: self)!]).isEqual("0") {
            return String(self[Range(NSRange(location: 0, length: self.count - 1), in: self)!])
        } else {
            return self
        }
    }
    
    /// 去掉字符前后空格
    ///
    /// - Returns: -
    func md_trimmedString() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.decimalDigits)
    }
    
    /// 通过code获取plist文件对应的错误描述
    ///
    /// - Parameters:
    ///   - plistName: plist文件名
    ///   - code: 错误代码
    /// - Returns: 错误代码对应的描述文字
    static func md_errorCodeForDesc(plistName: String, code: String) -> String {
        var tempStr = ""
        if let dataUrl = Bundle.main.path(forResource: plistName, ofType: "plist") {
            if let temp = NSDictionary(contentsOfFile: dataUrl) {
                if let value = temp[code] as? String {
                    tempStr = value
                }
            }
        }
        return tempStr
    }
}
extension String {
    
    /// 计算位置距离
    ///
    /// - Parameters:
    ///   - currentlocation: 返回的位置
    ///   - latitude: 纬度
    ///   - longitude: 经度
    /// - Returns: 返回值
    static func getLocation(currentlocation:String,latitude:Double,longitude:Double) -> String {
        var distance = ""
        let array = currentlocation.components(separatedBy: ",")
        var oldLatitude:Double = 0
        if array.count > 0 {
            let string:NSString = array[0] as NSString
            if string.isOnlyNumber() || string.isPureFloat(){
                oldLatitude = Double(array[0])!
            }
        }
        
        var oldLongitude:Double = 0
        if array.count > 1 {
            let string:NSString = array[1] as NSString
            if string.isOnlyNumber() || string.isPureFloat(){
                oldLongitude = Double(array[1])!
            }
        }
        
        if oldLatitude == 0 || oldLongitude == 0 {
            return "0m"
        }
        
        let oldLocation = CLLocation.init(latitude: oldLatitude, longitude:oldLongitude )
        let curentLocation = CLLocation.init(latitude: latitude, longitude: longitude)
        var doubleDis = curentLocation.distance(from: oldLocation)
        if doubleDis >= 1000 {
            doubleDis = doubleDis/1000.0
            distance = String(format: "%0.2fkm", doubleDis)
        }else{
            distance = String(format: "%0.2fm", doubleDis)
        }
        
        return distance
    }
    
    
    /// 获取js代码
    ///
    /// - Parameter string: 服务器返回的html
    /// - Returns: 返回值
    static func getJsString(fromHtml string:String) -> String{
        let path:String = Bundle.main.path(forResource: "project_intro", ofType: "html")!
        var htmlStr:String = try! String.init(contentsOfFile: path, encoding: String.Encoding.utf8)
        htmlStr = htmlStr.replacingOccurrences(of: "%@honglingguo", with: string)
        return htmlStr
    }
    
    /// html符文版
    ///
    /// - Returns: 数组
    static func htmlArray() -> [String]{
        let array = ["<h5 class=\"day_title_v3 cf\" style=\"margin: 0px; padding: 0px 0px 14px; font-size: 12px; font-weight: 400; zoom: 1; background: rgb(255, 255, 255); overflow: hidden;\"><p>三亚 三亚</p></h5><ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p><span class=\"iconfont line-ico ico-venue\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"></span></p><p class=\"\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><span style=\"padding-right: 8px;\">集合点1:</span>&nbsp;08:00 海南 三亚 三亚（24小时机场、动车站接送）</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">乘机抵达“国际旅游岛”三亚市，地接社工作人员将举着您的姓名牌在机场接待出口接您，沿途欣赏鹿城美景，回酒店休息，准备明天丰富的旅程。</p></li><ul class=\"cf list-paddingleft-2\" style=\"list-style-type: circle;\"></ul><li><p><span class=\"iconfont line-ico ico-vacation\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><pre class=\"pre-content\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; white-space: pre-line;\">乘机抵达三亚，请在机场出口处找您的名字，我们有工作人员在此举游客名字牌接机，若未找到可拨打接机师傅电话或与我们客服联系。（第一天到三亚请勿食用过多热带水果及大量海鲜，以防肠胃不适，影响您的行程哦！）</pre></li><ul class=\"product-list list-paddingleft-2\" style=\"list-style-type: circle;\"></ul><li><p><span class=\"iconfont line-ico ico-hotel\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">住宿信息</p><p class=\"text-tips\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(158, 158, 158);\">三亚大卫传奇爱情度假酒店&nbsp;<span class=\"scenic\" style=\"top: -2px; margin-left: 10px; height: 19px; line-height: 19px; display: inline-block; vertical-align: middle; border-radius: 2px; padding: 0px 5px; background: rgb(255, 167, 38); color: rgb(255, 255, 255); position: relative;\"><span class=\"scenic-ico\" style=\"width: 3px; height: 5px; position: absolute; top: 6px; left: -3px; background: url(\" 0px=\"\" -204px=\"\"></span>高档型</span></p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">早餐：自理</p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">午餐：自理</p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">晚餐：自理</p></li><li><p><span class=\"iconfont line-ico ico-other\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">其它</p><p class=\"text-tips\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(158, 158, 158);\"><br/></p></li></ul><h5 class=\"day_title_v3 cf\" style=\"margin: 0px; padding: 0px 0px 14px; font-size: 12px; font-weight: 400; zoom: 1; background: rgb(255, 255, 255); overflow: hidden;\"><span class=\"day_v3\" style=\"color: rgb(0, 175, 199); font-size: 26px; line-height: 1.2; font-weight: 700; float: left; display: inline;\">第2天</span><p>三亚 三亚</p></h5><ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p><span class=\"iconfont line-ico ico-vacation\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\">08:00</span></span></p><pre class=\"pre-content\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; white-space: pre-line;\">·【亚龙湾旅游度假区-沙滩区】：4A景区，素有东方夏威夷美称的“天下第一湾，细腻的海风、珍珠般的沙滩、蔚蓝的海水、理想的度假天堂让人心旷神怡·【亚龙湾热带天堂森林公园】：4A景区，亲临冯小刚执导，葛尤、舒琪主演的“非诚勿扰2”情美大片拍摄地，是上帝遗落在凡间的天堂，一览亚龙湾美丽海岸线。·【清水湾篝火晚会】：赠送项目-欢聚一堂，围着篝火，载歌载舞，自由自在、无拘无束，唱起了心中的歌注：如遇天气原因或人数较少情况改赠当晚观影院观影（影片以当天酒店排期为准），延续本来的生活品味当天行程结束，自由活动感受让您会唱歌的清水湾沙滩</pre><p><span class=\"text-tips\" style=\"font-size: 14px; color: rgb(158, 158, 158);\">（约40分钟）</span></p></li><ul class=\"product-list list-paddingleft-2\" style=\"list-style-type: circle;\"><li><p><img src=\"https://imgs.qunarzz.com/p/tts9/201311/07/f7d30b4e4713a04693835fbb.jpg\" alt=\"亚龙湾\" data-node=\"sightLink\" style=\"vertical-align: bottom; display: block; width: 145px; margin: 0px; height: 96px;\"/><span class=\"more\" style=\"position: absolute; bottom: 0px; right: 0px; z-index: 1; font-size: 12px; line-height: 18px; color: rgb(255, 255, 255); padding: 0px 5px; background-color: rgba(0, 0, 0, 0.6);\">更多</span></p><p>亚龙湾</p><p><span class=\"iconfont ico-arrow\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; right: 10px; padding: 0px 6px; font-size: 18px; top: 48px; margin-top: -16px; color: rgb(163, 163, 163); cursor: pointer; font-family: package_b2c_frontend !important;\"></span></p></li><li><p><img src=\"https://imgs.qunarzz.com/p/tts3/1703/8b/8f67010b443f1302.jpg\" alt=\"亚龙湾热带天堂森林公园\" data-node=\"sightLink\" style=\"vertical-align: bottom; display: block; width: 145px; margin: 0px; height: 96px;\"/><span class=\"more\" style=\"position: absolute; bottom: 0px; right: 0px; z-index: 1; font-size: 12px; line-height: 18px; color: rgb(255, 255, 255); padding: 0px 5px; background-color: rgba(0, 0, 0, 0.6);\">更多</span></p><p>亚龙湾热带天堂森林公园</p><p><span class=\"iconfont ico-arrow\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; right: 10px; padding: 0px 6px; font-size: 18px; top: 48px; margin-top: -16px; color: rgb(163, 163, 163); cursor: pointer; font-family: package_b2c_frontend !important;\"></span></p></li></ul><li><p><span class=\"iconfont line-ico ico-hotel\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">住宿信息</p><p class=\"text-tips\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(158, 158, 158);\">清水湾温德姆酒店&nbsp;<span class=\"scenic\" style=\"top: -2px; margin-left: 10px; height: 19px; line-height: 19px; display: inline-block; vertical-align: middle; border-radius: 2px; padding: 0px 5px; background: rgb(255, 167, 38); color: rgb(255, 255, 255); position: relative;\"><span class=\"scenic-ico\" style=\"width: 3px; height: 5px; position: absolute; top: 6px; left: -3px; background: url(\" 0px=\"\" -204px=\"\"></span>豪华型</span></p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">早餐：酒店用餐</p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">午餐：团餐</p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">晚餐：团餐</p></li><li><p><span class=\"iconfont line-ico ico-other\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">其它</p><p class=\"text-tips\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(158, 158, 158);\"><br/></p></li></ul><h5 class=\"day_title_v3 cf\" style=\"margin: 0px; padding: 0px 0px 14px; font-size: 12px; font-weight: 400; zoom: 1; background: rgb(255, 255, 255); overflow: hidden;\"><span class=\"day_v3\" style=\"color: rgb(0, 175, 199); font-size: 26px; line-height: 1.2; font-weight: 700; float: left; display: inline;\">第3天</span><p>三亚 三亚</p></h5><ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p><span class=\"iconfont line-ico ico-vacation\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\">08:00</span></span></p><pre class=\"pre-content\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; white-space: pre-line;\">酣睡后，享用早餐。今日行程：蜈支洲岛一整天【蜈支洲岛】：冯小刚贺岁喜剧《私人订制》外景拍摄地、素有“中国的马尔代夫”之称，在这里体验与大海同步呼吸，感受私人定制的看海时间。（畅玩一整天）当天行程结束，自由活动感受让您意犹未尽的魅力三亚</pre><p><span class=\"text-tips\" style=\"font-size: 14px; color: rgb(158, 158, 158);\">（约40分钟）</span></p></li><ul class=\"product-list list-paddingleft-2\" style=\"list-style-type: circle;\"><li><p><img src=\"https://imgs.qunarzz.com/p/tts8/1703/ae/10a4939640c5a802.jpg\" alt=\"蜈支洲岛\" data-node=\"sightLink\" style=\"vertical-align: bottom; display: block; width: 145px; margin: 0px; height: 96px;\"/><span class=\"more\" style=\"position: absolute; bottom: 0px; right: 0px; z-index: 1; font-size: 12px; line-height: 18px; color: rgb(255, 255, 255); padding: 0px 5px; background-color: rgba(0, 0, 0, 0.6);\">更多</span></p><p>蜈支洲岛</p><p><span class=\"iconfont ico-arrow\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; right: 10px; padding: 0px 6px; font-size: 18px; top: 48px; margin-top: -16px; color: rgb(163, 163, 163); cursor: pointer; font-family: package_b2c_frontend !important;\"></span></p></li></ul><li><p><span class=\"iconfont line-ico ico-hotel\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">住宿信息</p><p class=\"text-tips\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(158, 158, 158);\">三亚大卫传奇爱情度假酒店&nbsp;<span class=\"scenic\" style=\"top: -2px; margin-left: 10px; height: 19px; line-height: 19px; display: inline-block; vertical-align: middle; border-radius: 2px; padding: 0px 5px; background: rgb(255, 167, 38); color: rgb(255, 255, 255); position: relative;\"><span class=\"scenic-ico\" style=\"width: 3px; height: 5px; position: absolute; top: 6px; left: -3px; background: url(\" 0px=\"\" -204px=\"\"></span>高档型</span></p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">早餐：酒店用餐</p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">午餐：自理</p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">晚餐：自理</p></li><li><p><span class=\"iconfont line-ico ico-other\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">其它</p><p class=\"text-tips\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(158, 158, 158);\"><br/></p></li></ul><h5 class=\"day_title_v3 cf\" style=\"margin: 0px; padding: 0px 0px 14px; font-size: 12px; font-weight: 400; zoom: 1; background: rgb(255, 255, 255); overflow: hidden;\"><span class=\"day_v3\" style=\"color: rgb(0, 175, 199); font-size: 26px; line-height: 1.2; font-weight: 700; float: left; display: inline;\">第4天</span><p>三亚 三亚</p></h5><ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p><span class=\"iconfont line-ico ico-vacation\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\">08:00</span></span></p><pre class=\"pre-content\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; white-space: pre-line;\">·【南山佛教文化苑】：5A景区，在108米南海观音圣像下虔诚祈福，在这片佛教圣地、梵天净土中找到返璞归真、回归自然的亲身感觉·【抱佛脚】：参与特享项目，登108米南山海上观音莲花宝座，顶礼佛足、吉祥祈福·【天涯海角】：4A景区，海南久负盛名的景点，观&nbsp;“天涯”、“海角”“南天一柱”等石刻全景，海水澄碧，烟波浩翰，帆影点点，感受椰风海韵，让爱与您同在当天行程结束，自由活动感受让您意犹未尽的魅力三亚</pre><p><span class=\"text-tips\" style=\"font-size: 14px; color: rgb(158, 158, 158);\">（约40分钟）</span></p></li><ul class=\"product-list list-paddingleft-2\" style=\"list-style-type: circle;\"><li><p><img src=\"https://imgs.qunarzz.com/p/tts2/1703/d6/756752004a807a02.jpg\" alt=\"南山寺\" data-node=\"sightLink\" style=\"vertical-align: bottom; display: block; width: 145px; margin: 0px; height: 96px;\"/><span class=\"more\" style=\"position: absolute; bottom: 0px; right: 0px; z-index: 1; font-size: 12px; line-height: 18px; color: rgb(255, 255, 255); padding: 0px 5px; background-color: rgba(0, 0, 0, 0.6);\">更多</span></p><p>南山寺</p><p><span class=\"iconfont ico-arrow\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; right: 10px; padding: 0px 6px; font-size: 18px; top: 48px; margin-top: -16px; color: rgb(163, 163, 163); cursor: pointer; font-family: package_b2c_frontend !important;\"></span></p></li><li><p><img src=\"https://imgs.qunarzz.com/p/tts5/1703/a5/5df36a00beb0ff02.jpg\" alt=\"天涯海角\" data-node=\"sightLink\" style=\"vertical-align: bottom; display: block; width: 145px; margin: 0px; height: 96px;\"/><span class=\"more\" style=\"position: absolute; bottom: 0px; right: 0px; z-index: 1; font-size: 12px; line-height: 18px; color: rgb(255, 255, 255); padding: 0px 5px; background-color: rgba(0, 0, 0, 0.6);\">更多</span></p><p>天涯海角</p><p><span class=\"iconfont ico-arrow\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; right: 10px; padding: 0px 6px; font-size: 18px; top: 48px; margin-top: -16px; color: rgb(163, 163, 163); cursor: pointer; font-family: package_b2c_frontend !important;\"></span></p></li></ul><li><p><span class=\"iconfont line-ico ico-hotel\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">住宿信息</p><p class=\"text-tips\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(158, 158, 158);\">三亚大卫传奇爱情度假酒店&nbsp;<span class=\"scenic\" style=\"top: -2px; margin-left: 10px; height: 19px; line-height: 19px; display: inline-block; vertical-align: middle; border-radius: 2px; padding: 0px 5px; background: rgb(255, 167, 38); color: rgb(255, 255, 255); position: relative;\"><span class=\"scenic-ico\" style=\"width: 3px; height: 5px; position: absolute; top: 6px; left: -3px; background: url(\" 0px=\"\" -204px=\"\"></span>高档型</span></p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">早餐：酒店用餐</p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">午餐：团餐</p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">晚餐：团餐</p></li><li><p><span class=\"iconfont line-ico ico-other\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">其它</p><p class=\"text-tips\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(158, 158, 158);\"><br/></p></li></ul><h5 class=\"day_title_v3 cf\" style=\"margin: 0px; padding: 0px 0px 14px; font-size: 12px; font-weight: 400; zoom: 1; background: rgb(255, 255, 255); overflow: hidden;\"><span class=\"day_v3\" style=\"color: rgb(0, 175, 199); font-size: 26px; line-height: 1.2; font-weight: 700; float: left; display: inline;\">第5天</span><p>三亚 三亚</p></h5><ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p><span class=\"iconfont line-ico ico-vacation\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><pre class=\"pre-content\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; white-space: pre-line;\">早餐后，全天自由活动，您的时间您做主&nbsp;(温馨提示：酒店可申请退房时间延迟到14:00，旅行社工作人员会根据您的航班时间送您前往机场，结束行程。)</pre></li><ul class=\"product-list list-paddingleft-2\" style=\"list-style-type: circle;\"></ul><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">早餐：酒店用餐</p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">午餐：自理</p></li><li><p><span class=\"iconfont line-ico ico-meal\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">晚餐：自理</p></li><li><p><span class=\"iconfont line-ico ico-other\" style=\"-webkit-font-smoothing: antialiased; -webkit-text-stroke-width: 0.1px; vertical-align: middle; position: absolute; top: 0px; left: 24px; z-index: 1; color: rgb(77, 208, 225); font-size: 16px; background-color: rgb(255, 255, 255); font-family: package_b2c_frontend !important;\"><span class=\"time\" style=\"position: absolute; top: 20px; z-index: 1; width: 50px; margin-left: -15px; font-size: 14px; text-align: center;\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">其它</p></li></ul><p><br/></p>","<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: arial, 微软雅黑, sans-serif; font-size: 14px; white-space: normal;\">【交通】4程往返含税经济舱机票，包含基建燃油。全程舒适旅游大巴，保证一人一正座：</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: arial, 微软雅黑, sans-serif; font-size: 14px; white-space: normal;\">【服务】机场与酒店之间接送机服务，全程客服7x24小时服务。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: arial, 微软雅黑, sans-serif; font-size: 14px; white-space: normal;\">【导游】当地中文导游服务,自由活动期间除外。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: arial, 微软雅黑, sans-serif; font-size: 14px; white-space: normal;\">【酒店】行程中所列特色星级酒店+温泉酒店&nbsp;(如遇遇特殊原因,我社有权安排同等级或同等协议价酒店入住,请您谅解)。&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: arial, 微软雅黑, sans-serif; font-size: 14px; white-space: normal;\">【餐饮】早餐为酒店自助餐；正餐30元/人/餐，特色餐50元/人/餐。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: arial, 微软雅黑, sans-serif; font-size: 14px; white-space: normal;\">【门票】行程所列景点首道大门票。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: arial, 微软雅黑, sans-serif; font-size: 14px; white-space: normal;\">【儿童】本产品2周岁-12周岁儿童包含往返机票、正餐费,大巴车位费,导游服务费。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: arial, 微软雅黑, sans-serif; font-size: 14px; white-space: normal;\">【保险】行程包含旅行社责任保险和旅游组合险,签定正式纸质旅游合同,保证您的合法权益。&nbsp;</p><p><span style=\"color: rgb(51, 51, 51); font-family: arial, 微软雅黑, sans-serif; font-size: 14px;\">【温馨提示】本店支持国内、国外定制游与跟团游，涉及西双版纳、腾冲等省内线路、贵州，西藏，青海、新疆等国内线路，泰国，缅甸，越南，老挝等出境路线，不一样的线路，一样的品质服务！欢迎在线咨询或拨打24小时免费热线电话：4008-902-913快来抢购吧！</span></p><p><br/></p>","<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">成人价格：景点门票+酒店住宿+旅游车费+餐费+导游服务+旅行社责任险+接送机服务</p><p><small style=\"display: block; font-size: 22px; color: rgb(255, 255, 255); padding: 16px 0px; line-height: 1.2; text-align: center;\">线路<br/>特色</small></p><ul class=\"cf list-paddingleft-2\" style=\"list-style-type: none;\"></ul><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><br/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><strong><span style=\"color: rgb(229, 51, 51);\"></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><strong><span style=\"color: rgb(229, 51, 51);\">去哪儿好评热卖，100%真实描述 ，纯玩0购物，品质放心游！！</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><strong><span style=\"color: rgb(229, 51, 51);\">直采房餐车资源，拒绝中间商，去哪儿网认证——双皇冠商家♔♔</span></strong></p><p><strong style=\"line-height: 1.5;\"><span style=\"color: rgb(229, 51, 51);\">☸精华景点☸</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><br/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><span style=\"color: rgb(0, 51, 153);\"><span style=\"text-decoration:underline;\">亚龙湾森林公园+蜈支洲岛+南山文化苑+天涯海角</span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><span style=\"color: rgb(229, 51, 51);\"><strong>☸升级酒店☸</strong></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><span style=\"color: rgb(229, 51, 51);\"><span style=\"color: rgb(0, 51, 153);\"><span style=\"text-decoration:underline;\">其中一晚升级清水湾温德姆酒店海景房</span></span><span style=\"color: rgb(0, 51, 153);\"></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><strong><span style=\"color: rgb(229, 51, 51);\">☸郑重承诺☸</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><span style=\"text-decoration:underline;\"><span style=\"color: rgb(0, 51, 153);\">纯玩0购物+轻松玩乐+蜈支洲一整天</span></span></p><ul class=\"cf list-paddingleft-2\" style=\"list-style-type: none;\"><li><p><span class=\"mejs__offscreen\" style=\"border: 0px; clip: rect(1px, 1px, 1px, 1px); clip-path: inset(50%); height: 1px; margin: -1px; overflow: hidden; padding: 0px; position: absolute; width: 1px; word-wrap: normal;\">视频播放器</span></p><p><mediaelementwrapper id=\"mejs_3177377218332256\" style=\"box-sizing: border-box;\"><video class=\"media_element_player_video\" width=\"750\" height=\"500\" preload=\"none\" poster=\"http://img1.qunarzz.com/p/tts5/1710/83/1786a4690dd9e902.jpg\" playsinline=\"\" webkit-playsinline=\"\" id=\"mejs_3177377218332256_html5\" src=\"http://vodlnr6niz5.vod.126.net/vodlnr6niz5/20d52624-1d2a-4327-af3d-f446342f3b78.mp4\" style=\"box-sizing: border-box;\"></video></mediaelementwrapper></p><p><button type=\"button\" aria-controls=\"mep_0\" title=\"播放\" aria-label=\"播放\" tabindex=\"0\" style=\"margin: 10px 6px; padding: 0px; background-image: url(\" background-position:=\"\" 0px=\"\" background-size:=\"\" background-repeat:=\"\" background-attachment:=\"\" background-origin:=\"\" background-clip:=\"\" border-width:=\"\" border-style:=\"\" border-color:=\"\" cursor:=\"\" display:=\"\" font-size:=\"\" height:=\"\" line-height:=\"\" overflow:=\"\" position:=\"\" width:=\"\" outline:=\"\"></button></p><p><span class=\"mejs__currenttime\" style=\"box-sizing: border-box;\">00:00</span></p><p><span class=\"mejs__time-total mejs__time-slider\" role=\"slider\" tabindex=\"0\" aria-label=\"时间滑动棒\" aria-valuemin=\"0\" aria-valuemax=\"NaN\" aria-valuenow=\"0\" aria-valuetext=\"00:00\" style=\"box-sizing: border-box; border-radius: 2px; cursor: pointer; display: block; height: 10px; position: absolute; background: rgba(255, 255, 255, 0.3); margin: 5px 0px 0px; width: 528.594px; outline: 0px;\"><span class=\"mejs__time-loaded\" style=\"box-sizing: border-box; border-radius: 2px; cursor: pointer; display: block; height: 10px; position: absolute; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; left: 0px; transform: scaleX(0); transform-origin: 0px 0px 0px; transition: all 0.15s ease-in; width: 528.594px;\"></span><span class=\"mejs__time-current\" style=\"box-sizing: border-box; border-radius: 2px; cursor: pointer; display: block; height: 10px; position: absolute; background: rgba(255, 255, 255, 0.9); left: 0px; transform: scaleX(0); transform-origin: 0px 0px 0px; transition: all 0.15s ease-in; width: 528.594px;\"></span><span class=\"mejs__time-hovered no-hover\" style=\"box-sizing: border-box; border-radius: 2px; cursor: pointer; display: block; height: 10px; position: absolute; background: rgba(255, 255, 255, 0.5); z-index: 10; left: 0px; transform: scaleX(0) !important; transform-origin: 0px 0px 0px; transition: height 0.1s cubic-bezier(0.44, 0, 1, 1); width: 528.594px;\"></span><span class=\"mejs__time-handle\" style=\"box-sizing: border-box; border: 4px solid transparent; cursor: pointer; left: 0px; position: absolute; transform: translateX(0px); z-index: 11;\"><span class=\"mejs__time-handle-content\" style=\"box-sizing: border-box; background: rgba(255, 255, 255, 0.9); border: 4px solid rgba(255, 255, 255, 0.9); cursor: pointer; left: -7px; position: absolute; transform: scale(0); z-index: 11; border-radius: 50%; height: 10px; top: -4px; width: 10px;\"></span></span></span></p><p><span class=\"mejs__duration\" style=\"box-sizing: border-box;\">00:00</span></p><p><button type=\"button\" aria-controls=\"mep_0\" title=\"静音\" aria-label=\"静音\" tabindex=\"0\" style=\"margin: 10px 6px; padding: 0px; background-image: url(\" background-position:=\"\" -60px=\"\" background-size:=\"\" background-repeat:=\"\" background-attachment:=\"\" background-origin:=\"\" background-clip:=\"\" border-width:=\"\" border-style:=\"\" border-color:=\"\" cursor:=\"\" display:=\"\" font-size:=\"\" height:=\"\" line-height:=\"\" overflow:=\"\" position:=\"\" width:=\"\" outline:=\"\"></button></p><p><button type=\"button\" aria-controls=\"mep_0\" title=\"全屏\" aria-label=\"全屏\" tabindex=\"0\" style=\"margin: 10px 6px; padding: 0px; background-image: url(\" background-position:=\"\" -80px=\"\" background-size:=\"\" background-repeat:=\"\" background-attachment:=\"\" background-origin:=\"\" background-clip:=\"\" border-width:=\"\" border-style:=\"\" border-color:=\"\" cursor:=\"\" display:=\"\" font-size:=\"\" height:=\"\" line-height:=\"\" overflow:=\"\" position:=\"\" width:=\"\" outline:=\"\"></button></p></li><li><p><img data-original=\"https://imgs.qunarzz.com/p/tts3/1807/83/3f1c3c00675ca802.jpg_r_750x800x90_479ec6e4.jpg\" class=\"other-custom lazy-load-img\" src=\"http://yibanyou.jomlz.cn/ueditor/php/upload/image/20180822/1534902393664142.jpg\" style=\"vertical-align: bottom; overflow: hidden; margin: 0px 4px 0px 0px; width: 750px; height: auto; display: inline;\"/></p></li><li><p><img data-original=\"https://imgs.qunarzz.com/p/tts1/1805/d7/6acf84db2d027302.png_r_750x732x90_e79ed201.png\" class=\"other-custom lazy-load-img\" src=\"http://yibanyou.jomlz.cn/ueditor/php/upload/image/20180822/1534902395395688.png\" style=\"vertical-align: bottom; overflow: hidden; margin: 0px 4px 0px 0px; width: 750px; height: auto; display: inline;\"/></p></li><li><p><img data-original=\"https://imgs.qunarzz.com/p/tts1/1805/2e/5e9d6bab8d875a02.png_r_750x751x90_dd3697d3.png\" class=\"other-custom lazy-load-img\" src=\"http://yibanyou.jomlz.cn/ueditor/php/upload/image/20180822/1534902396104768.png\" style=\"vertical-align: bottom; overflow: hidden; margin: 0px 4px 0px 0px; width: 750px; height: auto; display: inline;\"/></p></li><li><p><img data-original=\"https://imgs.qunarzz.com/p/tts5/1805/c4/a891851a6c6c9002.png_r_750x668x90_20d088d7.png\" class=\"other-custom lazy-load-img\" src=\"http://yibanyou.jomlz.cn/ueditor/php/upload/image/20180822/1534902400248122.png\" style=\"vertical-align: bottom; overflow: hidden; margin: 0px 4px 0px 0px; width: 750px; height: auto; display: inline;\"/></p></li><li><p><img data-original=\"https://imgs.qunarzz.com/p/tts6/1805/d9/985a215443e34402.png_r_750x670x90_a4a4c84f.png\" class=\"other-custom lazy-load-img\" src=\"http://yibanyou.jomlz.cn/ueditor/php/upload/image/20180822/1534902401229589.png\" style=\"vertical-align: bottom; overflow: hidden; margin: 0px 4px 0px 0px; width: 750px; height: auto; display: inline;\"/></p></li><li><p><img data-original=\"https://imgs.qunarzz.com/p/tts8/1805/cf/3320da4d975b9f02.png_r_750x555x90_fd978060.png\" class=\"other-custom lazy-load-img\" src=\"http://yibanyou.jomlz.cn/ueditor/php/upload/image/20180822/1534902402164206.png\" style=\"vertical-align: bottom; overflow: hidden; margin: 0px 4px 0px 0px; width: 750px; height: auto; display: inline;\"/></p></li><li><p><img data-original=\"https://imgs.qunarzz.com/p/tts1/1805/de/19745ffe7bf61002.png_r_750x517x90_833351f8.png\" class=\"other-custom lazy-load-img\" src=\"http://yibanyou.jomlz.cn/ueditor/php/upload/image/20180822/1534902403632204.png\" style=\"vertical-align: bottom; overflow: hidden; margin: 0px 4px 0px 0px; width: 750px; height: auto; display: inline;\"/></p></li><li><p><img data-original=\"https://imgs.qunarzz.com/p/tts1/1805/f4/2e74785199841902.png_r_750x1823x90_dd72299b.png\" class=\"other-custom lazy-load-img\" src=\"https://imgs.qunarzz.com/p/tts1/1805/f4/2e74785199841902.png_r_750x1823x90_dd72299b.png\" style=\"vertical-align: bottom; overflow: hidden; margin: 0px 4px 0px 0px; width: 750px; height: auto; display: inline;\"/></p></li><li><p><img data-original=\"https://imgs.qunarzz.com/p/tts8/1807/31/fa6ad0c6eb6c102.png_r_750x1241x90_b1482116.png\" class=\"other-custom lazy-load-img\" src=\"http://yibanyou.jomlz.cn/ueditor/php/upload/image/20180822/1534902406206927.png\" style=\"vertical-align: bottom; overflow: hidden; margin: 0px 4px 0px 0px; width: 750px; height: auto; display: inline;\"/></p></li><li><p><img data-original=\"https://imgs.qunarzz.com/p/tts6/1805/da/75853325dc636802.png_r_750x1077x90_9f47f59a.png\" class=\"other-custom lazy-load-img\" src=\"http://yibanyou.jomlz.cn/ueditor/php/upload/image/20180822/1534902406438854.png\" style=\"vertical-align: bottom; overflow: hidden; margin: 0px 4px 0px 0px; width: 750px; height: auto; display: inline;\"/></p></li><li><p><img data-original=\"https://imgs.qunarzz.com/p/tts8/1805/65/ad254e0af9d64b02.png_r_750x934x90_8b6e456d.png\" class=\"other-custom lazy-load-img\" src=\"http://yibanyou.jomlz.cn/ueditor/php/upload/image/20180822/1534902407520734.png\" style=\"vertical-align: bottom; overflow: hidden; margin: 0px 4px 0px 0px; width: 750px; height: auto; display: inline;\"/></p></li><li><p><img data-original=\"https://imgs.qunarzz.com/p/tts2/1805/94/ea4bac6734ff6902.png_r_750x834x90_a19b2b76.png\" class=\"other-custom lazy-load-img\" src=\"http://yibanyou.jomlz.cn/ueditor/php/upload/image/20180822/1534902408832440.png\" style=\"vertical-align: bottom; overflow: hidden; margin: 0px 4px 10px 0px; width: 750px; height: auto; display: inline;\"/></p></li></ul><p><br/></p>"]
        return array
    }
    
    ///获取文字的宽高
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
    
    /// 跳转地图需要2D对象
    ///
    /// - Parameter location: 地理坐标字符串
    /// - Returns: 返回值
    static func getCoordinate(fromLocation location:String) -> CLLocationCoordinate2D{
        let array = location.components(separatedBy: ",")
        var latitude:Double = 0
        if array.count > 0 {
            let string:NSString = array[0] as NSString
            if string.isOnlyNumber() || string.isPureFloat(){
                latitude = Double(array[0])!
            }
        }
        
        var longitude:Double = 0
        if array.count > 1 {
            let string:NSString = array[1] as NSString
            if string.isOnlyNumber() || string.isPureFloat(){
                longitude = Double(array[1])!
            }
        }
        
        let location2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return location2D
    }
    
    /// 将距离格式化
    ///
    /// - Returns: m/km
    func md_formatDistance() -> String {
        
        var distance = (self as! NSString).doubleValue
        
        var rs = ""
        
        if distance >= 1000 {
            distance = distance/1000.0
            rs = String(format: "%0.2fkm", distance)
        }else{
            rs = String(format: "%0.2fm", distance)
        }
        
        return rs
    }
    
    static func getFormatTimeStr(time: Double, formatStr: String) -> String {
        let format = DateFormatter()
        format.dateFormat = formatStr
        let timeStr = format.string(from: Date(timeIntervalSince1970: time/1000))
        return timeStr
    }
    
    static func getUIPasteboardString() -> String? {
        return UIPasteboard.general.string
    }
    
    /// 获取当前系统语言
    ///
    /// - Returns: 当前系统需要字符串表示
    static func getCurrentLanguage() -> String {
        //        let defs = UserDefaults.standard
        //        let languages = defs.object(forKey: "AppleLanguages")
        //        let preferredLang = (languages! as AnyObject).object(0)
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        //        let preferredLang = (languages! as AnyObject).object(0)
//        Log.debug("当前系统语言:\(preferredLang)")
        
        switch String(describing: preferredLang) {
        case "en-US", "en-CN":
            return "en"//英文
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans":
            return "cn"//中文
        default:
            return "en"
        }
    }
    
    /// 根据正则表达式获取指定字符串中匹配字符串数组
    ///
    /// - Parameters:
    ///   - regex: 正则表达式
    ///   - text: 目标字符串
    /// - Returns: 匹配字符串数组
    static func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}

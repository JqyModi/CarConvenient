//
//  HFUserDataViewModel.swift
//  Ecosphere
//
//  Created by 姚鸿飞 on 2017/5/31.
//  Copyright © 2017年 encifang. All rights reserved.
//

import UIKit

class HFUserData: HFBaseViewModel,NSCoding {

    
    /// 用户名字
    var data_UserName: String = ""
    
    /// 手机号码
    var data_PhoneNumber: String = ""
    
    /// 用户头像
    var data_UserIcon: String = ""
    
    /// 小区名字
    var data_CommunityName: String = ""
    
    /// 楼栋号码
    var data_BuildNumber: String = ""
    
    /// 单元号码
    var data_UnitNumber: String = ""
    
    /// 门牌号码
    var data_RoomNumber: String = ""
    
    /// 小区全址
    var data_Address: String = ""
    
    /// 业主ID
    var data_UserID: String = ""

    /// 用户ID
    var data_MID: String = ""
    
    /// 物业公司ID
    var data_PMID: String = ""
    
    /// 用户令牌
    var data_Token: String = ""
    
    /// 用户刷新令牌
    var data_RefreshToken: String = ""
    
    /// 房ID
    var data_RoomID: String = ""
    
    override init() {
        super.init()
    }
    
    init(UserID:String, MID:String, Token:String, RefreshToken:String, PhoneNumber: String) {
        super.init()
        
        self.data_UserID = UserID
        self.data_MID = MID
        self.data_Token = Token
        self.data_RefreshToken = RefreshToken
        self.data_PhoneNumber = PhoneNumber
        
    }
    
    func setupUserData(UserName:String, PhoneNumber:String, CommunityName:String, BuildNumber:String, UnitNumber:String, RoomNumber:String, RoomID:String ,UserIcon:String, PMID:String) {
        
        self.data_UserName = UserName
        
        self.data_PhoneNumber = PhoneNumber
        
        self.data_CommunityName = CommunityName
        
        self.data_BuildNumber = BuildNumber
        
        self.data_UnitNumber = UnitNumber
        
        self.data_RoomNumber = RoomNumber
        
        self.data_Address = self.data_CommunityName + "-" + self.data_BuildNumber + "-" + self.data_UnitNumber + "-" + self.data_RoomNumber
        
        self.data_RoomID = RoomID
        
        self.data_UserIcon = UserIcon
        
        self.data_PMID = PMID
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        self.data_UserName = aDecoder.decodeObject(forKey: "UserName") as! String
        
        self.data_PhoneNumber = aDecoder.decodeObject(forKey: "PhoneNumber") as! String
        
        self.data_CommunityName = aDecoder.decodeObject(forKey: "CommunityName") as! String
        
        self.data_BuildNumber = aDecoder.decodeObject(forKey: "BuildNumber") as! String
        
        self.data_UnitNumber = aDecoder.decodeObject(forKey: "UnitNumber") as! String
        
        self.data_RoomNumber = aDecoder.decodeObject(forKey: "RoomNumber") as! String
        
        self.data_Address = aDecoder.decodeObject(forKey: "Address") as! String
        
        self.data_MID = aDecoder.decodeObject(forKey: "MID") as! String
        
        self.data_UserID = aDecoder.decodeObject(forKey: "UserID") as! String
        
        self.data_Token = aDecoder.decodeObject(forKey: "Token") as! String
        
        self.data_RefreshToken = aDecoder.decodeObject(forKey: "RefreshToken") as! String
        
        self.data_RoomID = aDecoder.decodeObject(forKey: "RoomID") as! String

        
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.data_UserName, forKey: "UserName")
        
        aCoder.encode(self.data_PhoneNumber, forKey: "PhoneNumber")
        
        aCoder.encode(self.data_CommunityName, forKey: "CommunityName")
        
        aCoder.encode(self.data_BuildNumber, forKey: "BuildNumber")
        
        aCoder.encode(self.data_UnitNumber, forKey: "UnitNumber")
        
        aCoder.encode(self.data_RoomNumber, forKey: "RoomNumber")
        
        aCoder.encode(self.data_Address, forKey: "Address")
        
        aCoder.encode(self.data_MID, forKey: "MID")
        
        aCoder.encode(self.data_UserID, forKey: "UserID")
        
        aCoder.encode(self.data_Token, forKey: "Token")
        
        aCoder.encode(self.data_RefreshToken, forKey: "RefreshToken")
        
        aCoder.encode(self.data_RoomID, forKey: "RoomID")
    }
    
}

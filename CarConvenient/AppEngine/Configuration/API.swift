//
//  API.swift
//  Ecosphere
//
//  Created by 姚鸿飞 on 2017/6/2.
//  Copyright © 2017年 encifang. All rights reserved.
//

import UIKit

class API: NSObject {
    
    // MARK: 服务器地址
//    static let baseURL         = "http://192.168.0.203:6001/api"
    static let baseURL         = "http://149.129.241.170:6001/api"

    // MARK: 图片拼接地址
    static let baseImageURL     = ""
//    static let baseImageURL     = "http://192.168.0.203:6001"
//    static let baseImageURL     = "http://149.129.241.170:6001"

    // MARK: 视频播放地址
    static let ViodeURL         = "http://macao.ljzchris.cn:8086"
    
    // MARK: - 通用API -
    
    // MARK: 图片上传
    static let imgUp            = "/global/upload/pic"
    
    // MARK: 视频上传
    static let uploadVideo         = "/common/uploadVideo"
    
    static let WXAccessToken       = "https://api.weixin.qq.com/sns/oauth2/access_token"
    
    static let WXUserinfo          = "https://api.weixin.qq.com/sns/userinfo"
    
    // MARK: 修改头像
    static let ModifyPortrait         = "/user/uploadIcon/ios"
    
    // MARK: - 查询引导图列表
    static let UserGuide         = "/global/guideSlide/findAll"
    
    // MARK: - 商品列表
    static let GoodsList         = "/goods/goodsInfo/findAll"
    
    // MARK: - 随机查询商品列表
    static let RandomGoodsList         = "/goods/goodsInfo/random"
    
    // MARK: - 商品栏目列表
    static let GoodsCategory         = "/goods/indexColumn/findAll"
    
    // MARK: - 首页轮播图
    static let HomeBanner         = "/global/indexSlide/findAll"
    
    // MARK: - 商品分类列表
    static let GoodsTypeList         = "/goods/goodsType/findAll"
    
    // MARK: - 查询热门分类（热门搜索）
    static let GoodsTypeListOne         = "/goods/goodsType/hotSearch"
    
    // MARK: - FAQ类型列表
    static let FAQTypeList         = "/global/faqType/findAll"
    
    // MARK: - 根据类型获取FAQ
    static let FAQTypeInfoList         = "/global/faqInfo/findAll"
    
    // MARK: - 根据唯一标识获取FAQ
    static let FAQTypeInfoDetail         = "/global/faqInfo/findById"
    
    // MARK: - 查询用户反馈列表
    static let FeedbackList         = "/global/feedback/findAll"
    
    // MARK: - 注册
    static let Register         = "/user/loginUser/register"
    
    // MARK: - 第三方登录用户注册
    static let OtherRegister         = "/user/loginUser/openIdRegister"
    
    // MARK: - 发送电子邮件
    static let SendEmail         = "/global/email/sendCode"
    
    // MARK: - 发送短信
    static let SendMessage         = "/global/sms/sendCode"
    
    // MARK: - 登录
    static let Login         = "/user/loginUser/login"
    
    // MARK: - 刷新token
    static let RefreshToken         = "/user/loginUser/refreshToken"
    
    // MARK: - 用户第三方登录
    static let OtherLogin         = "/user/loginUser/openIdLogin"
    
    // MARK: - 手机号码修改登录密码(找回密码)
    static let ModifyPwd         = "/user/loginUser/upPwd"
    
    // MARK: - 修改登录密码
    static let ModifyLoginPwd         = "/user/userInfo/upPwd"
    
    // MARK: - 修改支付密码
    static let ModifyPayPwd         = "/user/loginUser/upPayPwd"
    
    // MARK: - 联系我们：获取系统相关信息
    static let ContactUs         = "/global/systemInfo/find"
    
    // MARK: - 提交用户反馈
    static let AddFeedback         = "/global/feedback/add"
    
    // MARK: - 查询系统消息列表
    static let MessageList         = "/global/systemMsg/findAll"
    
    // MARK: - 根据唯一标识删除系统消息
    static let DeleteMessage         = "/global/systemMsg/dele"
    
    // MARK: - 充值记录
    static let RechargeRecord         = "/user/voucherInfo/findAll"
    
    // MARK: - 消费记录
    static let ConsumptionRecord         = "/user/consumeRecord/findAll"
    
    // MARK: - 提现记录
    static let WithdrawalRecord         = "/user/depositBack/findAll"
    
    // MARK: - 获取用户钱包
    static let MyPurse         = "/user/userInfo/findWallet"
    
    // MARK: - 提交余额提现申请
    static let WithdrawalAdd         = "/user/depositBack/add"
    
    // MARK: - 删除余额提现申请
    static let WithdrawalDel         = "/user/depositBack/dele"
    
    // MARK: - 用户箱子列表
    static let BoxList         = "/user/box/boxList"
    
    // MARK: - 用户箱子列表详情
    static let BoxDetail         = "/user/box/boxDetail"
    
    // MARK: - 收藏列表
    static let CollectedList         = "/user/userCollect/list"
    
    // MARK: - 查询店铺列表信息
    static let StoreList         = "/goods/store/findAll"
    
    // MARK: - 查询店铺详情
    static let StoreDetail         = "/goods/store/findById"
    
    // MARK: - 店铺轮播图
    static let StoreBanner         = "/goods/storeImg/storeImgList"
    
    // MARK: - 商品详情
    static let GoodsDetail         = "/goods/goodsInfo/findById"
    
    // MARK: - 查询用户优惠券列表
    static let CouponsList         = "/user/coupon/findAll"
    
    // MARK: - 查询用户等级列表
    static let VIPLevel         = "/global/userLevel/findAll"
    
    // MARK: - 我的包裹列表
    static let GoodsTranserList         = "/order/parcelOrder/findAll"
    
    // MARK: - 包裹详情
    static let GoodsTransferDetail         = "/order/parcelOrder/findById"
    
    // MARK: - 我的订单列表
    static let OrderList         = "/order/orderInfo/list"
    
    // MARK: - 订单详情
    static let OrderListDetail         = "/order/orderInfo/findById"
    
    // MARK: - 查询收货地址列表
    static let AddressList         = "/user/receiveAddr/findAll"
    
    // MARK: - 查询单个收货地址
    static let DefaultAddress         = "/user/receiveAddr/findOne"
    
    // MARK: - 设置默认收货地址
    static let SettingDefaultAddress         = "/user/receiveAddr/setDefault"
    
    // MARK: - 删除收货地址
    static let DeleteAddress         = "/user/receiveAddr/dele"
    
    // MARK: - 添加收货地址
    static let AddAddress         = "/user/receiveAddr/add"
    
    // MARK: - 修改收货地址
    static let EditAddress         = "/user/receiveAddr/edit"
    
    // MARK: - 修改用户信息
    static let ModifyUserInfo         = "/user/userInfo/upUserInfo"
    
    // MARK: - 修改邮箱
    static let ModifyEmail         = "/user/userInfo/upEmail"
    
    // MARK: - 绑定Google或Facebook
    static let BindOtherAccount         = "/user/userInfo/bindOpenId"
    
    // MARK: - 修改手机号码
    static let ModifyPhone         = "/user/userInfo/upPhone"
    
    // MARK: - 查询购物车列表
    static let ShoppingCartList         = "/order/shoppingCar/list"
    
    // MARK: - 修改购物车
    static let ShoppingCartEdit         = "/order/shoppingCar/edit"
    
    // MARK: - 删除购物车
    static let ShoppingCartDelete         = "/order/shoppingCar/del"
    
    // MARK: - 购物车全选
    static let ShoppingCartSelAll         = "/order/shoppingCar/checkedAll"
    
    // MARK: - 购物车全不选
    static let ShoppingCartNotSelAll         = "/order/shoppingCar/checkedNone"
    
    // MARK: - 添加购物车
    static let ShoppingCartAdd         = "/order/shoppingCar/save"
    
    // MARK: - 购物车结算
    static let ShoppingCartSubmit         = "/order/shoppingCar/windup"
    
    // MARK: - 查询用户信息
    static let UserInfo         = "/user/userInfo/findById"
    
    // MARK: - 银行卡列表
    static let BankCardList         = "/global/bankCard/findAll"
    
    // MARK: - 提交余额充值申请
    static let RechargeApply         = "/user/voucherInfo/add"
    
    // MARK: - 提交订单
    static let SubmitOrder         = "/order/orderInfo/commit"
    
    // MARK: - 订单支付
    static let PayOrder         = "/user/payment/orderPay"
    
    // MARK: - 订单补款
    static let SuppleOrder         = "/user/payment/orderSupple"
    
    // MARK: - 箱子支付
    static let PayBox         = "/user/payment/boxesPay"
    
    // MARK: - 取消订单
    static let CancelOrder         = "/order/orderInfo/cancelAll"
    
    // MARK: - 取消店铺订单
    static let CancelStoreOrder         = "/order/orderInfo/cancel"
    
    // MARK: - 删除订单
    static let DeleteOrder         = "/order/orderInfo/del"
    
    // MARK: - 再来一单
    static let AgainOrder         = "/order/orderInfo/again"
    
    // MARK: - 获取转运地址列表
    static let TransferAddressList         = "/global/transAddr/findAll"
    
    // MARK: - 查询货物类型列表
    static let GoodsCategoryList         = "/order/cargoType/findAll"
    
    // MARK: - 提交转运包裹订单
    static let SubmitTransferOrder         = "/order/parcelOrder/commit"
    
    // MARK: - 添加收藏
    static let AddCollect         = "/user/userCollect/add"
    
    // MARK: - 删除收藏
    static let DeleteCollect         = "/user/userCollect/del"
    
    // MARK: - 购物车移入收藏夹
    static let AddCollectShopCart         = "/user/userCollect/batchAdd"
    
    // MARK: - 口令搜索
    static let PasswordSearch         = "/goods/goodsInfo/command"
    
    // MARK: - 淘口令解析
    static let TaoPasswordParse         = "http://api.taokouling.com/tkl/tkljm"
}

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# 忽略所有第三方库警告⚠️
inhibit_all_warnings!

target 'CarConvenient' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CarConvenient

    pod "SnapKit"
    pod "Alamofire"
    pod "SwiftyJSON"
    pod "SVProgressHUD"
    pod "CryptoSwift"
    pod "ObjectMapper"
    pod "WechatOpenSDK"
    #4.10.0
    pod "Kingfisher"
    pod "KingfisherWebP"
#    pod "IBAnimatable"
    #    导入腾讯SDK
    pod "TencentOpenAPI"
    pod "IQKeyboardManager"
    #   从GitHub指定版本更新库
#    pod 'LLCycleScrollView', :git => 'https://github.com/LvJianfeng/LLCycleScrollView.git', :tag => '1.5.0'
    #   轮播图
#    pod "YJBannerView"
    pod "FSPagerView"
    #    图片选择器
#    pod "HXPhotoPicker", "~> 2.2.3"

#    pod "SDWebImage"
#    pod "YYCache"
#    pod "YYImage"
#    pod "YYWebImage"

#    选择器
#    pod "BRPickerView"
#    刷新
    pod "MJRefresh"
#    二维码生成
#    pod "EFQRCode"
#   选项卡：Viewpager
    pod 'LTScrollView'
#    下拉菜单
#    pod "DropDown"
#    弹框
#    pod 'STZPopupView'
    
#    Facebook
#    pod 'FBSDKCoreKit'
#    pod 'FBSDKLoginKit'
#    pod 'FBSDKShareKit'
#    pod 'FBSDKPlacesKit'
#    pod 'FBSDKMessengerShareKit'

#    Google登录
#    pod 'GoogleSignIn'

    pod "RxSwift"
    pod "RxCocoa"

#   极光推送
    pod 'JPush'
    # 链式添加事件等处理
#    pod 'ReactiveCocoa'

  target 'CarConvenientTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CarConvenientUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
installer.pods_project.build_configurations.each do |config|
config.build_settings.delete('CODE_SIGNING_ALLOWED')
config.build_settings.delete('CODE_SIGNING_REQUIRED')
end
end

//
//  Header.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/19.
//  Copyright © 2017年 bianming. All rights reserved.
//

#ifndef Header_h
#define Header_h
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DWAlertTool.h"
#import "YKDataTool.h"
#import "BaseNavigationVC.h"
#import "DWTabBarController.h"
#import "Masonry.h"
#import "SDCycleScrollView.h"
#import "UIColor+DWColor.h"
#import "CALayer+LayerColor.h"
#import "NSString+DWString.h"
#import "UIImageView+SD.h"
#import "UIButton+LXMImagePosition.h"
#import "UITableView+NoData.h"
#import "UICollectionView+NoData.h"
#import "DWHelper.h"
#import "EZTextView.h"
//#import "LineView.h"
#import "ImageChooseVC.h"
#import "UIImage+GIF.h"
#import "NSString+TextHight.h"
#import "AFNetworking.h"
#import "BaseRequest.h"
#import "BaseResponse.h"
#import "YYModel.h"
#import "SVProgressHUD.h"
#import "AESCrypt.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "RegularTool.h"
#import "NIBHelper.h"
#import "JHCoverView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import <UmengUShare/TencentOpenAPI/QQApiInterface.h>
#import "UMMobClick/MobClick.h"
#import "UMSocialSinaHandler.h"
#import "WXApi.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import <Bugly/Bugly.h>
#import "UIImage+DWImage.h"
#import "TZImagePickerController.h"
#import "SDCycleScrollView.h"
#import "WTProgressView.h"
#import "PublicSize.h"
#import "APIConst.h"
#import "LoadWaitSingle.h"
#import "YKHTTPSession.h"
#import "HTTPTool.h"
#import "DHGuidePageHUD.h"//用户引导页
#import "AppDelegate+Service.h"
#import "VerisonModel.h"
#import "ThirdPartyTool.h"
#import "WHFoundation.h"
#import "WHUIKit.h"
#import "LoginVC.h"
#import <WebKit/WebKit.h>
#import "UITabBar+badge.h"
/*
//以下是百度地图
#import <MapKit/MapKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
//以上是百度地图
*/
//二维码
#import "JQScanViewController.h"
///自定义分段View
#import "SegmentedView.h"
#import "Userinfo.h"
///时间选择器(年月)
#import "MCDatePickerView.h"
#import "HZQDatePickerView.h"

///银行卡相关
#import "CardModel.h"
///系统配置相关
#import "SystemModel.h"



#endif /* Header_h */

//
//  ThirdPartyTool.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/21.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ThreeMapModel : NSObject
///经度
@property (nonatomic, strong) NSString  *lng;
///纬度
@property (nonatomic, strong) NSString  *lat;
///目的地
@property (nonatomic, strong) NSString  *address;
@end
@interface PayModel : NSObject
///支付宝
@property (nonatomic, strong) NSString  *prealipay ;
@property (nonatomic, copy) NSString *prepayid;
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *partnerid;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, assign) UInt32 timestamp;
@property (nonatomic, copy) NSString *sign;

@end
@interface ShareModel : NSObject
///文本内容
@property (nonatomic, copy) NSString  *text;
///缩略图 UIImage或者NSData类型或者NSString类型（图片url
@property (nonatomic, strong) id thumbImage;
///图片内容 （可以是UIImage类对象，也可以是NSdata类对象，也可以是图片链接imageUrl NSString类对象） @note 图片大小根据各个平台限制而定
@property (nonatomic, strong) id shareImage;
/// 标题
@property (nonatomic, strong) NSString  *title ;
/// 描述
@property (nonatomic, strong) NSString  *descr ;
// 缩略图（UIImage或者NSData类型，或者image_url）
@property (nonatomic, strong) id thumImage;
///网页的url地址 不能为空且长度不能超过10K
@property (nonatomic, strong) NSString *webpageUrl;


@end
@interface ThirdPartyTool : NSObject
///枚举 支付类型
typedef enum : NSUInteger {
    PayTypeWX,
    PayTypeZFB
}YKPayType;
//枚举 分享类型
typedef enum : NSUInteger {
    ShareTypeText,
    ShareTypeImageAndText,
    ShareTypeUrl
}YKShareType;
//枚举 第三方登录类型
typedef enum : NSUInteger {
    LayoutType_Pop_up,  //弹出动画
    LayoutType_Draw //滑动
    
}YKLayoutType;
//设置刷新
typedef void(^MJRefreshBlock)();
//设置网络请求成功 失败的bolck
typedef void(^ULoginSuccess)(UMSocialUserInfoResponse  * response);
///跳转到第三方地图
+(void)PushThrdPatyMapWithStart:(ThreeMapModel*)startModel End:(ThreeMapModel*)endModel;
///更新版本
+(void)updateVerison;
///刷新加载
+(void)MJRefreshView:(id)view  Header:(BOOL)header Footer:(BOOL)footer  HeaderBlock:(MJRefreshBlock)headerBlock FooterBlock:(MJRefreshBlock)footerBlock;
///开始加载
+(void)MJRefreshBeginRefreView:(id)view;
///结束加载
+(void)MJRefreshEndRefreView:(id)view;
///微信 支付宝
+(void)PayType:(YKPayType)Type PayModel:(PayModel*)model;
///友盟 分享
+(void)UShareType:(YKShareType)shareType LayoutType:(YKLayoutType)layoutType ShareModel:(ShareModel*)model;
///第三方登录
+(void)ULoginType:(UMSocialPlatformType)platformType ULoginSuccess:(ULoginSuccess )loginSuccess;



@end

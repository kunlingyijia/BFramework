//
//  YKHTTPSession.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/12.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
@class BaseViewController;
@class Userinfo;
@interface YKHTTPSession : NSObject
//设置网络请求成功 失败的bolck
typedef void(^YKSuccessCallback)(NSDictionary* _Nullable response);
typedef void(^YKFaildCallback)(NSError * _Nonnull  error);

//typedef NS_ENUM(NSUInteger,HTTPSRequestType)
//{
//    HTTPSRequestTypeGet = 0,
//    HTTPSRequestTypePost
//};
typedef void(^completeBlock)( NSDictionary *_Nullable object,NSError * _Nullable error);
//枚举 请求类型
typedef enum : NSUInteger {
    HTTPSRequestTypePOST,
    HTTPSRequestTypeGET,
    HTTPSRequestTypePUT,
}YKRequestMethod;
+ (nullable YKHTTPSession *)shareSession;
///BaseViewController
@property (nonatomic, strong) BaseViewController  * _Nullable BaseVC ;
///用户信息
@property (nonatomic, strong) Userinfo   * _Nullable userinfo ;


//网络请求
- (nullable NSURLSessionDataTask *)requestDataWithParm:(nullable id)parm act:( nonnull NSString *)actName sign:(nullable id)sign method:(YKRequestMethod)method  showHUD:(BOOL)showHUD active:(BOOL)active success:(nullable YKSuccessCallback)success faild:(nullable YKFaildCallback)faild;
///网络监测者
+ (void)AFNetworkStatus;
//上传图片
-(void)UPImageToServer:(nonnull NSArray*)imageArr toKb:(NSInteger)kb success:(nullable SuccessImageArr)success faild:(nullable FaildCallback)faild;
//拨打电话
- (void)CallPhoneNumber:(nonnull NSString *)phoneNumber inView:(nonnull UIView *)selfView;

@end

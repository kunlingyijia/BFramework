//
//  HTTPTool.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/20.
//  Copyright © 2017年 bianming. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface HTTPTool : NSObject
//设置网络请求成功 失败的bolck
typedef void(^DataSuccess)(BaseResponse  * _Nullable baseRes);
typedef void(^DataFaild)(NSError * _Nullable error);
#pragma mark -  是否登录
+(BOOL)isLogin;
#pragma mark - 是否实名认证
+(BOOL)isCertification;
#pragma mark -  获取验证码
+ (nullable NSURLSessionDataTask *)requestSystemWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  获取系统配置
+ (nullable NSURLSessionDataTask *)requestVersionCheckWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  获取验证码
+ (nullable NSURLSessionDataTask *)requestVerifyCodeWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  消息列表
+ (nullable NSURLSessionDataTask *)requestMessageListWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  注册
+ (nullable NSURLSessionDataTask *)requestRegisterWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  登录
+ (nullable NSURLSessionDataTask *)requestLoginWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  第三方登录
+ (nullable NSURLSessionDataTask *)requestThirdLoginWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  第三方登录绑定手机号
+ (nullable NSURLSessionDataTask *)requesThirdLoginBindMobileWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark - 找回密码
+ (nullable NSURLSessionDataTask *)requesForgottenPasswordWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  获取个人信息
+ (nullable NSURLSessionDataTask *)requestUserInfoWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  修改个人信息
+ (nullable NSURLSessionDataTask *)requestUpdateUserInfoWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  实名认证
+ (nullable NSURLSessionDataTask *)requestCertifyWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  实名认证查询
+ (nullable NSURLSessionDataTask *)requestCertifyInfoWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  实名添加借记卡
+ (nullable NSURLSessionDataTask *)requestBankAddDebitCardWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  实名添加信用卡
+ (nullable NSURLSessionDataTask *)requestAddCreditCardWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  首页轮播图+公告+我的信用卡
+ (nullable NSURLSessionDataTask *)requestHomePageWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
//#pragma mark -  请求广告页
//+ (nullable NSURLSessionDataTask *)requestAdWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
//#pragma mark -  版本跟新
//+ (nullable NSURLSessionDataTask *)requestVersionUWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;

@end

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
#pragma mark -  请求广告页
+ (nullable NSURLSessionDataTask *)requestAdWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;
#pragma mark -  版本跟新
+ (nullable NSURLSessionDataTask *)requestVersionUWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild;

@end

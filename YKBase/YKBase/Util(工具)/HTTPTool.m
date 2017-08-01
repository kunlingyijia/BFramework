//
//  HTTPTool.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/20.
//  Copyright © 2017年 bianming. All rights reserved.
//
#import "HTTPTool.h"
@implementation HTTPTool
#pragma mark -  请求广告页
+ (nullable NSURLSessionDataTask *)requestAdWithParm:(nullable id)parm  active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
    return [self MD5requestWithParm:parm act:Request_Ad showHUD:YES active:active success:^(BaseResponse * _Nullable baseRes) {
        success(baseRes);
    } faild:^(NSError *  _Nullable error) {
        faild(error);
    }];
}
#pragma mark -  版本跟新
+ (nullable NSURLSessionDataTask *)requestVersionUWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
    return [self MD5requestWithParm:parm act:Request_VersionUpdate showHUD:YES active:active success:^(BaseResponse * _Nullable baseRes) {
        success(baseRes);
    } faild:^(NSError *  _Nullable error) {
        faild(error);
    }];
    
}







#pragma mark - MD5格式
+(nullable NSURLSessionDataTask *)MD5requestWithParm:(nullable id)parm act:( nonnull NSString *)actName showHUD:(BOOL)showHUD active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
//    if ([self isLogin]) {
//        return nil;
//    }else{
    BaseRequest *baseReq = [[BaseRequest alloc] init];
    baseReq.token = [YKDataTool getLoginToken];
    baseReq.encryptionType = RequestMD5;
    baseReq.data = parm;
    return [[YKHTTPSession shareSession] requestDataWithParm:[baseReq yy_modelToJSONString] act:actName sign:[[baseReq.data yy_modelToJSONString] MD5Hash] method:HTTPSRequestTypeGET showHUD:showHUD active:active success:^(NSDictionary * _Nullable response) {
        if (response) {
            BaseResponse *baseRes = [BaseResponse yy_modelWithJSON:response];
            success(baseRes);
        }
    } faild:^(NSError *  _Nullable error) {
        faild(error);
    }];
   // }
}
#pragma mark - AES格式
+(nullable NSURLSessionDataTask *)AESrequestWithParm:(nullable id)parm act:( nonnull NSString *)actName showHUD:(BOOL)showHUD active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
    if ([self isLogin]) {
        return nil;
    }else{
    BaseRequest *baseReq = [[BaseRequest alloc] init];
    baseReq.token = [YKDataTool getLoginToken];
    baseReq.encryptionType = AES;
    baseReq.data = [AESCrypt encrypt:[parm yy_modelToJSONString] password:[YKDataTool getLoginKey]];
    return [[YKHTTPSession shareSession] requestDataWithParm:[baseReq yy_modelToJSONString] act:actName sign:[baseReq.data  MD5Hash] method:HTTPSRequestTypeGET showHUD:showHUD active:active success:^(NSDictionary * _Nullable response) {
        if (response) {
            BaseResponse *baseRes = [BaseResponse yy_modelWithJSON:response];
            if(baseRes.resultCode ==14) {
                //设置别名
                [YKNotification postNotificationName:@"设置别名" object:nil userInfo:[NSDictionary dictionaryWithObject:@"" forKey:@"pushAlias"]];
                //退出登录
                [YKNotification postNotificationName:@"退出账号" object:nil userInfo:nil];
            }
            success(baseRes);
        }
    } faild:^(NSError * _Nullable error) {
        faild(error);
    }];
  }
}
+(BOOL)isLogin{
    NSString *Token =[YKDataTool getLoginToken];
    if (Token.length == 0) {
        [DWAlertTool showToast:@"请先登录"];
        LoginVC * VC=  GetVC(LoginVC)
        [[DWAlertTool getCurrentUIVC].navigationController pushViewController:VC animated:YES];
        return  YES;
    }
    return NO;
}
@end

//
//  HTTPTool.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/20.
//  Copyright © 2017年 bianming. All rights reserved.
//
#import "HTTPTool.h"
#import "CertificationVC.h"
@implementation HTTPTool


#pragma mark -  获取验证码
+ (nullable NSURLSessionDataTask *)requestVerifyCodeWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
    return [self MD5requestWithParm:parm act:Request_VerifyCode showHUD:YES active:active success:^(BaseResponse * _Nullable baseRes) {
        success(baseRes);
    } faild:^(NSError *  _Nullable error) {
        faild(error);
    }];
}
#pragma mark -  注册
+ (nullable NSURLSessionDataTask *)requestRegisterWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
    return [self MD5requestWithParm:parm act:Request_Register showHUD:YES active:active success:^(BaseResponse * _Nullable baseRes) {
        success(baseRes);
    } faild:^(NSError *  _Nullable error) {
        faild(error);
    }];
}
#pragma mark -  登录
+ (nullable NSURLSessionDataTask *)requestLoginWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
    return [self MD5requestWithParm:parm act:Request_Login showHUD:YES active:active success:^(BaseResponse * _Nullable baseRes) {
        success(baseRes);
    } faild:^(NSError *  _Nullable error) {
        faild(error);
    }];

}
#pragma mark -  第三方登录
+ (nullable NSURLSessionDataTask *)requestThirdLoginWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
    return [self MD5requestWithParm:parm act:Request_ThirdLogin showHUD:YES active:active success:^(BaseResponse * _Nullable baseRes) {
        success(baseRes);
    } faild:^(NSError *  _Nullable error) {
        faild(error);
    }];

}
#pragma mark -  第三方登录绑定手机号
+ (nullable NSURLSessionDataTask *)requesThirdLoginBindMobileWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
    return [self MD5requestWithParm:parm act:Request_ThirdLoginBindMobile showHUD:YES active:active success:^(BaseResponse * _Nullable baseRes) {
        success(baseRes);
    } faild:^(NSError *  _Nullable error) {
        faild(error);
    }];

}
#pragma mark - 找回密码
+ (nullable NSURLSessionDataTask *)requesForgottenPasswordWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
    return [self MD5requestWithParm:parm act:Request_ForgottenPassword showHUD:YES active:active success:^(BaseResponse * _Nullable baseRes) {
        success(baseRes);
    } faild:^(NSError *  _Nullable error) {
        faild(error);
    }];
    
}

#pragma mark -  获取个人信息
+ (nullable NSURLSessionDataTask *)requestUserInfoWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
    return [self AESrequestWithParm:parm act:Request_UserInfo showHUD:YES active:active success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            Userinfo *userinfo = [Userinfo yy_modelWithJSON:baseRes.data];
            [YKHTTPSession shareSession].userinfo =userinfo;
            //设置别名
            [YKNotification postNotificationName:@"获取个人信息" object:nil userInfo:nil];
        }
        success(baseRes);
    } faild:^(NSError *  _Nullable error) {
        faild(error);
    }];

}





//#pragma mark -  请求广告页
//+ (nullable NSURLSessionDataTask *)requestAdWithParm:(nullable id)parm  active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
//    return [self MD5requestWithParm:parm act:Request_Ad showHUD:YES active:active success:^(BaseResponse * _Nullable baseRes) {
//        success(baseRes);
//    } faild:^(NSError *  _Nullable error) {
//        faild(error);
//    }];
//}
//#pragma mark -  版本跟新
//+ (nullable NSURLSessionDataTask *)requestVersionUWithParm:(nullable id)parm active:(BOOL)active success:(nullable DataSuccess)success faild:(nullable DataFaild)faild{
//    return [self MD5requestWithParm:parm act:Request_VersionUpdate showHUD:YES active:active success:^(BaseResponse * _Nullable baseRes) {
//        success(baseRes);
//    } faild:^(NSError *  _Nullable error) {
//        faild(error);
//    }];
//    
//}







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

#pragma mark - 是否登录
+(BOOL)isLogin{
    NSString *Token =[YKDataTool getLoginToken];
    if (Token.length == 0) {
        [DWAlertTool showToast:@"请先登录"];
        LoginVC * VC=  GetVC(LoginVC)
        NSLog(@"%@",[DWAlertTool getCurrentUIVC]);
        BaseNavigationVC * Nav = [[BaseNavigationVC alloc]initWithRootViewController:VC];
        [[DWAlertTool getCurrentUIVC] presentViewController:Nav animated:YES completion:nil];
        return  YES;
    }
    return NO;
}



#pragma mark - 是否实名认证
+(BOOL)isCertification{
    if ([self isLogin]) {
        return YES;
    }else{
    NSString * type =
        [YKHTTPSession shareSession].userinfo.type;
        if ([type isEqualToString:@"1"]) {
    //尚未认证
     CertificationVC* VC = GetVC(CertificationVC)
     [[DWAlertTool getCurrentUIVC] presentViewController:VC animated:YES completion:nil];
            return YES;
        }else if([type isEqualToString:@"2"]){
        //审核中
            [DWAlertTool showToast:@"审核中.."];
            return YES;
        }else if([type isEqualToString:@"3"]){
            //审核失败
            [DWAlertTool showToast:@"审核失败.."];
            return YES;
        }else{
            //审核 成功
            return NO;
        }
    }
    return NO;
}




@end

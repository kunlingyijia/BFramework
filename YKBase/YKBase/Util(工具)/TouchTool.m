//
//  TouchTool.m
//  YKBase
//
//  Created by 席亚坤 on 2017/7/28.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "TouchTool.h"
#import <LocalAuthentication/LocalAuthentication.h>
@implementation TouchTool
///指纹解锁
+(void)FingerprintUnlock:(Success)Success Faild:(Faild)Faild{
    
    //初始化上下文对象
    LAContext* context = [[LAContext alloc] init];
    //错误对象
    NSError* error = nil;
    NSString* result = @"Authentication需要验证你的指纹";
    
    //首先使用canEvaluatePolicy判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                
                NSLog(@"验证成功");
                Success(success);
                //验证成功，主线程处理UI
            }
            else
            {
                Faild(error);
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case kLAErrorSystemCancel:
                    {
                        NSLog(@"系统取消了验证touch id");
                        //切换到其他APP，系统取消验证Touch ID
                        break;
                    }
                    case kLAErrorUserCancel:
                    {
                        NSLog(@"用户取消了验证");
                        //用户取消验证Touch ID
                        break;
                    }
                    case kLAErrorUserFallback:
                    {
                        NSLog(@"用户选择手动输入密码");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择其他验证方式，切换主线程处理
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            
                            NSLog(@"其它情况");
                            
                            //其他情况，切换主线程处理
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        Faild(error);
        //不支持指纹识别，LOG出错误详情
        switch (error.code) {
            case kLAErrorTouchIDNotEnrolled:
            {
                NSLog(@"设备Touch ID不可用，用户未录入");
                break;
            }
            case kLAErrorPasscodeNotSet:
            {
                NSLog(@"系统未设置密码");
                break;
            }
            default:
            {
                NSLog(@"TouchID 不可用");
                break;
            }
        }
        
    }
}

@end

//
//  DWAlertTool.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/13.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWAlertTool : NSObject
typedef void(^OKDefault)(UIAlertAction*defaultaction);
typedef void(^Cancel)(UIAlertAction *cancelaction);
///展示提示
+(void)showToast:(NSString *)text;
///取消确定 --居中
+(void)alertWithTitle:(NSString*)title message:(NSString*)message OKWithTitle:(NSString*)OKtitle  CancelWithTitle:(NSString*)Canceltitle withOKDefault:(OKDefault)defaultaction withCancel:(Cancel)cancelaction;
///单个确定
+(void)alertWithTitle:(NSString*)title message:(NSString*)message OKWithTitle:(NSString*)OKtitle   withOKDefault:(OKDefault)defaultaction;
///取消确定 --居下
+(void)alertActionSheetWithTitle:(NSString*)title message:(NSString*)message OKWithTitle:(NSString*)OKtitle  CancelWithTitle:(NSString*)Canceltitle withOKDefault:(OKDefault)defaultaction withCancel:(Cancel)cancelaction;
///取消-确定-确定 --居下
+(void)alertActionSheetWithTitle:(NSString*)title message:(NSString*)message OKWithTitleOne:(NSString*)OKtitleOne OKWithTitleTwo:(NSString*)OKtitleTwo  CancelWithTitle:(NSString*)Canceltitle withOKDefaultOne:(OKDefault)defaultactionOne withOKDefaultTwo:(OKDefault)defaultactionTwo withCancel:(Cancel)cancelaction;
/// 取消-确定-确定 -确定 --居下
+(void)alertActionSheetWithTitle:(NSString*)title message:(NSString*)message OKWithTitleOne:(NSString*)OKtitleOne OKWithTitleTwo:(NSString*)OKtitleTwo OKWithTitleThree:(NSString*)OKtitleThree  CancelWithTitle:(NSString*)Canceltitle withOKDefaultOne:(OKDefault)defaultactionOne withOKDefaultTwo:(OKDefault)defaultactionTwo withOKDefaultThree:(OKDefault)defaultactionThree withCancel:(Cancel)cancelaction;
///获取当前界面
+(UIViewController *)getCurrentUIVC;
///验证码
+(void)VerificationCodeBtn:(UIButton*)sender;

@end

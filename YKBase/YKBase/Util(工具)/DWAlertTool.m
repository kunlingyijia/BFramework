//
//  DWAlertTool.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/13.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "DWAlertTool.h"
#import "UIView+Toast.h"

@implementation DWAlertTool
#pragma mark -  展示提示
+(void)showToast:(NSString *)text{
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
   // [[UIApplication sharedApplication].keyWindow makeToast:text duration:2 position:CSToastPositionCenter ];
     CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow makeToast:text duration:2.0f position: CSToastPositionCenter style:style];
}
#pragma mark - 取消确定 --居中
+(void)alertWithTitle:(NSString*)title message:(NSString*)message OKWithTitle:(NSString*)OKtitle  CancelWithTitle:(NSString*)Canceltitle withOKDefault:(OKDefault)defaultaction withCancel:(Cancel)cancelaction{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * OK = [UIAlertAction actionWithTitle:OKtitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        defaultaction (action);
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:Canceltitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        cancelaction (action);
    }];
    [alertC addAction:OK];
    [alertC addAction:cancel];
//    UIView *subview = alertC.view.subviews.firstObject;
//    UIView *alertContentView = subview.subviews.firstObject;
//    UIView *ContentView = alertContentView.subviews.firstObject;
//    UIView *Content = ContentView.subviews.lastObject;
//    UIView *Conten = Content.subviews.lastObject;
//    UIView *Conte = Conten.subviews.firstObject;
//     UIView *Cont = Conte.subviews.firstObject;
//    Cont.backgroundColor = [UIColor blueColor];;
//   
    [[self getCurrentUIVC] presentViewController:alertC animated:YES completion:nil];
}
#pragma mark - 单个确定
+(void)alertWithTitle:(NSString*)title message:(NSString*)message OKWithTitle:(NSString*)OKtitle   withOKDefault:(OKDefault)defaultaction{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:OKtitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
           defaultaction (action);
    }];
    [alertC addAction:cancel];
    
    
//    alertC.view.backgroundColor = [UIColor redColor];
//    alertC.view.tintColor = [UIColor yellowColor];
//    UIView *subview = alertC.view.subviews.firstObject;
//    UIView *alertContentView = subview.subviews.firstObject;
//    UIView *ContentView = alertContentView.subviews.firstObject;
//    UIView *Content = ContentView.subviews.lastObject;
//    Content.backgroundColor = [UIColor blueColor];;
//    alertContentView.layer.cornerRadius = 10;
    
    
    [[self getCurrentUIVC] presentViewController:alertC animated:YES completion:nil];
}
#pragma mark - 取消确定 --居下
+(void)alertActionSheetWithTitle:(NSString*)title message:(NSString*)message OKWithTitle:(NSString*)OKtitle  CancelWithTitle:(NSString*)Canceltitle withOKDefault:(OKDefault)defaultaction withCancel:(Cancel)cancelaction{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction * OK = [UIAlertAction actionWithTitle:OKtitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        defaultaction (action);
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:Canceltitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        cancelaction (action);
    }];
    [alertC addAction:OK];
    [alertC addAction:cancel];
    [[self getCurrentUIVC] presentViewController:alertC animated:YES completion:nil];
}
#pragma mark - 取消-确定-确定 --居下
+(void)alertActionSheetWithTitle:(NSString*)title message:(NSString*)message OKWithTitleOne:(NSString*)OKtitleOne OKWithTitleTwo:(NSString*)OKtitleTwo  CancelWithTitle:(NSString*)Canceltitle withOKDefaultOne:(OKDefault)defaultactionOne withOKDefaultTwo:(OKDefault)defaultactionTwo withCancel:(Cancel)cancelaction{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction * OKOne = [UIAlertAction actionWithTitle:OKtitleOne style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        defaultactionOne (action);
    }];
    //[OKOne setValue:[UIColor colorWithHexString:kNavigationBgColor] forKey:@"_titleTextColor"];
    UIAlertAction * OKTwo = [UIAlertAction actionWithTitle:OKtitleTwo style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        defaultactionTwo (action);
    }];
    //[OKTwo setValue:[UIColor colorWithHexString:kNavigationBgColor] forKey:@"_titleTextColor"];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:Canceltitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        cancelaction (action);
    }];
    //[cancel setValue:[UIColor colorWithHexString:kNavigationBgColor] forKey:@"_titleTextColor"];
    [alertC addAction:OKOne];
    [alertC addAction:OKTwo];
    [alertC addAction:cancel];
    [[self getCurrentUIVC] presentViewController:alertC animated:YES completion:nil];
}


#pragma mark - 取消-确定-确定 -确定 --居下
+(void)alertActionSheetWithTitle:(NSString*)title message:(NSString*)message OKWithTitleOne:(NSString*)OKtitleOne OKWithTitleTwo:(NSString*)OKtitleTwo OKWithTitleThree:(NSString*)OKtitleThree  CancelWithTitle:(NSString*)Canceltitle withOKDefaultOne:(OKDefault)defaultactionOne withOKDefaultTwo:(OKDefault)defaultactionTwo withOKDefaultThree:(OKDefault)defaultactionThree withCancel:(Cancel)cancelaction{
    
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction * OKOne = [UIAlertAction actionWithTitle:OKtitleOne style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        defaultactionOne (action);
        
        
    }];
    //[OKOne setValue:[UIColor colorWithHexString:kNavigationBgColor] forKey:@"_titleTextColor"];
    UIAlertAction * OKTwo = [UIAlertAction actionWithTitle:OKtitleTwo style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        defaultactionTwo (action);
        
        
    }];
    //[OKTwo setValue:[UIColor colorWithHexString:kNavigationBgColor] forKey:@"_titleTextColor"];
    
    UIAlertAction * OKThree = [UIAlertAction actionWithTitle:OKtitleThree style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        defaultactionThree (action);
        
        
    }];
    //[OKThree setValue:[UIColor colorWithHexString:kNavigationBgColor] forKey:@"_titleTextColor"];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:Canceltitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        cancelaction (action);
    }];
    //[cancel setValue:[UIColor colorWithHexString:kNavigationBgColor] forKey:@"_titleTextColor"];
    
    [alertC addAction:OKOne];
    [alertC addAction:OKTwo];
    [alertC addAction:OKThree];
    [alertC addAction:cancel];
    [[DWAlertTool getCurrentUIVC] presentViewController:alertC animated:YES completion:nil];
    
}
#pragma mark - 获取当前界面
+(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}

+(UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
///验证码
+(void)VerificationCodeBtn:(UIButton*)sender{
    UIButton *btn = sender;
    btn.userInteractionEnabled = NO;
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            //倒计时结束，关闭
            //倒计时结束 改变颜色
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn setTitle:@"重新发送" forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn setTitle:[NSString stringWithFormat:@"%d秒",timeout] forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end

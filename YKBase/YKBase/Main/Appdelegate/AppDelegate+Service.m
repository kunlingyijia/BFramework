//
//  AppDelegate+Service.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/21.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "AppDelegate+Service.h"
#import "AppDelegate+Push.h"
#import "JWLaunchAd.h"
@implementation AppDelegate (Service)
#pragma mark ————— 初始化服务 —————
-(void)initService{
    //退出登录
    [YKNotification  addObserver:self selector:@selector(logOut:)name:@"退出账号" object:nil];
//    //设置别名
//    [YKNotification addObserver:self selector:@selector(SetUpAlias:) name:@"设置别名" object:nil];
}

#pragma mark - 退出登录
-(void)logOut:(NSNotification*)sender{
    //Push 跳转
    [YKDataTool moveLoginToken];
    [YKDataTool moveLoginKey];
    if ([HTTPTool isLogin]) {
        return;
    }
//    [DWAlertTool showToast:@"请先登录"];
//    LoginVC * VC=  GetVC(LoginVC)
//    [[DWAlertTool getCurrentUIVC].navigationController pushViewController:VC animated:YES];
}
//#pragma mark -  设置别名
//-(void)SetUpAlias:(NSNotification*)sender{
//    NSDictionary * dic = sender.userInfo;
//    self. pushAlias =dic[@"pushAlias"];
//    __weak typeof(self) weakSelf = self;
//
//    [JPUSHService setAlias:self. pushAlias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//        if (iResCode == 0) {
//            
//        }
//        if (iResCode == 6002) {
//            [weakSelf SetUpAlias:sender];
//        }
//        
//    } seq:0];
//   // [JPUSHService setAlias: self. pushAlias callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
//}
//#pragma mark - 推送别名
//- (void)tagsAliasCallback:(int)iResCode
//                     tags:(NSSet *)tags
//                    alias:(NSString *)alias {
//    
//    if (iResCode == 0) {
//        
//    }
//    if (iResCode == 6002) {
//        [JPUSHService setAlias: self. pushAlias callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
//    }
//    else{
//        
//    }
//    NSLog(@"push set alias success alisa = %@", alias);
//}

#pragma mark ————— 初始化window —————
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    
   
}
#pragma mark ————— 网络状态监听 —————
- (void)monitorNetworkStatus
{
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [YKHTTPSession  AFNetworkStatus];
    
}

#pragma mark - 设置所有第三方
-(void)initThirdParty:(NSDictionary *)launchOptions{
    //设置错误统计
     [self initBugly];
//    //设置友盟
    [self UMManager];
//    //设置微信支付
//    [self WXApy];
//    //高的地图
//    [self AMap];
//    //极光推送
//    [self registerJPush:launchOptions];
//   // [self JGPush:launchOptions];
//    [self SetUpJGPush:launchOptions];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
   
 
}
-(void)initBugly{
    
   
    [Bugly startWithAppId:BuglyKey];
    
    
}
#pragma mark - 设置微信支付
-(void)WXApy{
    //向微信注册wxd930ea5d5a258f4f
    //参数一  注册微信支付后给的appid
    //参数二 为了区别业务 给开发者坐出一个解释的作用(解释作用)
    //[WXApi registerApp:WXKey withDescription:@"demo 2.0"];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"%@",resultDic);
        }];
        //
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        
    }
      return result;

    //return YES;
}
-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        //通知中心发送消息
        [[NSNotificationCenter defaultCenter] postNotificationName:@"weixinpay" object:resp];
        switch (resp.errCode) {
            case WXSuccess:
                [YKNotification postNotificationName:@"支付成功" object:@"支付成功" userInfo:@{}];
                break;
            case WXErrCodeCommon:
                NSLog(@"普通错误类型");
                [DWAlertTool showToast:@"微信支付-普通错误类型"];
                break;
            case WXErrCodeUserCancel:
                [DWAlertTool showToast:@"微信支付-用户点击取消并返回"];
                NSLog(@"用户点击取消并返回");
                break;
            case WXErrCodeSentFail:
                NSLog(@"发送失败");
                [DWAlertTool showToast:@"微信支付-发送失败"];

                break;
            case WXErrCodeAuthDeny:
                NSLog(@"授权失败 ");
                [DWAlertTool showToast:@"微信支付-授权失败"];

                break;
            case WXErrCodeUnsupport:
                NSLog(@"微信不支持");
                [DWAlertTool showToast:@"微信支付-微信不支持"];

                break;
            default:
                break;
        }
    }
}

#pragma mark - 设置友盟
-(void)UMManager{
    
  // [[UMSocialManager defaultManager] setUmSocialAppkey:UMKey];
//    //打开调试日志
   [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    //设置微信的appKey和appSecret
    //[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXKey appSecret:WXappSecret redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxb1b2bfe44501f201" appSecret:@"5c9d1be2f5dc4cc975c248f9efd7b608" redirectURL:@"http://mobile.umeng.com/social"];
    
//    //设置分享到QQ互联的appKey和appSecret
  //  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQKey  appSecret:QQappSecret redirectURL:@"http://mobile.umeng.com/social"];
     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105466760"  appSecret:@"ZhkBC58lGdVq4kaw" redirectURL:@"http://mobile.umeng.com/social"];
    
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaKey  appSecret:SinaappSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    UMConfigInstance.appKey = @"5760ee9be0f55a0dec0013e6";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
 }
#pragma mark - 高的地图配置
-(void)AMap{
    [AMapServices sharedServices].apiKey =GDKey;
    [[AMapServices sharedServices] setEnableHTTPS:YES];
}

//#pragma mark - 极光推送
//-(void)JGPush:(NSDictionary *)launchOptions{
//    
//    
//}
#pragma mark -  设置广告页
-(void)initAdvertising{
    //  清理缓存
    //  [JWLaunchAd clearDiskCache];
    //  1.设置启动页广告图片的url
    NSString *imgUrlString =@"http://imgstore.cdn.sogou.com/app/a/100540002/714860.jpg";
    //  GIF
    //NSString *imgUrlString = @"http://img1.imgtn.bdimg.com/it/u=473895314,616407725&fm=206&gp=0.jpg";
    if ([[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [JWLaunchAd initImageWithAttribute:6.0 showSkipType:SkipShowTypeNone setLaunchAd:^(JWLaunchAd *launchAd) {
            __block JWLaunchAd *weakSelf = launchAd;
            //如果选择 SkipShowTypeAnimation 需要设置动画跳过按钮的属性
            [weakSelf setAnimationSkipWithAttribute:[UIColor redColor] lineWidth:3.0 backgroundColor:nil textColor:nil];
            [launchAd setWebImageWithURL:imgUrlString options:JWWebImageDefault result:^(UIImage *image, NSURL *url) {
                //  3.异步加载图片完成回调(设置图片尺寸)
                weakSelf.launchAdViewFrame = CGRectMake(0, 0, Width, Height);
            } adClickBlock:^{
                //  4.点击广告回调
                NSString *url = @"https://www.baidu.com";
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }];
        }];
    }
    //  2.初始化启动页广告
   
}

#pragma mark -  用户引导页
-(void)initUserGuidePage{
        if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
          [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
            // 静态引导页
            [self setStaticGuidePage];
            // 动态引导页
            //[self setDynamicGuidePage];
            // 视频引导页
            //[self setVideoGuidePage];
       }
}
#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"1",@"2",@"3"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:[UIScreen mainScreen].bounds imageNameArray:imageNameArray buttonIsHidden:NO];
    guidePage.slideInto = YES;
    AppDelegate * del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del.window addSubview:guidePage];
}
#pragma mark - 设置APP动态图片引导页
- (void)setDynamicGuidePage {
    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:[UIScreen mainScreen].bounds imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.slideInto = YES;
    AppDelegate * del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del.window addSubview:guidePage];}

#pragma mark - 设置APP视频引导页
- (void)setVideoGuidePage {
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"mqr" ofType:@"mp4"]];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:[UIScreen mainScreen].bounds videoURL:videoURL];
    AppDelegate * del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del.window addSubview:guidePage];
}

@end

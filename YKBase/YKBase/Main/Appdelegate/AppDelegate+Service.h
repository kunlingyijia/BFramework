//
//  AppDelegate+Service.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/21.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "AppDelegate.h"
/**
 包含第三方 和 应用内业务的实现，减轻入口代码压力
 */
@interface AppDelegate (Service)<WXApiDelegate>

#pragma mark -  初始化服务(添加观察者)
-(void)initService;
#pragma mark -  初始化 window
-(void)initWindow;
#pragma mark -  监听网络状态
- (void)monitorNetworkStatus;
#pragma mark - 设置所有第三方
-(void)initThirdParty:(NSDictionary *)launchOptions;
#pragma mark -  设置广告页
-(void)initAdvertising;
#pragma mark -  用户引导页
-(void)initUserGuidePage;

@end

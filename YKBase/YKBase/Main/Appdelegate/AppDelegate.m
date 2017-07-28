//
//  AppDelegate.m
//  DWduifubao
//
//  Created by kkk on 16/9/8.
//  Copyright © 2016年 bianming. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Service.h"
#import "UserGuideViewController.h"
#import "AdViewController.h"
#import "VerisonModel.h"

@interface AppDelegate ()
@property(nonatomic,strong)NSDictionary *userInfo;
///推送别名（新增）
@property (nonatomic, strong) NSString  *pushAlias;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   //初始化服务(添加观察者)
    [self initService];
    //初始化 window
    //[self initWindow];
    //监听网络状态
    [self monitorNetworkStatus];
     //设置所有第三方
    [self initThirdParty:launchOptions];
    DWTabBarController* tabbar = [[DWTabBarController alloc]init];
    self.window.rootViewController = tabbar;
    //设置广告页
    [self initAdvertising];
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
}



#pragma mark - 注意：收到内存警告时调用，
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 1. 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 2. 清除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}



@end

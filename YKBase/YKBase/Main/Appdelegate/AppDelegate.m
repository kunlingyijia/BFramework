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
//BMKMapManager* _mapManager;
@interface AppDelegate ()
// <BMKGeneralDelegate>

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
//    //配置百度地图
//    [self configurationBMKMap];
    DWTabBarController* tabbar = [[DWTabBarController alloc]init];
    self.window.rootViewController = tabbar;
    //设置广告页
   // [self initAdvertising];
    
    //是否开启推送
//    if (IOS8) { //iOS8以上包含iOS8
//        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == 0) {
//            
//        }else{
//            
//        }
//    }else{ // ios7 一下
//        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes]  == UIRemoteNotificationTypeNone) {
//            
//        }else{
//            
//        }
//    }
    //获取配置信息
    [self requestSystem];
    
    
    
    
    return YES;
    
}
#pragma mark - 获取配置信息
-(void)requestSystem{
    [HTTPTool requestSystemWithParm:@[] active:YES success:^(BaseResponse * _Nullable baseRes) {
        
    } faild:^(NSError * _Nullable error) {
        
    }];
 }
#pragma mark -- 百度地图
- (void)configurationBMKMap {
//    // 要使用百度地图，请先启动BaiduMapManager
//    _mapManager = [[BMKMapManager alloc] init];
//    BOOL ret = [_mapManager start:BaiDuKey generalDelegate:self];
//    //  测试  XRx7UsnDBANEiNViHTvvDoRt4ATOeqZL    项目id  com.baidu.mapsdk.demo.ylu
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
    
}
//#pragma mark -- BMKGeneralDelegate
//
//- (void)onGetNetworkState:(int)iError {
//    if (0 == iError) {
//        NSLog(@"联网成功");
//    }else {
//        NSLog(@"onGetNetworkState %d",iError);
//    }
//    
//}
//
//- (void)onGetPermissionState:(int)iError {
//    if (0 == iError) {
//        NSLog(@"授权成功");
//    }else {
//        NSLog(@"onGetPermissionState %d",iError);
//    }
//}

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

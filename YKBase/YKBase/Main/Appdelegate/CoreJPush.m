//
//  CoreJPush.m
//  CoreJPush
//
//  Created by 冯成林 on 15/9/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreJPush.h"
#import "JPUSHService.h"
@interface CoreJPush ()

@property (nonatomic,strong) NSMutableArray *listenerM;

@property (nonatomic,copy) void(^ResBlock)(NSInteger iResCode, NSSet *tags,NSString *alias);

@end

/*
极光推送 使用方法 
 #import "CoreJPush.h"
 
 @interface ViewController ()<CoreJPushProtocol>
 
 @end
 
 @implementation ViewController
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 [CoreJPush addJPushListener:self];
 [CoreJPush setTags:[NSSet setWithArray:@[@"movie"]] alias:@"11806082" resBlock:^(NSInteger iResCode, NSSet *tags, NSString *alias) {
 
 if(iResCode==0){
 NSLog(@"设置成功：iResCode---%ld,tags---%@ alias---%@",(long)iResCode,tags,alias);
 }else{
 NSLog(@"设置失败");
 }
 }];
 
 
 
 }
 -(void)dealloc{
 [CoreJPush removeJPushListener:self];
 }
 
 
 
 
 -(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
 
 NSLog(@"ViewController: %@",userInfo);
 
 }

 
 
 
 
 
 
 
 
 
 */

@implementation CoreJPush
HMSingletonM(CoreJPush)

/** 添加监听者 */
+(void)addJPushListener:(id<CoreJPushProtocol>)listener{
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    if([jpush.listenerM containsObject:listener]) return;
    [jpush.listenerM addObject:listener];
}


/** 移除监听者 */
+(void)removeJPushListener:(id<CoreJPushProtocol>)listener{
    
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    
    if(![jpush.listenerM containsObject:listener]) return;
    
    [jpush.listenerM removeObject:listener];
}


-(NSMutableArray *)listenerM{
    
    if(_listenerM==nil){
        _listenerM = [NSMutableArray array];
    }
    
    return _listenerM;
}


-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    [self handleBadge:[userInfo[@"aps"][@"badge"] integerValue]];
    
    if(self.listenerM.count==0) return;
    
    [self.listenerM enumerateObjectsUsingBlock:^(id<CoreJPushProtocol> listener, NSUInteger idx, BOOL *stop) {
        
        if([listener respondsToSelector:@selector(didReceiveRemoteNotification:)]) [listener didReceiveRemoteNotification:userInfo];
    }];
}



/** 处理badge */
-(void)handleBadge:(NSInteger)badge{
    NSInteger now = badge-1;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    [UIApplication sharedApplication].applicationIconBadgeNumber=now;
    [JPUSHService setBadge:now];
}



+(void)setTags:(NSSet *)tags alias:(NSString *)alias resBlock:(void(^)(NSInteger iResCode, NSSet *tags,NSString *alias))resBlock{
    
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if(jpush.ResBlock != nil) jpush.ResBlock(iResCode,nil,iAlias);

    } seq:0];
    [JPUSHService setTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
     if(jpush.ResBlock != nil) jpush.ResBlock(iResCode,iTags,nil);
    } seq:0];
    jpush.ResBlock=resBlock;
}


//-(void)tagsAliasCallback:(int)iResCode tags:(NSSet *)tags alias:(NSString *)alias{
//
//    if(self.ResBlock != nil) self.ResBlock(iResCode==0,tags,alias);
//}


@end

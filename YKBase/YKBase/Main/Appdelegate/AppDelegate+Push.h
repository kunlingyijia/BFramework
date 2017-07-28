//
//  AppDelegate+Push.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/25.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Push)<JPUSHRegisterDelegate>
///pushAlias
@property (nonatomic, strong) NSString  *pushAlias ;
///设置极光
-(void)SetUpJGPush:(NSDictionary *)launchOptions;
@end

//
//  YKAppClient.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/12.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface YKAppClient : AFHTTPSessionManager
+ (instancetype)sharedClient;

@end

//
//  YKAppClient.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/12.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "YKAppClient.h"
static NSString * const APIBaseURLString = @"http://www.baidu.com";
@implementation YKAppClient

+ (instancetype)sharedClient
{
    static YKAppClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[YKAppClient alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
    });
    
    return _sharedClient;
}

#pragma mark - 重写initWithBaseURL
/**
 *
 *  @param url baseUrl
 *
 *  @return 通过重写夫类的initWithBaseURL方法,返回网络请求类的实例
 */
-(instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        /**设置请求超时时间*/
        self.requestSerializer.timeoutInterval = 30;
        /**设置相应的缓存策略*/
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        /**分别设置请求以及相应的序列化器*/
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        self.responseSerializer = response;
        /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        /**设置接受的类型*/
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded", nil]];
        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
        [securityPolicy setAllowInvalidCertificates:YES];
        NSUserDefaults *defaults=  [NSUserDefaults standardUserDefaults];
        NSString*  lat = [defaults   objectForKey:@"Headerlat"];
        NSString*  lng = [defaults   objectForKey:@"Headerlng"];
        NSString*  address = [defaults   objectForKey:@"HeaderformattedAddress"];
        NSString*  province = [defaults   objectForKey:@"Headerprovince"];
        NSString*  city = [defaults   objectForKey:@"Headercity"];
        NSString*  area = [defaults   objectForKey:@"Headerdistrict"];
        //系统版本
        NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
        //设备类型
        NSString * phoneModel =[[UIDevice currentDevice] model];
        NSString *appVersion =    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString *deviceNo = [[UIDevice currentDevice].identifierForVendor UUIDString];
        // 设置超时时间
        [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [self.requestSerializer
         setValue:lat
         forHTTPHeaderField:@"lat"];
        [self.requestSerializer
         setValue:lng
         forHTTPHeaderField:@"lng"];
        [self.requestSerializer
         setValue:province
         forHTTPHeaderField:@"province"];
        [self.requestSerializer
         setValue:city
         forHTTPHeaderField:@"city"];
        [self.requestSerializer
         setValue:area
         forHTTPHeaderField:@"area"];
        [self.requestSerializer
         setValue:address
         forHTTPHeaderField:@"address"];
        [self.requestSerializer
         setValue:appVersion
         forHTTPHeaderField:@"appVersion"];
        [self.requestSerializer
         setValue:@"1"
         forHTTPHeaderField:@"clientOS"];
        [self.requestSerializer
         setValue:deviceNo
         forHTTPHeaderField:@"deviceNo"];
        [self.requestSerializer
         setValue:systemVersion
         forHTTPHeaderField:@"systemVersion"];
        [self.requestSerializer
         setValue:phoneModel
         forHTTPHeaderField:@"phoneModel"];
    }
    
    return self;
}

@end

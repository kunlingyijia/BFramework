//
//  YKDataTool.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/17.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKDataTool : NSObject

/// 把对象归档存到沙盒里
+(void)saveObject:(id)object byFileName:(NSString*)fileName;
/// 通过文件名从沙盒中找到归档的对象
+(id)getObjectByFileName:(NSString*)fileName;
/// 根据文件名删除沙盒中的 plist 文件
+(void)removeFileByFileName:(NSString*)fileName;
/// 存储用户偏好设置 到 NSUserDefults
+(void)saveUserData:(id)data forKey:(NSString*)key;
/// 读取用户偏好设置
+(id)readUserDataForKey:(NSString*)key;
/// 删除用户偏好设置
+(void)removeUserDataForkey:(NSString*)key;
///保存json字符串
+(void)setValue:(id)response forkey:(NSString*)key;
///获取数据
+(id)objectForKey:(NSString*)key;


+ (NSString *)getRegisterKey;
+ (NSString *)getRegistertoken;
+ (NSString *)getLoginKey;
+ (NSString *)getLoginToken;
///登录手机号
+ (NSString *)getuseraccount;
+(NSString*)getimage_hostname;
+(NSString*)getimage_account;
+(NSString*)getimage_password;
//+(NSString*)getto_virtual_glod;
#pragma mark - 移除
+ (void)moveLoginKey;
+ (void)moveLoginToken;

@end

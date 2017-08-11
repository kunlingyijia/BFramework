//
//  YKDataTool.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/17.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "YKDataTool.h"

@implementation YKDataTool
#pragma mark -  把对象归档存到沙盒里
+(void)saveObject:(id)object byFileName:(NSString*)fileName
{
    NSString *path  = [self appendFilePath:fileName];
    [NSKeyedArchiver archiveRootObject:object toFile:path];
    
}
#pragma mark -  通过文件名从沙盒中找到归档的对象
+(id)getObjectByFileName:(NSString*)fileName
{
    NSString *path  = [self appendFilePath:fileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

#pragma mark -  根据文件名删除沙盒中的 plist 文件
+(void)removeFileByFileName:(NSString*)fileName
{
    NSString *path  = [self appendFilePath:fileName];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

#pragma mark -  拼接文件路径
+(NSString*)appendFilePath:(NSString*)fileName
{
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *file = [NSString stringWithFormat:@"%@/%@.plist",documentsPath,fileName];
    return file;
}

#pragma mark -  存储用户偏好设置 到 NSUserDefults
+(void)saveUserData:(id)data forKey:(NSString*)key
{
    if (data)
    {
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
#pragma mark -  读取用户偏好设置
+(id)readUserDataForKey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
}
#pragma mark -  删除用户偏好设置
+(void)removeUserDataForkey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
}


#pragma mark -  数据存储
+(void)setValue:(id)response forkey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults]setObject:[response yy_modelToJSONString] forKey:key];
}
+(id)objectForKey:(NSString*)key{
    NSString * str = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    if (str.length!=0) {
        NSData * data= [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSMutableDictionary * dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        return dic[@"data"];
        
    }else{
        return nil;
    }
 }
+ (NSString *)getRegisterKey {
    return [self readUserDataForKey:@"registKey"];
}
+ (NSString *)getRegistertoken {
    return [self readUserDataForKey:@"registToken"];
}
+ (NSString *)getLoginKey {
    return [self readUserDataForKey:@"loginKey"];
}
+ (NSString *)getLoginToken {
    return [self readUserDataForKey:@"loginToken"];
}
///登录手机号
+ (NSString *)getuseraccount{
     return [self readUserDataForKey:@"useraccount"];
    
}

#pragma mark - 配置信息
+(NSString*)getimage_hostname{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"image_hostname"];
}
+(NSString*)getimage_account{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"image_account"];
}
+(NSString*)getimage_password{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"image_password"];
    
}
+(NSString*)getto_virtual_glod{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"to_virtual_glod"];
}


+(void)moveLoginKey{
    [self removeUserDataForkey:@"loginKey"];
}
+(void)moveLoginToken{
     [self removeUserDataForkey:@"loginToken"];
}


@end


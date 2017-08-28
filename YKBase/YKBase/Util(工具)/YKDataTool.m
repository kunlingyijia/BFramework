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


//#pragma mark -  数据存储
//+(void)setValue:(id)response forkey:(NSString*)key{
//    [[NSUserDefaults standardUserDefaults]setObject:[response yy_modelToJSONString] forKey:key];
//}
//+(id)objectForKey:(NSString*)key{
//    NSString * str = [[NSUserDefaults standardUserDefaults]objectForKey:key];
//    if (str.length!=0) {
//        NSData * data= [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//        NSMutableDictionary * dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        return dic[@"data"];
//        
//    }else{
//        return nil;
//    }
// }
+ (NSString *)getRegisterKey {
    return [self readUserDataForKey:@"key"];
}
+ (NSString *)getRegistertoken {
    return [self readUserDataForKey:@"token"];
}
+ (NSString *)getLoginKey {
    return [self readUserDataForKey:@"key"];
}
+ (NSString *)getLoginToken {
    return [self readUserDataForKey:@"token"];
}

#pragma mark - 图片上传地址
+(NSString*)getimage_hostname{
    return [self readUserDataForKey:@"image_hostname"];
}
#pragma mark - 图片上传账号
+(NSString*)getimage_account{
    return [self readUserDataForKey:@"image_account"];
}
#pragma mark - 图片上传密码
+(NSString*)getimage_password{
    return [self readUserDataForKey:@"image_password"];
}

///登录手机号
+ (NSString *)getuseraccount{
     return [self readUserDataForKey:@"useraccount"];
    
}



+(void)moveLoginKey{
    [self removeUserDataForkey:@"key"];
}
+(void)moveLoginToken{
     [self removeUserDataForkey:@"token"];
}


@end


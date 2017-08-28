//
//  NSString+DWString.h
//  BianMin
//
//  Created by z on 16/5/3.
//  Copyright © 2016年 bianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DWString)
//获取单行文本长度
- (CGFloat)getSingleLineTextWidthWithFont:(UIFont *)font withMaxWith:(float)maxWidth;
//获取在规定size内 文本的高度
- (CGFloat)getTextHeightWithFont:(UIFont *)font withMaxWith:(float)maxWidth;

- (CGFloat)getTextHightWithWidth:(CGFloat )WidthSize withFont:(CGFloat )font;

//中英文，转unicode 后获取长度
-  (NSInteger)getUniCodeLength;

- (BOOL)isface;

- (BOOL)isUrl;

- (BOOL)isAt;

- (NSArray *)getMagiciData;
- (NSDate *)convertDateFromString;
- (NSDate*)convertDateYYMMDD;
- (NSString *)processMeterToKilometer;

+ (NSString *) stringWithMD5OfFile: (NSString *) path;
// The string's MD5 hash
- (NSString *) MD5Hash;
- (BOOL)isPhoneNumber;
- (NSString *)getSmallIconUrl;
- (NSString *)getMiddleIconUrl;
- (NSString *)getImUserId;

///后台返回html代码 反编译
-(NSString*)HtmlToString;

///获取IP
#pragma mark - 获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
///获取 年-月-日
-(NSString*)timeStampString;
//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end

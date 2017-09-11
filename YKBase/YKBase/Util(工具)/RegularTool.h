//
//  RegularTool.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/19.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularTool : NSObject

///银行卡
//+(BOOL)IsBankCard:(NSString *)cardNumber;

+ (NSString *)htmlShuangyinhao:(NSString *)values;
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (NSString *) nullDefultString: (NSString *)fromString null:(NSString *)nullStr;

/// 正则匹配邮编
+ (BOOL)checkZipcode:(NSString*)value;
/// 正则匹配邮箱号
+ (BOOL)checkMailInput:(NSString *)mail;
/// 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
/// 正则匹配用户密码6-16位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
/// 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
/// 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
/// 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;
/// 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;
/// 正则匹配昵称
+ (BOOL) checkNickname:(NSString *) nickname;
/// 正则匹配以C开头的18位字符
+ (BOOL) checkCtooNumberTo18:(NSString *) nickNumber;
/// 正则匹配以C开头字符
+ (BOOL) checkCtooNumber:(NSString *) nickNumber;
/// 正则匹配银行卡号是否正确
+ (BOOL) checkBankNumber:(NSString *) bankNumber;
/// 正则匹配17位车架号
+ (BOOL) checkCheJiaNumber:(NSString *) CheJiaNumber;
/// 正则只能输入数字和字母
+ (BOOL) checkTeshuZifuNumber:(NSString *) CheJiaNumber;
/// 车牌号验证
+ (BOOL) checkCarNumber:(NSString *) CarNumber;
///  金额小数点前6位 金额小数点后2位
+ (BOOL) checkAmount:(NSString *) amount;
/// 正则匹配6位正整数
+ (BOOL)checkNumber6:(NSString *) number;
/// 正则匹配3位正整数(cvn)
+ (BOOL)checkNumber3:(NSString *) number;
/// 正则匹配11位正整数(手机号位数)
+ (BOOL)checkNumber11:(NSString *) number;
@end

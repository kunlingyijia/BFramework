//
//  RegularTool.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/19.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "RegularTool.h"

@implementation RegularTool


//银行卡
//
//+(BOOL)IsBankCard:(NSString *)cardNumber
//{
//    if(cardNumber.length==0)
//    {
//        return NO;
//    }
//    NSString *digitsOnly = @"";
//    char c;
//    for (int i = 0; i < cardNumber.length; i++)
//    {
//        c = [cardNumber characterAtIndex:i];
//        if (isdigit(c))
//        {
//            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
//        }
//    }
//    int sum = 0;
//    int digit = 0;
//    int addend = 0;
//    BOOL timesTwo = false;
//    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
//    {
//        digit = [digitsOnly characterAtIndex:i] - '0';
//        if (timesTwo)
//        {
//            addend = digit * 2;
//            if (addend > 9) {
//                addend -= 9;
//            }
//        }
//        else {
//            addend = digit;
//        }
//        sum += addend;
//        timesTwo = !timesTwo;
//    }
//    int modulus = sum % 10;
//    return modulus == 0;
//}

#pragma mark - 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:userName];
}



+ (NSString *) nullDefultString: (NSString *)fromString null:(NSString *)nullStr{
    if ([fromString isEqualToString:@""] || [fromString isEqualToString:@"(null)"] || [fromString isEqualToString:@"<null>"] || [fromString isEqualToString:@"null"] || fromString==nil) {
        return nullStr;
    }else{
        return fromString;
    }
}
+ (NSString *)htmlShuangyinhao:(NSString *)values{
    if (values == nil) {
        return @"";
    }
    /*
     字符串的替换
     注：将字符串中的参数进行替换
     参数1：目标替换值
     参数2：替换成为的值
     参数3：类型为默认：NSLiteralSearch
     参数4：替换的范围
     */
    NSMutableString *temp = [NSMutableString stringWithString:values];
    [temp replaceOccurrencesOfString:@"\"" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"\r" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    return temp;
}

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



#pragma mark - 校验邮编
+ (BOOL)checkZipcode:(NSString*)value
{
    const char *cvalue = [value UTF8String];
    int len = (int)value.length;
    if (len != 6) {
        return FALSE;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return FALSE;
        }
    }
    return TRUE;
}


#pragma mark - 正则匹配邮箱号
+ (BOOL)checkMailInput:(NSString *)mail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:mail];
}

#pragma mark - 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    //    /**
    //     * 手机号码
    //     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     * 联通：130,131,132,152,155,156,185,186
    //     * 电信：133,1349,153,180,189
    //     */
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //    /**
    //     10         * 中国移动：China Mobile
    //     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //    /**
    //     15         * 中国联通：China Unicom
    //     16         * 130,131,132,152,155,156,183,185,186
    //     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[356])\\d{8}$";
    //    /**
    //     20         * 中国电信：China Telecom
    //     21         * 133,1349,153,180,189
    //     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    //    /**
    //     25         * 大陆地区固话及小灵通
    //     26         * 区号：010,020,021,022,023,024,025,027,028,029
    //     27         * 号码：七位或八位
    //     28         */
    //    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //
    //    if (([regextestmobile evaluateWithObject:telNumber] == YES)
    //        || ([regextestcm evaluateWithObject:telNumber] == YES)
    //        || ([regextestct evaluateWithObject:telNumber] == YES)
    //        || ([regextestcu evaluateWithObject:telNumber] == YES))
    //    {
    //        return YES;
    //    }
    //    else
    //    {
    //        return NO;
    //    }
    NSString *phoneRegex1=@"1[34578]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:telNumber];
}


#pragma mark - 正则匹配用户密码6-16位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}




#pragma mark - 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    //    BOOL flag;
    //    if (idCard.length <= 0) {
    //        flag = NO;
    //        return flag;
    //    }
    //    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    //    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //    BOOL isMatch = [pred evaluateWithObject:idCard];
    //    return isMatch;
    if (idCard.length == 15) {
        //|  地址  |   年    |   月    |   日    |
        NSString *regex = @"^(\\d{6})([3-9][0-9][01][0-9][0-3])(\\d{4})$";
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [identityCardPredicate evaluateWithObject:idCard];
    } else if (idCard.length == 18) {
        //|  地址  |      年       |   月    |   日    |
        NSString *regex = @"^(\\d{6})([1][9][3-9][0-9][01][0-9][0-3])(\\d{4})(\\d|[xX])$";
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [identityCardPredicate evaluateWithObject:idCard];
    } else {
        return NO;
    }
    
}

#pragma mark - 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

#pragma mark - 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
     //NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSString *pattern =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

#pragma mark - 正则匹配昵称
+ (BOOL) checkNickname:(NSString *) nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    BOOL isMatch = [pred evaluateWithObject:nickname];
    return isMatch;
}

#pragma mark - 正则匹配以C开头的18位字符
+ (BOOL) checkCtooNumberTo18:(NSString *) nickNumber
{
    NSString *nickNum=@"^C{1}[0-9]{18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nickNum];
    BOOL isMatch = [pred evaluateWithObject:nickNumber];
    return isMatch;
}
#pragma mark - 正则匹配以C开头字符
+ (BOOL) checkCtooNumber:(NSString *) nickNumber
{
    NSString *nickNum=@"^C{1}[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nickNum];
    BOOL isMatch = [pred evaluateWithObject:nickNumber];
    return isMatch;
}
#pragma mark - 正则匹配银行卡号是否正确
+ (BOOL)checkBankNumber:(NSString *)bankNumber{
    NSString *bankNum=@"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:bankNumber];
    return isMatch;
}
#pragma mark - 正则匹配17位车架号
+ (BOOL) checkCheJiaNumber:(NSString *) CheJiaNumber{
    NSString *bankNum=@"^(\\d{17})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CheJiaNumber];
    return isMatch;
}
#pragma mark - 正则只能输入数字和字母
+ (BOOL) checkTeshuZifuNumber:(NSString *) CheJiaNumber{
    NSString *bankNum=@"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CheJiaNumber];
    return isMatch;
}
#pragma mark - 车牌号验证
+ (BOOL) checkCarNumber:(NSString *) CarNumber{
    NSString *bankNum = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CarNumber];
    return isMatch;
}
#pragma mark - 金额小数点前6位 金额小数点后2位
+ (BOOL) checkAmount:(NSString *) amount{
    NSString *stringRegex = @"(\\+)?(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,5}(([.]\\d{0,2})?)))?";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    BOOL flag = [phoneTest evaluateWithObject:amount];
    return flag;
}
#pragma mark - 正则匹配6位正整数
+ (BOOL)checkNumber6:(NSString *) number{
    NSString *stringRegex = @"^[1-9]\\d{0,5}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    BOOL flag = [phoneTest evaluateWithObject:number];
    return flag;
}
#pragma mark - 正则匹配3位正整数(cvn)
+ (BOOL)checkNumber3:(NSString *) number{
   // @"^[0-9]\\d{0,2}$"
    NSString *stringRegex =  @"(\\+)?([0-9]\\d{0,2})?";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    BOOL flag = [phoneTest evaluateWithObject:number];
    return flag;
}

@end

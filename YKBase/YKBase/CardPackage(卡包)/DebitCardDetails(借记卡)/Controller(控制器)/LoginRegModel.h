//
//  LoginRegModel.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/10.
//  Copyright © 2017年 席亚坤. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface LoginRegModel : NSObject
///手机号
@property (nonatomic, strong) NSString  *mobile ;
///1-QQ 2-微信
@property (nonatomic, strong) NSString  *type ;
///密码
@property (nonatomic, strong) NSString  *password ;
///验证码
@property (nonatomic, strong) NSString  *verify_code ;
///身份证号码
@property (nonatomic, strong) NSString  *id_card ;
///邀请码
@property (nonatomic, strong) NSString  *inviter_code ;
///会话
@property (nonatomic, strong) NSString  *token ;
///加解密key
@property (nonatomic, strong) NSString  *key ;
///账号
@property (nonatomic, strong) NSString  *account ;
///用户唯一标识
@property (nonatomic, strong) NSString  *open_id ;
///0-未绑定 1-已绑定
@property (nonatomic, strong) NSString  *is_bind ;

@end

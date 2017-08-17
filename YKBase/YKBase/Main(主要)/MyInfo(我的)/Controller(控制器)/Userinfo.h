//
//  Userinfo.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Userinfo : NSObject

///真实姓名
@property (nonatomic, strong) NSString  *real_name ;
///手机号
@property (nonatomic, strong) NSString  *mobile ;
///头像URL
@property (nonatomic, strong) NSString  *avatar_url ;
///账户余额
@property (nonatomic, strong) NSString  *amount ;
///冻结资金
@property (nonatomic, strong) NSString  *frozen_amount ;
///0-未认证 1-认证中2-认证成功3-认证失败
@property (nonatomic, strong) NSString  *is_certification ;
///银行数量
@property (nonatomic, strong) NSString  *bank_card_num ;






@end

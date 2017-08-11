//
//  CardModel.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/11.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardModel : NSObject

///银行卡背面
@property (nonatomic, strong) NSString  *bank_card_back_photo ;
///银行卡正面
@property (nonatomic, strong) NSString  *bank_card_photo;
///开户名
@property (nonatomic, strong) NSString  *account_name ;
///银行卡号
@property (nonatomic, strong) NSString  *bank_card_no ;
///开户银行
@property (nonatomic, strong) NSString  *bank_name ;
///信用额度
@property (nonatomic, strong) NSString  *credit_line ;
///有效期
@property (nonatomic, strong) NSString  *valid_thru ;
///CVN
@property (nonatomic, strong) NSString  *cvn2 ;
///账单日
@property (nonatomic, strong) NSString  *state_date ;
///还款日
@property (nonatomic, strong) NSString  *repay_date ;
///预留手机号
@property (nonatomic, strong) NSString  *bind_mobile ;
///验证码
@property (nonatomic, strong) NSString  *verify_code ;
///提现金额
@property (nonatomic, strong) NSString  *money ;
///银行卡Id
@property (nonatomic, strong) NSString  *bank_id ;
///支付密码
@property (nonatomic, strong) NSString  *pay_password ;









@end

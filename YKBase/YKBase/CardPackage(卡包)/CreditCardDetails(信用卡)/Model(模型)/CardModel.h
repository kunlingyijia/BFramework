//
//  CardModel.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/11.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CardSubModel;
@interface CardModel : NSObject
///外部链接
@property (nonatomic, strong) NSString  *link_url ;
///原图
@property (nonatomic, strong) NSString  *image_url ;
///文章ID
@property (nonatomic, strong) NSString  *article_id ;
///文章标题
@property (nonatomic, strong) NSString  *title ;
///文章内容
@property (nonatomic, strong) NSString  *content ;

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

///select
@property (nonatomic, assign) BOOL  selected ;
///保证金
@property (nonatomic, strong) NSString  *bond ;
///手续费
@property (nonatomic, strong) NSString  *fee ;
///开始时间
@property (nonatomic, strong) NSString  *begin_time ;
///结束时间
@property (nonatomic, strong) NSString  *end_time ;
///计划id
@property (nonatomic, strong) NSString  *plan_id ;
///计划单号
@property (nonatomic, strong) NSString  *plan_no ;
///还款金额
@property (nonatomic, strong) NSString  *total_money ;
///总支付金额
@property (nonatomic, strong) NSString  *payment_money ;
///状态1-预览（未支付） 2-确认（已支付，未执行）  3-执行中  4-冻结(取消) 5-删除
@property (nonatomic, strong) NSString  *status ;
///计划状态 1-待还款 2-待付款 3-执行中 4-冻结 5-还款完成
@property (nonatomic, strong) NSString  *plan_status ;



///还款model数组
@property (nonatomic, strong) NSArray <CardSubModel *> *repayModel;
///消费model数组
@property (nonatomic, strong) NSArray <CardSubModel *> *consumeModel;
///充值金额
@property (nonatomic, strong) NSString  *amount ;
///卡类型 1：储蓄卡 2：信用卡
@property (nonatomic, strong) NSString  *type ;



@end



@interface CardSubModel : NSObject

///id
@property (nonatomic, strong) NSString  *repay_id ;
///还款时间
@property (nonatomic, strong) NSString  *repay_time ;
///还款金额
@property (nonatomic, strong) NSString  *money ;
///状态 1-未还款 2-已还款 3-还款中 4-还款失败
@property (nonatomic, strong) NSString  *status ;
///消费时间
@property (nonatomic, strong) NSString  *consume_time ;
///ID
@property (nonatomic, strong) NSString  *consume_id ;
/// 1 还款记录 2 消费记录
@property(nonatomic,strong) NSString * type;
@end



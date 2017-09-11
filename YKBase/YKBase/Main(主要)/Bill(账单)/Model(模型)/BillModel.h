//
//  BillModel.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/21.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface BillModel : NSObject





///账单Id
@property (nonatomic, strong) NSString  *bill_id ;

///类型1-收入 2-支出
@property (nonatomic, strong) NSString  *type ;
///流水类型：1-计划还款2-计划消费3-充值4-提现
@property (nonatomic, strong) NSString  *flow_type ;
///数额
@property (nonatomic, strong) NSString  *money ;
///银行名称
@property (nonatomic, strong) NSString  *bank_name ;
///银行卡号
@property (nonatomic, strong) NSString  *bank_card_no ;
///状态1-成功 2-失败
@property (nonatomic, strong) NSString  *status ;
///创建时间
@property (nonatomic, strong) NSString  *create_time ;
///年月日
@property (nonatomic, strong) NSString  *date ;
///时分
@property (nonatomic, strong) NSString  *minute ;








@end

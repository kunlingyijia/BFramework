//
//  BankCardListVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/30.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface BankCardListVC : BaseViewController
@property (nonatomic, copy) void(^ BankCardListVCBlock)(NSString * bankName,NSString * branch_no,NSString * bank_code);
///银行名称
@property (nonatomic, strong) NSString  *bank_name ;

///是否包括(建设银行和上海银行)
@property (nonatomic, assign) BOOL  IsIncluding ;



@end

//
//  BankCardListVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/30.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface BankCardListVC : BaseViewController
@property (nonatomic, copy) void(^ BankCardListVCBlock)(NSString * bankName);
@end

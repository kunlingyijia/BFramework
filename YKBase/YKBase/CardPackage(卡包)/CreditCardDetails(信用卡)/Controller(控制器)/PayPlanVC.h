//
//  PayPlanVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/9/2.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface PayPlanVC : BaseViewController
///type 1 支付 2 未支付
@property (nonatomic, copy) void(^ PayPlanVCBlock)(NSString *type);
@property (weak, nonatomic) IBOutlet DarkGreyLabel *plan_no;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *bond;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *fee;
@property (weak, nonatomic) IBOutlet PublicLabel *payment_money;

///model
@property (nonatomic, strong) CardModel *cardModel ;


@end

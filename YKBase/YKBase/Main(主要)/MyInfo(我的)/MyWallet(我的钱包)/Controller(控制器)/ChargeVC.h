//
//  ChargeVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/29.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"
@interface ChargeVC : BaseViewController
@property (nonatomic, copy) void(^ ChargeVCBlock)();
@property (weak, nonatomic) IBOutlet DarkGreyTF *amount;
@property (weak, nonatomic) IBOutlet DarkGreyTF *bank_card_no;

@end

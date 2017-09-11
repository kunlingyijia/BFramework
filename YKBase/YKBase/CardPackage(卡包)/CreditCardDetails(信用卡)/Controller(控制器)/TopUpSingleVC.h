//
//  TopUpSingleVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/21.
//  Copyright © 2017年 席亚坤. All rights reserved.
//
#import "BaseViewController.h"

@interface TopUpSingleVC : BaseViewController
@property (nonatomic, copy) void(^ TopUpSingleVCBlock)();
@property (weak, nonatomic) IBOutlet DarkGreyTF *amount;
@property (weak, nonatomic) IBOutlet DarkGreyTF *bank_card_no;
///model
@property (nonatomic, strong) CardModel *cardModel ;
@end

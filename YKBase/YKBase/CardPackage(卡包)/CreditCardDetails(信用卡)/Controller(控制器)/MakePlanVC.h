//
//  MakePlanVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/17.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface MakePlanVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *BankImageView;
@property (weak, nonatomic) IBOutlet WhiteLabel *bank_name;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *credit_line;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *state_date;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *repay_date;
@property (weak, nonatomic) IBOutlet DarkGreyTF *total_money;
@property (weak, nonatomic) IBOutlet DarkGreyTF *begin_time;
@property (weak, nonatomic) IBOutlet DarkGreyTF *end_time;
@property (weak, nonatomic) IBOutlet DarkGreyTF *bond;

@property (weak, nonatomic) IBOutlet DarkGreyLabel *fee;

///model
@property (nonatomic, strong) CardModel *cardModel ;


@end

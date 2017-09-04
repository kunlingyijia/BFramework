//
//  MakePlanDetailtsVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/17.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface MakePlanDetailtsVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *BankImageView;
@property (weak, nonatomic) IBOutlet WhiteLabel *bank_name;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *credit_line;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *state_date;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *repay_date;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *plan_no;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *total_money;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *beginAndend;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *bond;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *fee;
@property (weak, nonatomic) IBOutlet PublicLabel *payment_money;
///model
@property (nonatomic, strong) CardModel *cardModel ;
///model
@property (nonatomic, strong) CardModel *planModel ;
@end

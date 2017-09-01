//
//  DebitCardDetailsVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/10.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"
@class CardModel;
@interface DebitCardDetailsVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *BankImageView;
@property (weak, nonatomic) IBOutlet WhiteLabel *bank_name;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *credit_line;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *state_date;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *repay_date;
///model
@property (nonatomic, strong) CardModel *cardModel ;
@end

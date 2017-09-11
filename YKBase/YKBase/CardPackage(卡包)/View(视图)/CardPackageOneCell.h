//
//  CardPackageOneCell.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardPackageOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet CutView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *BankImageView;

@property (weak, nonatomic) IBOutlet WhiteLabel *bank_name;
@property (weak, nonatomic) IBOutlet WhiteLabel *plan_status;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *credit_line;

@property (weak, nonatomic) IBOutlet DarkGreyLabel *state_date;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *repay_date;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *total_money;



///model
@property (nonatomic, strong) CardModel *model ;




@end

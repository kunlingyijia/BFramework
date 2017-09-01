//
//  AddDebitCard.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/10.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface AddDebitCard : BaseViewController
@property (nonatomic, copy) void(^ AddDebitCardVCBlock)();


@property (weak, nonatomic) IBOutlet UIImageView *bank_card_photo;
@property (weak, nonatomic) IBOutlet UIImageView *bank_card_back_photo;
@property (weak, nonatomic) IBOutlet DarkGreyTF *account_name;
@property (weak, nonatomic) IBOutlet DarkGreyTF *bank_name;

@property (weak, nonatomic) IBOutlet DarkGreyTF *bank_card_no;
@property (weak, nonatomic) IBOutlet DarkGreyTF *credit_line;
@property (weak, nonatomic) IBOutlet DarkGreyTF *valid_thru;
@property (weak, nonatomic) IBOutlet DarkGreyTF *cvn2;
@property (weak, nonatomic) IBOutlet DarkGreyTF *state_date;
@property (weak, nonatomic) IBOutlet DarkGreyTF *repay_date;
@property (weak, nonatomic) IBOutlet DarkGreyTF *bind_mobile;
@property (weak, nonatomic) IBOutlet DarkGreyTF *verify_code;


@end

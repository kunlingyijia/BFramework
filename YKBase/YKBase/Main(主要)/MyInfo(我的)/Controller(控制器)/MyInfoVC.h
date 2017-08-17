//
//  MyInfoVC.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/20.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "BaseViewController.h"

@interface MyInfoVC : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *avatar_url;
@property (weak, nonatomic) IBOutlet WhiteLabel *mobile;
@property (weak, nonatomic) IBOutlet WhiteLabel *amount;
@property (weak, nonatomic) IBOutlet WhiteLabel *frozen_amount;
@property (weak, nonatomic) IBOutlet WhiteLabel *bank_card_num;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *certificationStatus;

@end

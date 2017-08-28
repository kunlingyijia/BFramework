//
//  MyWalletVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface MyWalletVC : BaseViewController
@property (weak, nonatomic) IBOutlet WhiteLabel *amount;
@property (weak, nonatomic) IBOutlet WhiteLabel *frozen_amount;
@property (weak, nonatomic) IBOutlet DarkGreyTF *money;
@property (weak, nonatomic) IBOutlet DarkGreyTF *bankName;

@end

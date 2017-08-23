//
//  PasswordVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/11.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface PasswordVC : BaseViewController

@property (nonatomic, copy) void(^ PasswordVCBlock)(NSString  *account ,NSString  *password);

@end

//
//  RegisteredVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/7.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisteredVC : BaseViewController
@property (nonatomic, copy) void(^ RegisteredVCBlock)(NSString  *account ,NSString  *password);
@end

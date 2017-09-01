//
//  SigningVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/28.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface SigningVC : BaseViewController
@property (nonatomic, copy) void(^ SigningVCBlock)();
///form_data
@property (nonatomic, strong) NSString  *form_data ;


@end

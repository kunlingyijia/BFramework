//
//  BindingVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/10.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface BindingVC : BaseViewController
@property (nonatomic, copy) void(^ BindingVCBlock)();
///1-QQ 2-微信
@property (nonatomic, strong) NSString  *type ;
///用户唯一标识
@property (nonatomic, strong) NSString  *open_id ;

@end

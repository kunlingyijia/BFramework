//
//  PopupVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/8.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface PopupVC : BaseViewController
@property (nonatomic, copy) void(^ PopupVCBlock)(NSInteger tag);
@end

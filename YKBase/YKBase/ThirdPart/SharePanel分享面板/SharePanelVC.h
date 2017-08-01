//
//  SharePanelVC.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/26.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "BaseViewController.h"

@interface SharePanelVC : BaseViewController
@property (nonatomic, copy) void(^SharePanelVCBlock)(UMSocialPlatformType platformType);
///数据
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

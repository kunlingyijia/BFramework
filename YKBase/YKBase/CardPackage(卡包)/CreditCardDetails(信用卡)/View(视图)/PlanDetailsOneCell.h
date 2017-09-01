//
//  PlanDetailsOneCell.h
//  YKBase
//
//  Created by 席亚坤 on 2017/9/1.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardSubModel;
@interface PlanDetailsOneCell : UITableViewCell
///model
@property (nonatomic, strong) CardSubModel *model ;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *time;

@property (weak, nonatomic) IBOutlet DarkGreyLabel *money;

@property (weak, nonatomic) IBOutlet DarkGreyLabel *status;





@end

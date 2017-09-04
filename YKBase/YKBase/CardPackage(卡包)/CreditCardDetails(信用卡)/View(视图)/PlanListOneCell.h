//
//  PlanListOneCell.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/30.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardModel;
@interface PlanListOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet DarkGreyLabel *status;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *plan_no;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *beginAndend;
@property (weak, nonatomic) IBOutlet PublicLabel *total_money
;

///model
@property (nonatomic, strong) CardModel *model ;
@end

//
//  PlanDetailsVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/9/1.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"
@class CardModel;
@interface PlanDetailsVC : BaseViewController
@property (nonatomic, copy) void(^ PlanDetailsVCBlock)();
@property (weak, nonatomic) IBOutlet DarkGreyLabel *plan_no;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *total_money;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *beginAndend;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *bond;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *fee;

@property (weak, nonatomic) IBOutlet SubmitBtn *submitBtn;
///model
@property (nonatomic, strong) CardModel *cardModel ;
@end

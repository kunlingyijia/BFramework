//
//  BillOneCell.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BillModel;
@interface BillOneCell : UITableViewCell
///model
@property (nonatomic, strong) BillModel *model ;
@property (weak, nonatomic) IBOutlet UIImageView *flow_typeImg;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *bank_name;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *money;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *minute;
@property (weak, nonatomic) IBOutlet PublicLabel *status;


@end

//
//  BillHeaderView.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BillModel;
@interface BillHeaderView : UITableViewHeaderFooterView
///title
@property (nonatomic, strong)  DarkGreyLabel *title ;

///model
@property (nonatomic, strong) BillModel *model ;
@end

//
//  PlanDetailsOneCell.m
//  YKBase
//
//  Created by 席亚坤 on 2017/9/1.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "PlanDetailsOneCell.h"
#import "CardModel.h"
@implementation PlanDetailsOneCell
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    //Cell背景颜色
    //self.contentView.backgroundColor = [UIColor colorWithHexString:kViewBackgroundColor];
    //cell选中时的颜色 无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //Cell右侧箭头
    //self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //self.separatorInset = UIEdgeInsetsMake(0, Width, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
}
-(void)setModel:(CardSubModel *)model{
    if (!model) return;
    _model = model;
    //还款
    if ([model.type isEqualToString:@"1"]) {
        self.time.text = [model.repay_time timeStampString];
         //1-未还款 2-已还款
        if ([model.status isEqualToString:@"1"]) {
            self.status.text = @"未还款";
        }
        if ([model.status isEqualToString:@"2"]) {
            self.status.text = @"已还款";
        }
        
    }
    if ([model.type isEqualToString:@"2"]) {
        self.time.text = [model.consume_time timeStampString];
        // 1-未消费 2-已消费
        if ([model.status isEqualToString:@"1"]) {
             self.status.text = @"未消费";
        }
        if ([model.status isEqualToString:@"2"]) {
             self.status.text = @"已消费";
        }
        
    }
    self.money.text = model.money;
}

@end

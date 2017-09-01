//
//  PlanListOneCell.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/30.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "PlanListOneCell.h"
#import "CardModel.h"
@implementation PlanListOneCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    //Cell背景颜色
    self.contentView.backgroundColor = [UIColor colorWithHexString:kViewBackgroundColor];
    //cell选中时的颜色 无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //Cell右侧箭头
    //self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //self.separatorInset = UIEdgeInsetsMake(0, Width, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
}
-(void)setModel:(CardModel *)model{
    if (!model) return;
    _model = model;
    
    self.plan_no.text = model.plan_no;
   // self.total_money.text = model.total_money;
    self.beginAndend.text =[NSString stringWithFormat:@"%@~%@", [model.begin_time timeStampString],[model.end_time timeStampString]];
    

    
    
}

@end

//
//  CardPackageThreeCell.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/25.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "CardPackageThreeCell.h"

@implementation CardPackageThreeCell

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
-(void)setType:(NSString *)type{
    if (!type) return;
    _type = type;
    if ([type isEqualToString:@"2"]) {
        _imageV.image = IMG_Name(@"添加信用卡");
    }
    if ([type isEqualToString:@"1"]) {
        _imageV.image = IMG_Name(@"添加借记卡");
    }

    
}
@end

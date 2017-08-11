//
//  HomePageTwoCell.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "HomePageTwoCell.h"

@implementation HomePageTwoCell
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
    self.separatorInset = UIEdgeInsetsMake(0, Width, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
    
    [self.OneBtn setImagePosition:LXMImagePositionTop spacing:3];
    [self.TwoBtn setImagePosition:LXMImagePositionTop spacing:3];
    [self.ThreeBtn setImagePosition:LXMImagePositionTop spacing:3];
    [self.FourBtn setImagePosition:LXMImagePositionTop spacing:3];
    [self.FiveBtn setImagePosition:LXMImagePositionTop spacing:3];
    [self.SixBtn setImagePosition:LXMImagePositionTop spacing:3];
    [self.SevenBtn setImagePosition:LXMImagePositionTop spacing:3];
    [self.EightBtn setImagePosition:LXMImagePositionTop spacing:3];
    
    
    
}
//-(void)setModel:(<#BankModel#> *)model{
//    if (!model) return;
//    _model = model;
//    
//}

- (IBAction)BTnAction:(PublicBtn *)sender {
    self.HomePageTwoCellBlock(sender.tag-300);
}





@end



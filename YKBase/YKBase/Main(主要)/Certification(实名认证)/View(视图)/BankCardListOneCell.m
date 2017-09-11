//
//  BankCardListOneCell.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/30.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BankCardListOneCell.h"

@implementation BankCardListOneCell

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
-(void)setModel:(CardModel *)model{
    if (!model) return;
    _model = model;
    self.BankImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", model.bank_name]];
    self.Bank_nameLabel.text =  model.bank_name;
    if (_model.selected == YES) {
        self.selectedImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"红色打钩"]];
    }else{
        self.selectedImage.image = IMG_Name(@"");
    }
    
}

@end

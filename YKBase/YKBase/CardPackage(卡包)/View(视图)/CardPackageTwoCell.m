//
//  CardPackageTwoCell.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/10.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "CardPackageTwoCell.h"
#import "CardModel.h"
@implementation CardPackageTwoCell

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
}
-(void)setModel:(CardModel *)model{
    if (!model) return;
    _model = model;
    self.BankImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", model.bank_name]];
    self.BagImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@a", model.bank_name]];
    NSString *bank_card_no ;
    if(model.bank_card_no.length>=4){
        bank_card_no =
        [model.bank_card_no substringFromIndex:model.bank_card_no.length-4];
    }else{
        bank_card_no =
        model.bank_card_no;
    }
    self.bank_name.text = [NSString stringWithFormat:@"%@(%@)",model.bank_name,bank_card_no];
    
    if (_model.selected == YES) {
        self.selectedImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"华夏银行"]];
    }else{
        self.selectedImage.image = IMG_Name(@"");
    }
    
    
    
    
}
@end

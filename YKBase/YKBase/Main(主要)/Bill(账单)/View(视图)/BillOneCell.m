//
//  BillOneCell.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BillOneCell.h"
#import "BillModel.h"
@implementation BillOneCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    //Cell背景颜色
    //self.contentView.backgroundColor = [UIColor colorWithHexString:kViewBg];
    //cell选中时的颜色 无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //Cell右侧箭头
    //self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //self.separatorInset = UIEdgeInsetsMake(0, Width, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
}
-(void)setModel:(BillModel *)model{
    if (!model) return;
    _model = model;
    NSString *bank_card_no ;
    if(model.bank_card_no.length>=4){
        bank_card_no =
        [model.bank_card_no substringFromIndex:model.bank_card_no.length-4];
    }else{
        bank_card_no =
        model.bank_card_no;
    }
    self.bank_name.text = [NSString stringWithFormat:@"%@(%@)",model.bank_name,bank_card_no];
    self.money.text = model.money;
    self.minute.text = model.minute;
    // 1-计划还款 2-计划消费 3-充值 4-提现
    if ([model.status isEqualToString:@"1"]) {
        self.status.textColor = [UIColor colorWithHexString:kBlueColor];
    }
    if ([model.status isEqualToString:@"2"]) {
        self.status.textColor = [UIColor redColor];
    }
    if ([model.flow_type isEqualToString:@"1"]) {
        if ([model.status isEqualToString:@"1"]) {
            self.flow_typeImg.image = IMG_Name(@"还款");
            self.status.text = @"还款成功";
        }
        if ([model.status isEqualToString:@"2"]) {
            self.flow_typeImg.image = IMG_Name(@"还款-拷贝");
            self.status.text = @"还款失败";
        }
    }
    if ([model.flow_type isEqualToString:@"2"]) {
        if ([model.status isEqualToString:@"1"]) {
            self.flow_typeImg.image = IMG_Name(@"消费");
            self.status.text = @"消费成功";
        }
        if ([model.status isEqualToString:@"2"]) {
            self.flow_typeImg.image = IMG_Name(@"消费-拷贝");
            self.status.text = @"消费失败";
        }
    }
    if ([model.flow_type isEqualToString:@"3"]) {
        if ([model.status isEqualToString:@"1"]) {
            self.flow_typeImg.image = IMG_Name(@"充值");
            self.status.text = @"充值成功";
        }
        if ([model.status isEqualToString:@"2"]) {
            self.flow_typeImg.image = IMG_Name(@"充值-拷贝");
            self.status.text = @"充值失败";
        }
    }
    if ([model.flow_type isEqualToString:@"4"]) {
        if ([model.status isEqualToString:@"1"]) {
            self.flow_typeImg.image = IMG_Name(@"提现-1");
            self.status.text = @"提现成功";
        }
        if ([model.status isEqualToString:@"2"]) {
            self.flow_typeImg.image = IMG_Name(@"提现-拷贝");
            self.status.text = @"提现失败";
        }
    }
    
    
    
}
@end

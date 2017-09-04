//
//  HomePageThreeCell.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "HomePageThreeCell.h"
#import "CardModel.h"
@implementation HomePageThreeCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    //Cell背景颜色
    self.contentView.backgroundColor = [UIColor colorWithHexString:kViewBackgroundColor];
    //
    self.bottomView.backgroundColor = [UIColor colorWithHexString:kBlueColor];
    //cell选中时的颜色 无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
     [self.OneBtn setImagePosition:LXMImagePositionTop spacing:3];
    //[self.bottomView.layer  setLaberMasksToBounds:YES cornerRadius:10 borderWidth:0.0 borderColor:nil];
    //Cell右侧箭头
    //self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    self.separatorInset = UIEdgeInsetsMake(0, Width, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
}
-(void)setModel:(CardModel *)model{
    if (!model) return;
    _model = model;
    self.BankImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", model.bank_name]];
    NSString *bank_card_no ;
    if(model.bank_card_no.length>=4){
        bank_card_no =
        [model.bank_card_no substringFromIndex:model.bank_card_no.length-4];
    }else{
        bank_card_no =
        model.bank_card_no;
    }
    self.bank_name.text = [NSString stringWithFormat:@"%@(%@)",model.bank_name,bank_card_no];
    self.credit_line.text = model.credit_line;
    self.state_date.text =[NSString stringWithFormat:@"%@日", model.state_date];
    self.repay_date.text =[NSString stringWithFormat:@"%@日", model.repay_date] ;    
}

@end

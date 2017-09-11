//
//  MessageOneCell.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "MessageOneCell.h"
#import "MessageModel.h"
@implementation MessageOneCell

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
    self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
//    self.imgView = [[UIImageView alloc]init];
//    self.imgView.frame = CGRectMake(15, 10, 50, 35) ;
//    [self.contentView addSubview:self.imageView];
    self.ConstraintWidth.constant = 0.16*Width-20;
}
-(void)setModel:(MessageModel *)model{
    if (!model) return;
    _model = model;
    ///通知 1-系统公告   2-个人通知
    if ([model.type isEqualToString:@"1"]) {
        self.type.text = @"系统公告";
        self.imgView.image = IMG_Name(@"系统公告");
    }else{
        self.type.text = @"个人通知";
        self.imgView.image = IMG_Name(@"个人通知");

    }
    self.title.text = model.content;
    self.create_time.text =[model.create_time timeStampString];
    
    
    
}
@end


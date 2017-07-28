//
//  SharePanelOneCell.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/26.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "SharePanelOneCell.h"
#import "SharePanelModel.h"
@implementation SharePanelOneCell
- (void)awakeFromNib {
    [super awakeFromNib];
    //Cell背景颜色
    self.contentView.backgroundColor = [UIColor clearColor];
    //cell选中时的颜色 无色
    //self.selectionStyle = UITableViewCellSelectionStyleNone;
    //Cell右侧箭头
    //self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //self.separatorInset = UIEdgeInsetsMake(0, Width, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
}
-(void)setModel:(SharePanelModel *)model{
    if (!model) return;
    _model = model;
   // [YKHTTPSession SD_WebImage:_image imageUrlStr:model.image placeholderImage:nil];
    _image.image = [UIImage imageNamed:model.image];
    _title.text = model.title;
}
@end


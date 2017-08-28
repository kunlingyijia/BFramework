//
//  HomePageOneCell.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface HomePageOneCell : UITableViewCell<SDCycleScrollViewDelegate>
///轮播图
@property (nonatomic, copy) void(^HomePageOneCellImgBlock)(NSInteger tag);
///消息
@property (nonatomic, copy) void(^HomePageOneCellLabelBlock)(NSInteger tag);
@property (weak, nonatomic) IBOutlet UIView *ShufflingImgView;
@property (weak, nonatomic) IBOutlet UIView *ShufflingLabelView;
//轮播图赋值
-(void)cellGetDataWithBanner:(NSMutableArray*)arr;
///喇叭赋值
-(void)cellGetDataWithWin:(NSMutableArray*)arr;

@end

//
//  UITabBar+badge.m
//  YKBase
//
//  Created by 席亚坤 on 2017/7/28.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "UITabBar+badge.h"
#define TabbarItemNums 2.0    //tabbar的数量 如果是5个设置为5.0
@implementation UITabBar (badge)
///使用方法
/*
 //显示
 [self.tabBarController.tabBar showBadgeOnItemIndex:2];
 //隐藏
 [self.tabBarController.tabBar hideBadgeOnItemIndex:2]
 */




#pragma mark - 显示小红点
- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 8888 + index;
    badgeView.layer.cornerRadius = 5;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);//圆形大小为10
    [self addSubview:badgeView];
}
#pragma mark - 隐藏小红点

- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}
#pragma mark - 移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 8888+index) {
            [subView removeFromSuperview];
        }
    }
}
@end

//
//  UITabBar+badge.h
//  YKBase
//
//  Created by 席亚坤 on 2017/7/28.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
 ///显示小红点
- (void)showBadgeOnItemIndex:(int)index;
///隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index;
@end

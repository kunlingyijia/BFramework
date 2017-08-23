//
//  LBTabBar.h
//  XianYu
//
//  Created by li  bo on 16/5/28.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LBTabBar;

@protocol LBTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar;
@end


@interface LBTabBar : UITabBar
/** plus按钮 */
@property (nonatomic, strong) UIButton *plusBtn ;
/** tabbar的代理 */
@property (nonatomic, assign) id<LBTabBarDelegate> myDelegate ;

@end

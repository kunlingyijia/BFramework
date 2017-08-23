//
//  BaseNavigationController.m
//  DWduifubao
//
//  Created by kkk on 16/9/8.
//  Copyright © 2016年 bianming. All rights reserved.
//

#import "BaseNavigationVC.h"
@interface BaseNavigationVC ()<UIGestureRecognizerDelegate>
@end

@implementation BaseNavigationVC
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        // 此处可以做一下初始化操作
        // 设置 Pop 侧滑返回动画代理
        __weak typeof(self) weakSelf = self;
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.delegate = weakSelf;
            
        }
    }
    return self;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 根控制器不处理侧滑返回手势
    return self.childViewControllers.count > 1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitilColor];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)setTitilColor{
    
    NSDictionary * dict= [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:17*SizeScale],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil];
    self.navigationBar.titleTextAttributes = dict;
    
}

//设置只有一级界面显示Tabbar
- (void)pushViewController:(BaseViewController *)viewController animated:(BOOL)animated{
    // 除了根控制器以外需设置
    [viewController setHidesBottomBarWhenPushed:self.viewControllers.count > 0 ? YES:NO];
    [super pushViewController:viewController animated:animated];
}


@end

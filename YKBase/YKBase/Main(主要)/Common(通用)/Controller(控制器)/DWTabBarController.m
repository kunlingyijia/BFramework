//
//  DWTabBarController.m
//  DWduifubao
//
//  Created by kkk on 16/9/8.
//  Copyright © 2016年 bianming. All rights reserved.
//

#import "DWTabBarController.h"
#import "HomePageVC.h"
#import "MyInfoVC.h"
@interface DWTabBarController ()

@end

@implementation DWTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addAllChidViewController];
}
- (void)addAllChidViewController {
    //tabbar的背景颜色
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    [self.tabBar insertSubview:bgView atIndex:0];
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    self.tabBar.opaque = YES;
    //设置状态栏字体颜色
    //UIStatusBarStyleDefault  黑色
    //UIStatusBarStyleLightContent 白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    //创建主页面四个分类
    //创建一个单例 存储四个分类 在整个工程都能用
    HomePageVC*   homePageVC = [[HomePageVC alloc] initWithNibName:@"HomePageVC" bundle:nil];
    MyInfoVC* myInfoVC = [[MyInfoVC alloc] initWithNibName:@"MyInfoVC" bundle:nil];
    [self addOneChildVc:homePageVC title:@"首页" imageName:@"首页" selectedImageName:@"首页－点击"];
    [self addOneChildVc:myInfoVC title:@"我的" imageName:@"我的" selectedImageName:@"我的－点击"];
   
    
    //添加导航控制器
    BaseNavigationVC *nav1 = [[BaseNavigationVC alloc] initWithRootViewController:homePageVC];
    BaseNavigationVC *nav2 = [[BaseNavigationVC alloc] initWithRootViewController:myInfoVC];
    self.viewControllers = @[nav1, nav2];
}

- (void)addOneChildVc:(BaseViewController *)childVc title:(NSString *)title imageName:(NSString *)imageN selectedImageName:(NSString *)selectedImageN {
    //设置标题
    childVc.title = title;
    //设置图标
    childVc.tabBarItem.image = [[UIImage imageNamed:imageN] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置选中图标
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageN] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    //设置文字
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10*SizeScale],NSFontAttributeName, [UIColor colorWithHexString:kDarkGrey],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10*SizeScale],NSFontAttributeName, [UIColor colorWithHexString:kRedColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       [UIColor whiteColor], UITextAttributeTextColor,
//                                                       nil] forState:UIControlStateNormal];
//    UIColor *titleHighlightedColor = [UIColor greenColor];
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       titleHighlightedColor, UITextAttributeTextColor,
//                                                       nil] forState:UIControlStateSelected];

    //添加导航控制器
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

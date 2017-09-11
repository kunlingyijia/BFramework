//
//  DWTabBarController.m
//  DWduifubao
//
//  Created by kkk on 16/9/8.
//  Copyright © 2016年 bianming. All rights reserved.
//

#import "DWTabBarController.h"
#import "LBTabBar.h"
#import "HomePageVC.h"
#import "CardPackageVC.h"
#import "BillVC.h"
#import "MyInfoVC.h"
#import "PopupVC.h"
#import "AddDebitCard.h"
#import "AddDebitCardVC.h"
#import "MyWalletVC.h"
#import "TopUpVC.h"
#import "ChargeVC.h"
#import "WalletDetailVC.h"
@interface DWTabBarController ()<LBTabBarDelegate>

@end

@implementation DWTabBarController
#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    //设置文字
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10*SizeScale],NSFontAttributeName, [UIColor colorWithHexString:kDarkGrey],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10*SizeScale],NSFontAttributeName, [UIColor colorWithHexString:kBlueColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setUpAllChildVc];
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    LBTabBar *tabbar = [[LBTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
}
#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{
    //创建一个单例 存储四个分类 在整个工程都能用
    HomePageVC*   homePageVC = [[HomePageVC alloc] initWithNibName:@"HomePageVC" bundle:nil];
    CardPackageVC* cardPackageVC = [[CardPackageVC alloc] initWithNibName:@"CardPackageVC" bundle:nil];
    BillVC*   billVC = [[BillVC alloc] initWithNibName:@"BillVC" bundle:nil];
    MyInfoVC* myInfoVC1 = [[MyInfoVC alloc] initWithNibName:@"MyInfoVC" bundle:nil];
    [self setUpOneChildVcWithVc:homePageVC Image:@"首页" selectedImage:@"首页1" title:@"首页"];
    [self setUpOneChildVcWithVc:cardPackageVC Image:@"卡包1" selectedImage:@"卡包" title:@"卡包"];
    [self setUpOneChildVcWithVc:billVC Image:@"账单" selectedImage:@"账单蓝" title:@"账单"];
    [self setUpOneChildVcWithVc:myInfoVC1 Image:@"我的" selectedImage:@"我的蓝" title:@"我的"];
}
#pragma mark - 初始化设置tabBar上面单个按钮的方法
/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    BaseNavigationVC *nav = [[BaseNavigationVC alloc] initWithRootViewController:Vc];
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.selectedImage = mySelectedImage;
    Vc.tabBarItem.title = title;
    Vc.navigationItem.title = title;
    [self addChildViewController:nav];
}
#pragma mark - ------------------------------------------------------------------
#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar
{
    PopupVC* VC = GetVC(PopupVC);
    VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    VC.PopupVCBlock = ^(NSInteger tag){
        // 在主线程中延迟执行某动作，不会卡主主线程，不影响后面的东做执行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ///是否实名认证
            if ([HTTPTool isCertification]) {
                return;
            }
            switch (tag) {
                case 1:
                {
                    //新增信用卡
                    AddDebitCard * VC =  GetVC(AddDebitCard);
                    VC.AddDebitCardVCBlock = ^(){
                        [DWAlertTool getCurrentUIVC].tabBarController.selectedIndex = 1;
                    };
                    [[DWAlertTool getCurrentUIVC].navigationController pushViewController:VC animated:YES ];
                    break;
                }
                case 2:
                {
                    //新增借记卡
                    AddDebitCardVC * VC =  GetVC(AddDebitCardVC);
                    VC.AddDebitCardVCBlock = ^(){
                    [DWAlertTool getCurrentUIVC].tabBarController.selectedIndex = 1;
                    };
                    [[DWAlertTool getCurrentUIVC].navigationController pushViewController:VC animated:YES ];
                    break;
                }
                case 3:
                {
                    //快速充值
                    ChargeVC * VC =  GetVC(ChargeVC);
                    VC.ChargeVCBlock = ^(){
                        [DWAlertTool getCurrentUIVC].tabBarController.selectedIndex = 2;
                    };
                    [[DWAlertTool getCurrentUIVC].navigationController pushViewController:VC animated:YES ];
                    break;
                }
                case 4:
                {
                    //掌上提现 跳转
                    MyWalletVC * VC = GetVC(MyWalletVC);
                    VC.MyWalletVCBlock = ^(){
                        WalletDetailVC * VC =  GetVC(WalletDetailVC);
                        [[DWAlertTool getCurrentUIVC].navigationController pushViewController:VC animated:YES];
                        //[DWAlertTool getCurrentUIVC].tabBarController.selectedIndex = 2;
                    };
                    [[DWAlertTool getCurrentUIVC].navigationController pushViewController:VC animated:YES ];
                    break;
                }
                default:{
                    break;
                }
            }
        });
    };
    [[DWAlertTool getCurrentUIVC] presentViewController:VC animated:NO completion:nil];
}


@end

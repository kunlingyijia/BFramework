//
//  CurrentVersionVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/16.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "CurrentVersionVC.h"

@interface CurrentVersionVC ()
@property (weak, nonatomic) IBOutlet DarkGreyLabel *Label;

@end

@implementation CurrentVersionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
    [self SET_UI];
    //数据
    [self  SET_DATA];
}
#pragma mark - 关于UI
-(void)SET_UI{
    [self showBackBtn];
    self.title = @"当前版本";
}
#pragma mark - 关于数据
-(void)SET_DATA{
    //代码实现获得应用的Verison号：
    NSString *oldVerison =    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //获得build号：
    NSString *build =    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] ;
    self.Label.text =[NSString stringWithFormat: @"For iPhone V%@ bulid%@",oldVerison,build];
}
#pragma mark - dealloc
- (void)dealloc
{
    NSLog(@"%@销毁了", [self class]);
}
@end

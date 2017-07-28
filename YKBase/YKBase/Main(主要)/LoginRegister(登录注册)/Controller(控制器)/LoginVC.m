//
//  LoginVC.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/24.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

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
    self.title = @"登录";
    
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
    
    
}
#pragma mark - dealloc
- (void)dealloc
{
    
    NSLog(@"%@销毁了", [self class]);
}

@end

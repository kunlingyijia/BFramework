//
//  PublicVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/9/8.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "PublicVC.h"

@interface PublicVC ()

@end

@implementation PublicVC

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
    self.title = @"敬请期待";
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
}
@end

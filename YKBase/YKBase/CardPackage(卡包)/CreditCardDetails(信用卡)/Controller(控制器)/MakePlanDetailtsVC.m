//
//  MakePlanDetailtsVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/17.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "MakePlanDetailtsVC.h"

@interface MakePlanDetailtsVC ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation MakePlanDetailtsVC


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
    self.title = @"制定计划";
    self.bottomView.backgroundColor = [UIColor colorWithHexString:kBlueColor];
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
    
    
}
#pragma mark - 计算保证金
- (IBAction)calculateAction:(SubmitBtn *)sender {
    [self.view endEditing:YES];
    
    //跳转
    MakePlanDetailtsVC * VC =  GetVC(MakePlanDetailtsVC);
    
    PushVC(VC);
    
}
#pragma mark - 选择时间
- (IBAction)timeAction:(UIButton *)sender {
    [self.view endEditing:YES];
    
}
#pragma mark - 提交
- (IBAction)submitAction:(SubmitBtn *)sender {
    if ([self IF]) {
        
    }
}


#pragma mark - 判断条件
-(BOOL)IF{
    [self.view endEditing:YES];
    BOOL  Y = YES;
    
    return Y;
}


@end


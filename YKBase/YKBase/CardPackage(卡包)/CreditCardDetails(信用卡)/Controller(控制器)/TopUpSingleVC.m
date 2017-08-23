//
//  TopUpSingleVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/21.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "TopUpSingleVC.h"
@interface TopUpSingleVC ()
@property (weak, nonatomic) IBOutlet UIView *OneView;


@end
@implementation TopUpSingleVC
#pragma mark -  视图将出现在屏幕之前
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma mark - 视图已在屏幕上渲染完成
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
#pragma mark -  载入完成
- (void)viewDidLoad {
    [super viewDidLoad];
    //关于UI
    [self SET_UI];
    //关于数据
    [self  SET_DATA];
    
}
#pragma mark - 关于UI
-(void)SET_UI{
    self.title = @"快速充值";
    [self showBackBtn];
    [self.OneView.layer setLaberMasksToBounds:YES cornerRadius:cutRadius*SizeScale borderWidth:borderW*SizeScale borderColor:[UIColor colorWithHexString:kLineColor]];
}

#pragma mark - 关于数据
-(void)SET_DATA{
    [self requestAction];
}

#pragma mark - 网络请求
-(void)requestAction{
    
}


#pragma mark - 立即支付
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




#pragma mark - dealloc
- (void)dealloc
{
    NSLog(@"%@销毁了", [self class]);
}

@end

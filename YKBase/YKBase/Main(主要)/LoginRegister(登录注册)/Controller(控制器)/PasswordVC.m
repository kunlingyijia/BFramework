//
//  PasswordVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/11.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "PasswordVC.h"
#import "LoginRegModel.h"
#import "MyInfoVC.h"
@interface PasswordVC ()
@property (weak, nonatomic) IBOutlet DarkGreyTF *mobile;
@property (weak, nonatomic) IBOutlet DarkGreyTF *verify_code;
@property (weak, nonatomic) IBOutlet DarkGreyTF *password;
@end
@implementation PasswordVC
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
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
}
#pragma mark - 发送验证码
- (IBAction)VerificationCodeAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([RegularTool checkTelNumber:self.mobile.text]) {
        [DWAlertTool VerificationCodeBtn:sender];
        // 1-注册 2-找回密码3-修改密码4-绑定手机号
        [HTTPTool requestVerifyCodeWithParm:@{@"mobile":self.mobile.text,@"type":@"2"} active:YES success:^(BaseResponse * _Nullable baseRes) {
        } faild:^(NSError * _Nullable error) {
        }];
    }else{
        [DWAlertTool showToast:@"手机号码输入有误"];
    }
}
#pragma mark - 确定事件
- (IBAction)BtnAction:(SubmitBtn *)sender {
    if ([self IF]) {
        LoginRegModel *model = [LoginRegModel new];
        model.mobile = self.mobile.text;
        model.verify_code = self.verify_code.text;
        model.password = self.password.text;
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask * task =  [HTTPTool  requesForgottenPasswordWithParm:model active:NO success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode ==1) {
                [DWAlertTool showToast:@"密码设置成功"];
                // 在主线程中延迟执行某动作，不会卡主主线程，不影响后面的东做执行
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(backTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakSelf.PasswordVCBlock(weakSelf.mobile.text,weakSelf.password.text);
                    //返回
                    [weakSelf.navigationController popViewControllerAnimated:YES] ;
                });
            }
        } faild:^(NSError * _Nullable error) {
        }];
        if (task) {
            [self.sessionArray addObject:task];
        }
    }
}
#pragma mark - 判断条件
-(BOOL)IF{
    [self.view endEditing:YES];
    BOOL  Y = YES;
    if (![RegularTool checkTelNumber:self.mobile.text]) {
        [DWAlertTool showToast:@"手机号码输入有误"];
        return NO;
    }
    if (self.verify_code.text.length==0 ){
        [DWAlertTool showToast:@"验证码输入有误"];
        return NO;
    }
    if (![RegularTool checkPassword:self.password.text]) {
        [DWAlertTool showToast:@"密码输入有误"];
        return NO;
    }
    return Y;
}

#pragma mark - dealloc
- (void)dealloc
{
    NSLog(@"%@销毁了", [self class]);
}
@end

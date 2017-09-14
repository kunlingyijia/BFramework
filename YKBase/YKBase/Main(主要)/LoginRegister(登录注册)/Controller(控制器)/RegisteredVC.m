//
//  RegisteredVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/7.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "RegisteredVC.h"
#import "LoginRegModel.h"
@interface RegisteredVC ()
@property (weak, nonatomic) IBOutlet DarkGreyTF *mobile;
@property (weak, nonatomic) IBOutlet DarkGreyTF *verify_code;
@property (weak, nonatomic) IBOutlet DarkGreyTF *password;
@property (weak, nonatomic) IBOutlet DarkGreyTF *oncepassword;
@property (weak, nonatomic) IBOutlet DarkGreyTF *inviter_code;
@end
@implementation RegisteredVC
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
    self.title = @"注册";
}
#pragma mark - 关于数据
-(void)SET_DATA{
}
#pragma mark - 发送验证码
- (IBAction)VerificationCodeAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([RegularTool checkTelNumber:self.mobile.text]) {
        [DWAlertTool VerificationCodeBtn:sender];
        //1-注册 2-找回密码3-修改密码4-绑定手机号
        [HTTPTool requestVerifyCodeWithParm:@{@"mobile":self.mobile.text,@"type":@"1"} active:YES success:^(BaseResponse * _Nullable baseRes) {
        } faild:^(NSError * _Nullable error) {
        }];
    }else{
        [DWAlertTool showToast:@"手机号码输入有误"];
    }
}
- (IBAction)registeredAction:(PublicBtn *)sender {
    if ([self IF]) {
        LoginRegModel *model = [LoginRegModel new];
        model.mobile = self.mobile.text;
        model.password = self.password.text;
        model.verify_code = self.verify_code.text;
        model.inviter_code =self.inviter_code.text;
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask * task =  [HTTPTool  requestRegisterWithParm:model active:NO success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode ==1) {
                LoginRegModel *model = [LoginRegModel yy_modelWithJSON:baseRes.data];
                [YKDataTool saveUserData:model.key forKey:@"key"];
                [YKDataTool saveUserData:model.token forKey:@"token"];
                //返回
                weakSelf.RegisteredVCBlock(weakSelf.mobile.text,weakSelf.password.text);
                PopVC;
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
    if (![self.password.text isEqualToString:self.oncepassword.text]) {
        [DWAlertTool showToast:@"密码输入不一致"];
        return NO;
    }
    if (self.inviter_code.text.length==0 ){
        [DWAlertTool showToast:@"邀请码输入有误"];
        return NO;
    }
    return Y;
}

#pragma mark - 扫描二维码
- (IBAction)ErWeiMaAction:(UIButton *)sender {
    JQScanViewController *VC = [JQScanViewController new];
    __weak typeof(self) weakSelf = self;
    VC.JQScanVCBlock = ^(JQScanResult* strResult){
        weakSelf.inviter_code.text =strResult.strScanned;
    };
    PushVC(VC)
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField ==self.mobile) {
        NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return  [RegularTool checkNumber11:toString];
    }
    return YES;
}

#pragma mark - dealloc
- (void)dealloc
{
    NSLog(@"%@销毁了", [self class]);
}
@end

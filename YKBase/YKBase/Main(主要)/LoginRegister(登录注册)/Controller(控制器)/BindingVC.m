//
//  BindingVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/10.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BindingVC.h"
#import "LoginRegModel.h"
#import "RegisteredVC.h"

@interface BindingVC ()
@property (weak, nonatomic) IBOutlet DarkGreyTF *mobile;
@property (weak, nonatomic) IBOutlet DarkGreyTF *verify_code;
@end

@implementation BindingVC

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
    self.title = @"绑定手机";
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
    
    
}
#pragma mark - 发送验证码
- (IBAction)VerificationCodeAction:(UIButton *)sender {
    [self.view endEditing:YES];
   // 1-注册 2-找回密码3-修改密码4-绑定手机号
    __weak typeof(self) weakSelf = self;
    if ([RegularTool checkTelNumber:self.mobile.text]) {
        [DWAlertTool VerificationCodeBtn:sender];
        [HTTPTool requestVerifyCodeWithParm:@{@"mobile":self.mobile.text,@"type":@"4"} active:YES success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode ==16) {
                
                //[DWAlertTool alertWithTitle:@"尚未注册,是否注册?" message:nil OKWithTitle:@"注册"CancelWithTitle:@"取消" withOKDefault:^(UIAlertAction *defaultaction) {
                    //Push 跳转
                    RegisteredVC * VC = GetVC(RegisteredVC)
                    VC.RegisteredVCBlock = ^(NSString  *account ,NSString  *password){
                        weakSelf.mobile.text = account;
                    };
                    PushVC(VC)
//                } withCancel:^(UIAlertAction *cancelaction) {
//                    
//                }];
            }
            } faild:^(NSError * _Nullable error) {
        }];
    }else{
        [DWAlertTool showToast:@"手机号码输入有误"];
    }
}
#pragma mark - 绑定事件
- (IBAction)BtnAction:(SubmitBtn *)sender {
     if ([self IF]) {
        LoginRegModel *model = [LoginRegModel new];
        model.mobile = self.mobile.text;
        model.verify_code = self.verify_code.text;
        model.type = self.type;
        model.open_id = self.open_id;
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask * task =  [HTTPTool  requesThirdLoginBindMobileWithParm:model active:NO success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode ==1) {
                [YKDataTool saveUserData:model.key forKey:@"key"];
                [YKDataTool saveUserData:model.token forKey:@"token"];
                //设置别名
                [YKNotification postNotificationName:@"设置别名" object:nil userInfo:[NSDictionary dictionaryWithObject:@"" forKey:@"pushAlias"]];
                [weakSelf  requestUserInfo];
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
    return Y;
}
#pragma mark - 请求个人信息
-(void)requestUserInfo{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestUserInfoWithParm:@{} active:NO success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
             weakSelf.BindingVCBlock();
        }
    } faild:^(NSError * _Nullable error) {
        
    }];
    if (task) {
        [self.sessionArray addObject:task];
    }
}

#pragma mark - dealloc
- (void)dealloc
{
    
    NSLog(@"%@销毁了", [self class]);
}
@end

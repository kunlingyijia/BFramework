//
//  LoginVC.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/24.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "LoginVC.h"
#import "RegisteredVC.h"
#import "UpdatePasswordVC.h"
#import "LoginRegModel.h"
#import "BindingVC.h"
#import "PasswordVC.h"
@interface LoginVC ()
@property (weak, nonatomic) IBOutlet DarkGreyTF *account;
@property (weak, nonatomic) IBOutlet DarkGreyTF *password;

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
    //[self showBackBtn];
    self.title = @"登录";
    
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    self.account.text = [YKDataTool getuseraccount];
}

#pragma mark - 登录事件
- (IBAction)LoginAction:(SubmitBtn *)sender {
    DismissVC
    if ([self IF]) {
//        LoginRegModel *model = [LoginRegModel new];
//        model.account = self.account.text;
//        model.password = self.password.text;
//        __weak typeof(self) weakSelf = self;
//        NSURLSessionDataTask * task =  [HTTPTool  requestLoginWithParm:model active:NO success:^(BaseResponse * _Nullable baseRes) {
//                if (baseRes.resultCode ==1) {
//                    LoginRegModel *model = [LoginRegModel yy_modelWithJSON:baseRes.data];
//                    [YKDataTool saveUserData:weakSelf.account.text forKey:@"useraccount"];
//                    [YKDataTool saveUserData:model.key forKey:@"loginKey"];
//                    [YKDataTool saveUserData:model.token forKey:@"loginToken"];
//                    //设置别名
//                    [YKNotification postNotificationName:@"设置别名" object:nil userInfo:[NSDictionary dictionaryWithObject:@"" forKey:@"pushAlias"]];
//                    [weakSelf  requestUserInfo];
//                }
//
//            } faild:^(NSError * _Nullable error) {
//                
//            }];
//           if (task) {
//                [self.sessionArray addObject:task];
//        }
        
    }
}
#pragma mark - 判断条件
-(BOOL)IF{
    [self.view endEditing:YES];
    BOOL  Y = YES;
    if (![RegularTool checkTelNumber:self.account.text]) {
        [DWAlertTool showToast:@"手机号码输入有误"];
        return NO;
    }
    if (![RegularTool checkPassword:self.password.text]) {
        [DWAlertTool showToast:@"密码输入有误"];
        return NO;
    }
       return Y;
}
#pragma mark - 请求个人信息
-(void)requestUserInfo{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestUserInfoWithParm:@{} active:NO success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            //返回
            [weakSelf dismissViewControllerAnimated:YES completion:^{}];
        }
    } faild:^(NSError * _Nullable error) {
        
    }];
    if (task) {
        [self.sessionArray addObject:task];
    }
}
#pragma mark - 快速注册
- (IBAction)RegisteredAction:(UIButton *)sender {
    //Push 跳转
    RegisteredVC * VC = GetVC(RegisteredVC)
    __weak typeof(self) weakSelf = self;
    VC.RegisteredVCBlock = ^(NSString  *account ,NSString  *password){
        weakSelf.account.text = account;
        weakSelf.password.text = password;
    };
    PushVC(VC)
    
}
#pragma mark - 忘记密码
- (IBAction)PasswordVCAction:(UIButton *)sender {
    //Push 跳转
    PasswordVC * VC = GetVC(PasswordVC)
    __weak typeof(self) weakSelf = self;
    VC.PasswordVCBlock = ^(NSString  *account ,NSString  *password){
        weakSelf.account.text = account;
        weakSelf.password.text = password;
    };
    PushVC(VC)
    
}

- (IBAction)WXAction:(UIButton *)sender {
    if (sender.tag ==201) {
        //微信登录
        [self requestThirdLoginType:UMSocialPlatformType_WechatSession];
    }
    if (sender.tag ==202) {
        //QQ登录
        [self requestThirdLoginType:UMSocialPlatformType_QQ];
    }
    
}
#pragma mark - 第三方登录
-(void)requestThirdLoginType:(UMSocialPlatformType)platformType{
    
    __weak typeof(self) weakSelf = self;
    NSString *type ;
    if (platformType ==UMSocialPlatformType_QQ) {
        type = @"1";
    }
    if (platformType ==UMSocialPlatformType_WechatSession) {
        type = @"2";
    }
    [ThirdPartyTool ULoginType:platformType ULoginSuccess:^(UMSocialUserInfoResponse *response) {
        LoginRegModel *model = [LoginRegModel new];
        model.open_id = response.openid;
        model.type = type;
        NSURLSessionDataTask * task =  [HTTPTool  requestThirdLoginWithParm:model active:NO success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode ==1) {
                LoginRegModel *model = [LoginRegModel yy_modelWithJSON:baseRes.data];
                //0-未绑定 1-已绑定
                if ([model.is_bind isEqualToString:@"0"] ) {
                    //Push 跳转
                    BindingVC * VC = GetVC(BindingVC)
                    VC.type = type;
                    VC.open_id =response.openid;
                    PushVC(VC)
                }
                if ([model.is_bind isEqualToString:@"1"] ) {
                    [YKDataTool saveUserData:model.key forKey:@"loginKey"];
                    [YKDataTool saveUserData:model.token forKey:@"loginToken"];
                    //设置别名
                    [YKNotification postNotificationName:@"设置别名" object:nil userInfo:[NSDictionary dictionaryWithObject:@"" forKey:@"pushAlias"]];
                    [weakSelf  requestUserInfo];
                }
            }
            
        } faild:^(NSError * _Nullable error) {
            
        }];
        if (task) {
            [weakSelf.sessionArray addObject:task];
        }
    }];

    
}


#pragma mark - dealloc
- (void)dealloc
{
    
    NSLog(@"%@销毁了", [self class]);
}

@end

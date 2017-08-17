//
//  RegisteredVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/7.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "RegisteredVC.h"
#import "LoginRegModel.h"
@interface RegisteredVC ()<LBXscanViewDelegate>
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
    //设置扫码区域参数设置
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"icon_saoyisao_saomiaoxian"];
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    LBXViewController *vc = [[LBXViewController alloc] init];
    vc.title = @"扫一扫";
    vc.delegate = self;
    vc.style = style;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)backAction:(LBXScanResult *)result {
    //NSString *  strone = [result.strScanned substringToIndex:4];
    self.inviter_code.text =result.strScanned;
    //NSString *  strone = [result.strScanned substringToIndex:4];
 }




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

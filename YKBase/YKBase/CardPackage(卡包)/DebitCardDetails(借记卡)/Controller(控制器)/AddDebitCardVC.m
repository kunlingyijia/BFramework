//
//  AddDebitCardVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/10.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "AddDebitCardVC.h"
#import "DWBankViewController.h"
#import "Bank_Region_Bank_Branch.h"
@interface AddDebitCardVC ()
@property(nonatomic,strong)NSString * bank_card_photoUrl;
@property(nonatomic,strong)NSString * bank_card_back_photoUrl;
@end

@implementation AddDebitCardVC


- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
    [self SET_UI];
    //数据
    [self  SET_DATA];
    
    //创建观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Bank_Region_Bank_BranchAction:) name:@"Bank_Region_Bank_Branch" object:nil];
    
}
#pragma mark - 创建观察者返回数据
-(void)Bank_Region_Bank_BranchAction:(NSNotification*)sender{
    NSDictionary * dic = [sender.userInfo objectForKey:@"Bank_Region_Bank_Branch"];
    Bank_Region_Bank_BranchModel * model = [Bank_Region_Bank_BranchModel yy_modelWithJSON:dic];
    self.bank_name.text = model.bank_name;
}

#pragma mark - 关于UI
-(void)SET_UI{
    [self showBackBtn];
    self.title = @"添加借记卡";
    
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
    
    
}

#pragma mark - 选择图片
- (IBAction)bankAction:(UIButton *)sender {
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    
    
    switch (sender.tag) {
        case 401:
        {
            ImageChooseVC* VC = [[ImageChooseVC alloc]initWithNibName:@"ImageChooseVC" bundle:nil];
            VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            VC.imageType = EditedImage;
            VC.zoom= 0.6;
            VC.ImageChooseVCBlock =^(UIImage *image){
                NSLog(@"%@",image);
                [[YKHTTPSession shareSession]UPImageToServer:@[image] toKb:100 success:^(NSArray *urlArr) {
                    NSDictionary * dic = urlArr[0];
                    weakSelf.bank_card_photoUrl = dic[@"url"];
                    weakSelf.bank_card_photo.image = image;

                } faild:^(id error) {
                    
                }];
            };
            [self presentViewController:VC animated:NO completion:nil];
            break;
        }
            
        case 402:
        {
            ImageChooseVC* VC = [[ImageChooseVC alloc]initWithNibName:@"ImageChooseVC" bundle:nil];
            VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            VC.imageType = EditedImage;
            VC.zoom= 0.6;
            VC.ImageChooseVCBlock =^(UIImage *image){
                NSLog(@"%@",image);
                [[YKHTTPSession shareSession]UPImageToServer:@[image] toKb:100 success:^(NSArray *urlArr) {
                    NSDictionary * dic = urlArr[0];
                    weakSelf.bank_card_back_photoUrl = dic[@"url"];
                    weakSelf.bank_card_back_photo.image = image;

                    
                } faild:^(id error) {
                    
                }];
            };
            [self presentViewController:VC animated:NO completion:nil];
            
            
            break;
        }
            
        default:{
            
            break;
            
        }
    }
    
    
}

#pragma mark - 选择银行卡
- (IBAction)BankNameAction:(UIButton *)sender {
    [self.view endEditing:YES];
    //Push 跳转
//    DWBankViewController * VC = [[DWBankViewController alloc]initWithNibName:@"DWBankViewController" bundle:nil];
//    [self.navigationController  pushViewController:VC animated:YES];

}
#pragma mark - 发送验证码
- (IBAction)VerificationCodeAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([RegularTool checkTelNumber:self.bind_mobile.text]) {
        [DWAlertTool VerificationCodeBtn:sender];
        [HTTPTool requestVerifyCodeWithParm:@{@"mobile":self.bind_mobile.text,@"type":@"1"} active:YES success:^(BaseResponse * _Nullable baseRes) {
        } faild:^(NSError * _Nullable error) {
        }];
    }else{
        [DWAlertTool showToast:@"手机号码输入有误"];
    }
}
#pragma mark - 提交
- (IBAction)submitBtn:(SubmitBtn *)sender {
    if ([self IF]) {
        CardModel *model =[CardModel new];
        model.bank_card_photo=_bank_card_photoUrl ;
        model.bank_card_back_photo=_bank_card_back_photoUrl ;
        model. account_name = self.account_name.text;
        model.bank_card_no= self.bank_card_no.text;
        model.bank_name = self.bank_name.text;
        model.bind_mobile= self.bind_mobile.text ;
        model.verify_code = self.verify_code.text;
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask * task =  [HTTPTool requestBankAddDebitCardWithParm:model active:NO success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode==1) {
                //请求个人信息
                [weakSelf requestUserInfo];
            }
        } faild:^(NSError * _Nullable error) {
        }];
        if (task) {
            [self.sessionArray addObject:task];
        }
    
    }
}
#pragma mark - 请求个人信息
-(void)requestUserInfo{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestUserInfoWithParm:@{} active:NO success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            //返回
            [weakSelf.navigationController popViewControllerAnimated:YES] ;
        }
    } faild:^(NSError * _Nullable error) {
        
    }];
    if (task) {
        [self.sessionArray addObject:task];
    }
}

#pragma mark - 判断条件
-(BOOL)IF{
    [self.view endEditing:YES];
    BOOL  Y = YES;
        if (self.bank_card_photoUrl.length==0) {
            [DWAlertTool showToast:@"请选择借记卡正面照片"];
            return NO;
        }
        if (self.bank_card_back_photoUrl.length==0) {
            [DWAlertTool showToast:@"请选择借记卡背面照片"];
            return NO;
        }
    
    if (self.account_name.text.length==0) {
        [DWAlertTool showToast:@"请输入真实姓名"];
        return NO;
    }
    
    if (![RegularTool checkBankNumber:_bank_card_no.text]) {
        [DWAlertTool showToast:@"借记卡号输入有误"];
        return NO;
    }
    if (self.bank_name.text.length==0) {
        [DWAlertTool showToast:@"请选择发卡银行"];
        return NO;
    }
    
    if (![RegularTool checkTelNumber:self.bind_mobile.text]) {
        [DWAlertTool showToast:@"手机号码输入有误"];
        return NO;
    }
    if (self.verify_code.text.length==0) {
        [DWAlertTool showToast:@"请输入验证码"];
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

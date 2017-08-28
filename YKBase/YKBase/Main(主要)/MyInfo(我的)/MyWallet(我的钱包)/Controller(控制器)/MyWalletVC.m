//
//  MyWalletVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "MyWalletVC.h"
#import "ChooseDebitCardVC.h"

@interface MyWalletVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *OneView;
@property (weak, nonatomic) IBOutlet UIView *TwoView;
@end

@implementation MyWalletVC

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
    _bottomView.backgroundColor = [UIColor colorWithHexString:kBlueColor];
    [self.OneView.layer setLaberMasksToBounds:YES cornerRadius:cutRadius*SizeScale borderWidth:borderW*SizeScale borderColor:[UIColor colorWithHexString:kLineColor]];
    [self.TwoView.layer setLaberMasksToBounds:YES cornerRadius:cutRadius*SizeScale borderWidth:borderW*SizeScale borderColor:[UIColor colorWithHexString:kLineColor]];
    self.title = @"我的钱包";
}
#pragma mark - 关于数据
-(void)SET_DATA{
    YKHTTPSession * helper = [YKHTTPSession shareSession];
    self.amount.text =helper.userinfo.amount;
    self.frozen_amount.text = helper.userinfo.frozen_amount;
}
#pragma mark - 选择储蓄卡
- (IBAction)ChooseDebitCardAction:(UIButton *)sender {
    [self.view endEditing:YES];
    //跳转
    ChooseDebitCardVC * VC =  GetVC(ChooseDebitCardVC);
    PushVC(VC);
}
#pragma mark - 确认支付
- (IBAction)BtnAction:(SubmitBtn *)sender {

    if ([self IF]) {
//        Userinfo *model =[Userinfo new];
//        model.money = self.money.text;
//        __weak typeof(self) weakSelf = self;
//        NSURLSessionDataTask * task =  [HTTPTool requestWithdrawWithParm:model active:NO success:^(BaseResponse * _Nullable baseRes) {
//            if (baseRes.resultCode==1) {
//                [weakSelf  requestUserInfo];
//            }
//        } faild:^(NSError * _Nullable error) {
//            
//        }];
//        if (task) {
//            [self.sessionArray addObject:task];
//        }
    }
}
#pragma mark - 请求个人信息
-(void)requestUserInfo{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestUserInfoWithParm:@{} active:YES success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            [DWAlertTool showToast:@"提现成功"];
            YKHTTPSession * helper = [YKHTTPSession shareSession];
            weakSelf.amount.text =helper.userinfo.amount;
            weakSelf.frozen_amount.text = helper.userinfo.frozen_amount;
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
    if (self.money.text.length==0) {
        [DWAlertTool showToast:@"金额输入有误"];
        return NO;
    }
    if ([self.money.text floatValue] > [self.amount.text floatValue]) {
        [DWAlertTool showToast:@"账号余额不足"];
        return NO;
    }
    if (self.bankName.text .length==0) {
        [DWAlertTool showToast:@"请选择到款储蓄卡"];
        return NO;
    }
    return Y;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField ==self.money) {
        NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return  [RegularTool checkAmount:toString];
    }
    return YES;
}
//只要拖拽就会触发(scrollView 的偏移量发生改变)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.view.backgroundColor = [UIColor colorWithHexString:scrollView.contentOffset.y>0?kViewBackgroundColor:kBlueColor];
}
#pragma mark - dealloc
- (void)dealloc
{
    NSLog(@"%@销毁了", [self class]);
}
@end

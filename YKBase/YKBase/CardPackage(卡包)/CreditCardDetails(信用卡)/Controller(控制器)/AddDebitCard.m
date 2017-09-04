//
//  AddDebitCard.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/10.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "AddDebitCard.h"
#import "SigningVC.h"
#import "BankCardListVC.h"
@interface AddDebitCard ()
@property(nonatomic,strong)NSString * bank_card_photoUrl;
@property(nonatomic,strong)NSString * bank_card_back_photoUrl;

@end
@implementation AddDebitCard
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
    self.title = @"添加信用卡";
}
#pragma mark - 关于数据
-(void)SET_DATA{
    YKHTTPSession * helper = [YKHTTPSession shareSession];
    self.account_name.text = helper.userinfo.real_name;
}
#pragma mark - 选择图片
- (IBAction)bankAction:(UIButton *)sender {
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    ImageChooseVC* VC = [[ImageChooseVC alloc]initWithNibName:@"ImageChooseVC" bundle:nil];
    VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    VC.imageType = EditedImage;
    VC.zoom= 0.6;
    VC.ImageChooseVCBlock =^(UIImage *image){
        NSLog(@"%@",image);
        [[YKHTTPSession shareSession]UPImageToServer:@[image] toKb:100 success:^(NSArray *urlArr) {
            NSDictionary * dic = urlArr[0];
            switch (sender.tag) {
                case 401:
                {
                    weakSelf.bank_card_photoUrl = dic[@"url"];
                    weakSelf.bank_card_photo.image = image;
                    break;
                }
                case 402:
                {
                    weakSelf.bank_card_back_photoUrl = dic[@"url"];
                    weakSelf.bank_card_back_photo.image = image;
                    break;
                }
                default:{
                    break;
                }
            }
        } faild:^(id error) {
            
        }];
    };
    [self presentViewController:VC animated:NO completion:nil];
}

#pragma mark - 选择银行卡
- (IBAction)BankNameAction:(UIButton *)sender {
    [self.view endEditing:YES];
    //跳转
    BankCardListVC * VC =  GetVC(BankCardListVC);
    __weak typeof(self) weakSelf = self;
      VC.bank_name = self.bank_name.text;
    VC.BankCardListVCBlock =^(NSString * bankName){
        weakSelf.bank_name.text = bankName;
    };
    PushVC(VC);
}

#pragma mark - 日期选择
- (IBAction)DataAction:(PublicBtn *)sender {
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    switch (sender.tag) {
        case 301:
        {
            MCDatePickerView *YYMMView= [[MCDatePickerView alloc] initWithFrame:CGRectZero type:XMGStyleTypeYearAndMonth MCDateSuccessBack:^(NSString *resultstr) {
                NSLog(@"年年---%@",resultstr);
                weakSelf.valid_thru.text = resultstr;
            }];
            [YYMMView show];
            break;
        }
        case 302:
        {
            //账单日
            MCDatePickerView *dayView = [[MCDatePickerView alloc] initWithFrame:CGRectZero type:XMGStyleTypeDay MCDateSuccessBack:^(NSString *resultstr) {
                weakSelf.state_date.text = resultstr;
                NSLog(@"天天---%@",resultstr);
            }];
            [dayView show];
            break;
        }
        case 303:
        {
            //还款日
            MCDatePickerView *dayView = [[MCDatePickerView alloc] initWithFrame:CGRectZero type:XMGStyleTypeDay MCDateSuccessBack:^(NSString *resultstr) {
                NSLog(@"天天---%@",resultstr);
                weakSelf.repay_date.text = resultstr;
            }];
            [dayView show];
            break;
        }
        default:{
            break;
        }
    }
}
#pragma mark - 发送验证码
- (IBAction)VerificationCodeAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if (![RegularTool checkBankNumber:_bank_card_no.text]) {
        [DWAlertTool showToast:@"信用卡号输入有误"];
        return ;
    }
    if (![RegularTool checkTelNumber:self.bind_mobile.text]) {
        [DWAlertTool showToast:@"手机号码输入有误"];
        return;
    }
    [DWAlertTool VerificationCodeBtn:sender];
    [HTTPTool requestQuickSmsWithParm:@{@"bind_mobile":self.bind_mobile.text,@"bank_card_no":self.bank_card_no.text,@"account_name":self.account_name.text} active:YES success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            [DWAlertTool showToast:@"验证码发送成功"];
        }else{
            
        }
        
    } faild:^(NSError * _Nullable error) {
    }];
}
#pragma mark - 提交
- (IBAction)submitBtn:(SubmitBtn *)sender {
    if ([self IF]) {
        CardModel *model =[CardModel new];
        model.bank_card_photo=_bank_card_photoUrl ;
        model.bank_card_back_photo=_bank_card_back_photoUrl ;
        model.bank_card_no= self.bank_card_no.text;
        model.bank_name = self.bank_name.text;
        model.credit_line = self.credit_line.text;
        NSString *valid_thru = [self.valid_thru.text stringByReplacingOccurrencesOfString:@"/" withString:@""];
        model.valid_thru= valid_thru ;
        model.cvn2 = self.cvn2.text;
        NSString *state_date = [self.state_date.text stringByReplacingOccurrencesOfString:@"日" withString:@""];
        model.state_date = state_date;
        NSString *repay_date = [self.repay_date.text stringByReplacingOccurrencesOfString:@"日" withString:@""];
        model.repay_date = repay_date;
        model.bind_mobile = self.bind_mobile.text;
        model.verify_code = self.verify_code.text;
        model.account_name = self.account_name.text;
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask * task =  [HTTPTool requestAddCreditCardWithParm:model active:NO success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode==1) {
                //跳转
                SigningVC * VC =  GetVC(SigningVC);
                NSDictionary * dic = baseRes.data;
                NSString * op_err_msg = dic[@"op_err_msg"];
                if ([dic[@"op_ret_code"] isEqualToString:@"000"]) {
                    VC.form_data = dic[@"form_data"];
                    VC.SigningVCBlock = ^(){
                        weakSelf.AddDebitCardVCBlock();
                        //返回
                        [weakSelf.navigationController popViewControllerAnimated:YES] ;
                    };
                    PushVC(VC);
                }else{
                    weakSelf.view.userInteractionEnabled =YES;
                    if (op_err_msg) {
                        [DWAlertTool showToast:op_err_msg];
                    }
                }
                
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
    if (self.bank_card_photoUrl.length==0) {
        [DWAlertTool showToast:@"请选择信用卡正面照片"];
        return NO;
    }
    if (self.bank_card_back_photoUrl.length==0) {
        [DWAlertTool showToast:@"请选择信用卡背面照片"];
        return NO;
    }
    if (![RegularTool checkBankNumber:_bank_card_no.text]) {
        [DWAlertTool showToast:@"信用卡号输入有误"];
        return NO;
    }
    if (self.bank_name.text.length==0) {
        [DWAlertTool showToast:@"请选择发卡银行"];
        return NO;
    }
    if (self.credit_line.text.length==0) {
        [DWAlertTool showToast:@"请输入信用额度"];
        return NO;
    }
    if (self.valid_thru.text.length==0) {
        [DWAlertTool showToast:@"请选择有效期"];
        return NO;
    }
    if (self.cvn2.text.length==0) {
        [DWAlertTool showToast:@"请输入CVN2"];
        return NO;
    }
    if (self.state_date.text.length==0) {
        [DWAlertTool showToast:@"请选择账单日"];
        return NO;
    }
    if (self.repay_date.text.length==0) {
        [DWAlertTool showToast:@"请选择还款日"];
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
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField ==self.credit_line) {
        NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return  [RegularTool checkAmount:toString];
    }
    if (textField ==self.cvn2) {
        NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return  [RegularTool checkNumber3:toString];
    }
    return YES;
}

#pragma mark - dealloc
- (void)dealloc
{
    NSLog(@"%@销毁了", [self class]);
}

@end

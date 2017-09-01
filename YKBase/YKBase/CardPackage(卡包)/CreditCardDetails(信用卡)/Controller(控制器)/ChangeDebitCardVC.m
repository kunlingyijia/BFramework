//
//  ChangeDebitCardVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/11.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "ChangeDebitCardVC.h"

@interface ChangeDebitCardVC ()

@end

@implementation ChangeDebitCardVC

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
    self.title= @"修改信用卡";
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    [self.bank_card_photo SD_WebimageUrlStr:self.cardModel.bank_card_photo placeholderImage:nil];
    [self.bank_card_back_photo SD_WebimageUrlStr:self.cardModel.bank_card_back_photo placeholderImage:nil];
    self.account_name.text = self.cardModel.account_name;
    self.bank_card_no.text = self.cardModel.bank_card_no;
    self.bank_name.text = self.cardModel.bank_name;
    self.valid_thru.text = self.cardModel.valid_thru;
    if (self.cardModel.valid_thru.length==4) {
        NSMutableString * valid_thru = [[NSMutableString alloc] initWithString :self.cardModel.valid_thru];
        [valid_thru insertString:@"/"atIndex:2];
        self.valid_thru.text = valid_thru;
    }else{
        self.valid_thru.text = self.cardModel.valid_thru;
    }
    self.cvn2.text = self.cardModel.cvn2;
    self.credit_line.text = self.cardModel.credit_line;
    self.state_date.text =[NSString stringWithFormat:@"%@日", self.cardModel.state_date];
    self.repay_date.text =[NSString stringWithFormat:@"%@日", self.cardModel.repay_date] ;
    self.bind_mobile.text = self.cardModel.bind_mobile;
}

#pragma mark - 日期选择
- (IBAction)DataAction:(PublicBtn *)sender {
    __weak typeof(self) weakSelf = self;
    [self.view endEditing:YES];
    switch (sender.tag) {
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

#pragma mark - 修改
- (IBAction)submitBtn:(SubmitBtn *)sender {
    if ([self IF]) {
        self.cardModel.credit_line = self.credit_line.text;
        NSString *state_date = [self.state_date.text stringByReplacingOccurrencesOfString:@"日" withString:@""];
        self.cardModel.state_date = state_date;
        NSString *repay_date = [self.repay_date.text stringByReplacingOccurrencesOfString:@"日" withString:@""];
        self.cardModel.repay_date = repay_date;
        self.ChangeDebitCardVCBlock();
        __weak typeof(self) weakSelf = self;
        // 在主线程中延迟执行某动作，不会卡主主线程，不影响后面的东做执行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(backTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [YKNotification postNotificationName:@"添加银行卡" object:nil userInfo:nil];
            //返回
            [weakSelf.navigationController popViewControllerAnimated:YES] ;
        });
    }
}
#pragma mark - 判断条件
-(BOOL)IF{
    [self.view endEditing:YES];
    BOOL  Y = YES;
    if (self.credit_line.text.length==0) {
        [DWAlertTool showToast:@"信用额度输入有误"];
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
    return YES;
    
}

#pragma mark - dealloc
- (void)dealloc
{
    
    NSLog(@"%@销毁了", [self class]);
}
@end

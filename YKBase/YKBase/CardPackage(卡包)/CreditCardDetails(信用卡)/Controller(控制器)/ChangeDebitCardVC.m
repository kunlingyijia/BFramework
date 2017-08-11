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
    
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
    
    
}



#pragma mark - 日期选择
- (IBAction)DataAction:(PublicBtn *)sender {
    __weak typeof(self) weakSelf = self;
    
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
        
    }
    
    
}

#pragma mark - 判断条件
-(BOOL)IF{
    [self.view endEditing:YES];
    BOOL  Y = YES;
    if (self.credit_line.text.length==0) {
        [DWAlertTool showToast:@"请输入信用额度"];
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

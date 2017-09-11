//
//  UpdatePasswordVC.m
//  ManagementOfMoney
//
//  Created by 席亚坤 on 17/7/20.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "UpdatePasswordVC.h"

@interface UpdatePasswordVC ()

@end
@implementation UpdatePasswordVC

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
    self.title = @"修改密码";
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
}
#pragma - 提交
- (IBAction)submitBtnAction:(UIButton *)sender {
    if ([self IF]) {
        
    }
}
#pragma mark - 判断条件
-(BOOL)IF{
    [self.view endEditing:YES];
    BOOL  Y = YES;

    return Y;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return  [RegularTool checkAmount:toString];

}

@end

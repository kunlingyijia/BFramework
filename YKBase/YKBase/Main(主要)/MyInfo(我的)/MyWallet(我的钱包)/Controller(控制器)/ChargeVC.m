//
//  ChargeVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/29.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "ChargeVC.h"
#import "SigningVC.h"
@interface ChargeVC ()
@property (weak, nonatomic) IBOutlet SegmentedView *segmented;
@property (nonatomic,strong) NSString * type;
@end
@implementation ChargeVC
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
    self.title = @"快速充值";
    [self.segmented titleArr:[@[@"信用卡",@"借记卡"]mutableCopy]];
    __weak typeof(self) weakSelf = self;
    self.segmented.SegmentedViewBlock = ^(NSInteger tag){
        [weakSelf.view endEditing:YES];
        
        if (tag==0) {
            self.type = @"2";
        }
        if (tag==1) {
            self.type = @"1";
        }
    };
}
#pragma mark - 关于数据
-(void)SET_DATA{
    self.type = @"2";
}
#pragma mark - 立即支付
- (IBAction)submitAction:(SubmitBtn *)sender {
    if ([self IF]) {
        __weak typeof(self) weakSelf = self;
        CardModel * model= [CardModel new];
        model.amount = self.amount.text;
        model.bank_card_no = self.bank_card_no.text;
        model.type = self.type;
        NSURLSessionDataTask * task =  [HTTPTool  requestQuickRechargeWithParm:model active:NO success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode==1) {
                SigningVC * VC =  GetVC(SigningVC);
                NSDictionary * dic = baseRes.data;
                    VC.form_data = dic[@"web"];
                    VC.SigningVCBlock = ^(){
                        weakSelf.ChargeVCBlock();
                        //返回
                        [weakSelf.navigationController popViewControllerAnimated:YES] ;
                    };
                    PushVC(VC);
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
    if ([self.amount.text floatValue]<50) {
        [DWAlertTool showToast:@"充值金额不小于50"];
        return NO;
    }
    if ([self.amount.text floatValue]>20000) {
        [DWAlertTool showToast:@"充值金额不大于20000"];
        return NO;
    }

    if (![RegularTool checkBankNumber:_bank_card_no.text]) {
        [DWAlertTool showToast:@"银行卡号输入有误"];
        return NO;
    }
    return Y;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField ==self.amount) {
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

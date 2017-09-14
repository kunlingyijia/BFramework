//
//  MakePlanDetailtsVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/17.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "MakePlanDetailtsVC.h"
#import "PlanDetailsVC.h"
#import "PayPlanVC.h"
#import "DebitCardDetailsVC.h"
@interface MakePlanDetailtsVC ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation MakePlanDetailtsVC
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
    self.title = @"制定计划";
    self.bottomView.backgroundColor = [UIColor colorWithHexString:kBlueColor];
}
#pragma mark - 关于数据
-(void)SET_DATA{
    //控件赋值
    [self ControlsAssignment];
}
#pragma mark - 控件赋值
-(void)ControlsAssignment{
    self.BankImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.cardModel.bank_name]];
    NSString *bank_card_no ;
    if(self.cardModel.bank_card_no.length>=4){
        bank_card_no =
        [self.cardModel.bank_card_no substringFromIndex:self.cardModel.bank_card_no.length-4];
    }else{
        bank_card_no =
        self.cardModel.bank_card_no;
    }
    self.bank_name.text = [NSString stringWithFormat:@"%@(%@)",self.cardModel.bank_name,bank_card_no];
    self.credit_line.text = self.cardModel.credit_line;
    self.state_date.text =[NSString stringWithFormat:@"%@日", self.cardModel.state_date];
    self.repay_date.text =[NSString stringWithFormat:@"%@日", self.cardModel.repay_date] ;
    self.plan_no.text = self.planModel.plan_no;
    self.total_money.text = self.planModel.total_money;
    self.beginAndend.text =[NSString stringWithFormat:@"%@~%@", [self.planModel.begin_time timeStampString],[self.planModel.end_time timeStampString]];
    self.bond.text = self.planModel.bond;
    self.fee.text = self.planModel.fee;
    self.payment_money.text = self.planModel.payment_money;
}
#pragma mark - 提交
- (IBAction)submitAction:(SubmitBtn *)sender {
    if ([self IF]) {
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask * task =  [HTTPTool requestSubmitPlanWithParm:self.planModel active:NO success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode==1) {
                PayPlanVC *VC = GetVC(PayPlanVC);
                VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
                VC.cardModel = weakSelf.planModel;
                //type 1 支付 2 未支付
                VC.PayPlanVCBlock =^(NSString * type){
                    for (BaseViewController * tempVC in weakSelf.navigationController.viewControllers) {
                        if ([tempVC isKindOfClass:[DebitCardDetailsVC class]]) {
                            [weakSelf.navigationController popToViewController:tempVC animated:YES];
                        }
                    }
                };
                PresentVC(VC);
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
    BOOL Y = YES;
    return Y;
}
#pragma mark - 预览计划
- (IBAction)previewPlan:(SubmitBtn *)sender {
    //跳转
    PlanDetailsVC * VC =  GetVC(PlanDetailsVC);
    VC.cardModel = self.planModel;
    PushVC(VC);
}
#pragma mark - dealloc
- (void)dealloc
{
    NSLog(@"%@销毁了", [self class]);
}
@end


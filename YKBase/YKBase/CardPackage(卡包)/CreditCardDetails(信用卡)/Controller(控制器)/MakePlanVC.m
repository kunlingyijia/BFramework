//
//  MakePlanVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/17.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "MakePlanVC.h"
#import "MakePlanDetailtsVC.h"
@interface MakePlanVC ()<HZQDatePickerViewDelegate> {
    HZQDatePickerView *_pikerView;
}
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *TwoView;
@property (weak, nonatomic) IBOutlet UIView *ThreeView;
@property (weak, nonatomic) IBOutlet UIView *FourView;
@property(nonatomic,strong) NSString * feeStr;
@end
@implementation MakePlanVC
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
    self.title = self.cardModel.bank_name;
    self.bottomView.backgroundColor = [UIColor colorWithHexString:kBlueColor];
    [self.oneView.layer setLaberMasksToBounds:YES cornerRadius:cutRadius*SizeScale borderWidth:borderW*SizeScale borderColor:[UIColor colorWithHexString:kLineColor]];
    [self.TwoView.layer setLaberMasksToBounds:YES cornerRadius:cutRadius*SizeScale borderWidth:borderW*SizeScale borderColor:[UIColor colorWithHexString:kLineColor]];
    [self.ThreeView.layer setLaberMasksToBounds:YES cornerRadius:cutRadius*SizeScale borderWidth:borderW*SizeScale borderColor:[UIColor colorWithHexString:kLineColor]];
    [self.FourView.layer setLaberMasksToBounds:YES cornerRadius:cutRadius*SizeScale borderWidth:borderW*SizeScale borderColor:[UIColor colorWithHexString:kLineColor]];
    [self.total_money addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
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
}
-(void)valueChange:(DarkGreyTF*)sender{
    self.bond.text = @"";
    self.fee.text =@"手续费: ";
    self.feeStr = @"";
}
#pragma mark - 计算保证金
- (IBAction)calculateAction:(SubmitBtn *)sender {
    [self.view endEditing:YES];
    if ( [self CalculateIF]) {
        CardModel *model =[CardModel new];
        model.total_money = self.total_money.text;
        model.bank_id = self.cardModel.bank_id;
        model.begin_time = self.begin_time.text;
        model.end_time = self.end_time.text;
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask * task =  [HTTPTool requestCalculateFeeWithParm:model active:YES success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode==1) {
                CardModel * model= [CardModel yy_modelWithJSON:baseRes.data];
                weakSelf.bond.text = model.bond;
                weakSelf.fee.text =[NSString stringWithFormat:@"手续费: %@",  model.fee];
                weakSelf.feeStr = model.fee;
            }
        } faild:^(NSError * _Nullable error) {
        }];
        if (task) {
            [self.sessionArray addObject:task];
        }
    }
}
#pragma mark - 判断条件
-(BOOL)CalculateIF{
    [self.view endEditing:YES];
    BOOL  Y = YES;
    if ([self.total_money.text floatValue] > [self.credit_line.text floatValue]||self.total_money.text.length ==0) {
        [DWAlertTool showToast:@"还款金额输入有误"];
        return NO;
    }
    if (self.begin_time.text.length ==0) {
        [DWAlertTool showToast:@"请选择开始时间"];
        return NO;
    }
    if (self.end_time.text.length ==0) {
        [DWAlertTool showToast:@"请选择结束时间"];
        return NO;
    }
    if ([ self.end_time.text  compare: self.begin_time.text]==NSOrderedAscending) {
        [DWAlertTool showToast:@"结束时间必须大于开始时间"];
        return NO;
    }
    return Y;
}

#pragma mark - 选择时间
- (IBAction)timeAction:(UIButton *)sender {
    [self.view endEditing:YES];
    _pikerView = [HZQDatePickerView instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, 0, Width , Height + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    if (sender.tag==301) {
        _pikerView.type = DateTypeOfStart;
    }
    if (sender.tag==302) {
        _pikerView.type = DateTypeOfEnd;
    }
    //今天开始往后的日期
    [_pikerView.datePickerView setMinimumDate:[NSDate date]];
    //在今天之前的日期
    //[_pikerView.datePickerView setMaximumDate:[NSDate date]];
    [self.view addSubview:_pikerView];
}
- (void)getSelectDate:(NSString *)date type:(DateType)type {
    switch (type) {
        case DateTypeOfStart:{
            self.begin_time.text  = date;
            break;
        }
        case DateTypeOfEnd:{
            self.end_time.text  = date;
            break;
        }
        default:
            break;
    }
}
#pragma mark - 提交
- (IBAction)submitAction:(SubmitBtn *)sender {
    if ([self IF]) {
        CardModel *model =[CardModel new];
        model.total_money = self.total_money.text;
        model.bank_id = self.cardModel.bank_id;
        model.bond = self.bond.text;
        model.begin_time = self.begin_time.text;
        model.end_time = self.end_time.text;
        model.fee = self.feeStr;
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask * task =  [HTTPTool requestCreatePlanWithParm:model active:NO success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode==1) {
                NSDictionary * dic =baseRes.data;
                CardModel * model= [CardModel yy_modelWithJSON:baseRes.data];
                model.repayModel = dic[@"repay"];
                model.consumeModel = dic[@"consume"];
                //跳转
                MakePlanDetailtsVC * VC =  GetVC(MakePlanDetailtsVC);
                VC.cardModel = weakSelf.cardModel;
                VC.planModel = model;
                [weakSelf.navigationController pushViewController:VC animated:YES];
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
    if (self.total_money.text.length ==0) {
        [DWAlertTool showToast:@"还款金额输入有误"];
        return NO;
    }
    if (self.begin_time.text.length ==0) {
        [DWAlertTool showToast:@"请选择开始时间"];
        return NO;
    }
    if (self.end_time.text.length ==0) {
        [DWAlertTool showToast:@"请选择结束时间"];
        return NO;
    }
    if ([self.end_time.text compare:self.begin_time.text]==NSOrderedAscending) {
        [DWAlertTool showToast:@"结束时间必须大于开始时间"];
        return NO;
    }
    if (self.bond.text.length ==0) {
        [DWAlertTool showToast:@"保证金输入有误"];
        return NO;
    }
    if (self.bond.text.length ==0) {
        [DWAlertTool showToast:@"保证金输入有误"];
        return NO;
    }
    if (self.feeStr.length ==0) {
        [DWAlertTool showToast:@"请计算保证金"];
        return NO;
    }
    return Y;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField ==self.total_money) {
        NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return  [RegularTool checkAmount:toString];
    }
    if (textField ==self.bond) {
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

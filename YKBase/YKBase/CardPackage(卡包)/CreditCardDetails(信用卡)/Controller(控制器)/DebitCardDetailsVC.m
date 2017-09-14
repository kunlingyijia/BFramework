//
//  DebitCardDetailsVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/10.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "DebitCardDetailsVC.h"
#import "BillVC.h"
#import "ChangeDebitCardVC.h"
#import "MakePlanVC.h"
#import "TopUpSingleVC.h"
#import "PlanListVC.h"
#import "TopUpSingleVC.h"
#import "PlanRunWaterVC.h"
@interface DebitCardDetailsVC ()
@property (weak, nonatomic) IBOutlet CutView *bottomView;
@property (nonatomic, strong) CardModel *model ;
@end
@implementation DebitCardDetailsVC
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
}
#pragma mark - 关于数据
-(void)SET_DATA{
    //控件赋值
    [self ControlsAssignment];
    [self requestAction];
}
#pragma mark - 网络请求
-(void)requestAction{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestBankCardInfoWithParm:self.cardModel active:YES success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode==1) {
            weakSelf.cardModel = [CardModel yy_modelWithJSON:baseRes.data];
            //控件赋值
            [weakSelf ControlsAssignment];
        }
    } faild:^(NSError * _Nullable error) {
    }];
    if (task) {
        [self.sessionArray addObject:task];
    }
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
#pragma mark - 点击事件
- (IBAction)BtnAction:(PublicBtn *)sender {
    __weak typeof(self) weakSelf = self;
    switch (sender.tag-100) {
        case 1:
        {
            //查看流水
            PlanRunWaterVC * VC =  GetVC(PlanRunWaterVC);
            VC.cardModel = self.cardModel;
            PushVC(VC);
            break;
        }
        case 2:
        {
            //查看计划
            PlanListVC * VC =  GetVC(PlanListVC);
            VC.cardModel = self.cardModel;
            PushVC(VC);
            break;
        }
        case 3:
        {
            //定制计划
            MakePlanVC * VC =  GetVC(MakePlanVC);
            VC.cardModel = self.cardModel;
            PushVC(VC);
            break;
        }
        case 4:
        {
            //卡片充值
            TopUpSingleVC * VC =  GetVC(TopUpSingleVC);
            VC.cardModel =self.cardModel;
            VC.TopUpSingleVCBlock =^(){
                //我的账单
                BillVC * VC =  GetVC(BillVC);
                [VC showBackBtn];
                VC.ISLevel = YES;
                PushVC(VC);
                //weakSelf.tabBarController.selectedIndex = 2;
            };
            PushVC(VC);
            break;
        }
        case 5:
        {
            //修改资料
            ChangeDebitCardVC * VC =  GetVC(ChangeDebitCardVC);
            VC.cardModel = self.cardModel;
            __weak typeof(self) weakSelf = self;
            VC.ChangeDebitCardVCBlock =^(){
                [weakSelf requestAction];
            };
            PushVC(VC);
            break;
        }
        case 6:
        {
            [DWAlertTool alertWithTitle:@"是否解绑?" message:nil OKWithTitle:@"确定" CancelWithTitle:@"取消" withOKDefault:^(UIAlertAction *defaultaction) {
                //卡片解绑
                [weakSelf requestDeleteCardWithParm];
            } withCancel:^(UIAlertAction *cancelaction) {
            }];
            break;
        }
        default:{
            break;
        }
    }
}
#pragma mark -卡片解绑
-(void)requestDeleteCardWithParm{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestDeleteCardWithParm:self.cardModel active:NO success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode==1) {
            [weakSelf requestUserInfo];
        }
    } faild:^(NSError * _Nullable error) {
    }];
    if (task) {
        [self.sessionArray addObject:task];
    }
}
#pragma mark - 请求个人信息
-(void)requestUserInfo{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestUserInfoWithParm:@{} active:NO success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } faild:^(NSError * _Nullable error) {
    }];
    if (task) {
        [self.sessionArray addObject:task];
    }
}
#pragma mark - dealloc
- (void)dealloc
{
    NSLog(@"%@销毁了", [self class]);
}

@end

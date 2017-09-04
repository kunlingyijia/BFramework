//
//  PayPlanVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/9/2.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "PayPlanVC.h"
#import "PayPlanOneCell.h"
@interface PayPlanVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
///数据
@property (nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation PayPlanVC
- (void)viewDidLoad {
    [super viewDidLoad];
    //控制器通明的关键代码
    self.modalPresentationStyle =UIModalPresentationCustom;
    //UI
    [self SET_UI];
    //数据
    [self  SET_DATA];
}
#pragma mark - 关于UI
-(void)SET_UI{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    [_tableView tableViewregisterClassArray:@[@"UITableViewCell"]];
    [_tableView tableViewregisterNibArray:@[@"PayPlanOneCell"]];
    
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self.dataArray addObject:@"账户余额"];
    // 在主线程中延迟执行某动作，不会卡主主线程，不影响后面的东做执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //控件赋值
        [self ControlsAssignment];
        
    });
}
#pragma mark - 控件赋值
-(void)ControlsAssignment{
    self.plan_no.text = self.cardModel.plan_no;
    self.bond.text = self.cardModel.bond;
    self.fee.text = self.cardModel.fee;
    self.payment_money.text = self.cardModel.payment_money;
}
#pragma tableView 代理方法
//tab分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
///tab个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//tab设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //分割线
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section>self.dataArray.count-1||self.dataArray.count==0) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        return cell;
    }else{
        
        PayPlanOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PayPlanOneCell" forIndexPath:indexPath];
        //cell赋值
        // cell.model = indexPath.section >= self.dataArray.count ? nil :self.dataArray[indexPath.section];
        YKHTTPSession * helper = [YKHTTPSession shareSession];
        cell.amount.text =[NSString stringWithFormat:@"余额: %@",  helper.userinfo.amount];
        //cell其他配置
        return cell;
    }
}
#pragma mark - Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - Cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Width * 0.2 ;
}

#pragma mark - 提交
- (IBAction)submitAction:(SubmitBtn *)sender {
    __weak typeof(self) weakSelf = self;
    if ([self IF]) {
        NSURLSessionDataTask * task =  [HTTPTool requestPayPlanWithParm:self.cardModel active:NO success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode==1) {
                [DWAlertTool showToast:@"支付成功"];
                [weakSelf requestUserInfo];
            }
        } faild:^(NSError * _Nullable error) {
        }];
        if (task) {
            [self.sessionArray addObject:task];
        }
    }
 }

- (IBAction)backAction:(UIButton *)sender {
    DismissVC;
    //type 1 支付 2 未支付
    self.PayPlanVCBlock(@"2");
}
#pragma mark - 判断条件
-(BOOL)IF{
    [self.view endEditing:YES];
    BOOL  Y = YES;
    if ([[YKHTTPSession shareSession].userinfo.amount floatValue]< [self.cardModel.payment_money floatValue]) {
        [DWAlertTool showToast:@"账户余额不足"];
        return NO;
    }
    
    
    return Y;
}
#pragma mark - 请求个人信息
-(void)requestUserInfo{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestUserInfoWithParm:@{} active:NO success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            [weakSelf dismissViewControllerAnimated:YES completion:^{}];
            //type 1 支付 2 未支付
            weakSelf.PayPlanVCBlock(@"1");
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

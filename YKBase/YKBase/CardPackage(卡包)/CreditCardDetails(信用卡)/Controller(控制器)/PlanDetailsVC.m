//
//  PlanDetailsVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/9/1.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "PlanDetailsVC.h"
#import "PlanDetailsOneCell.h"
#import "CardModel.h"
@interface PlanDetailsVC ()



@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet SegmentedView *segmented;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;



/// 1 还款记录 2 消费记录
@property(nonatomic,strong) NSString * type;
///分页参数
@property (nonatomic, assign) NSInteger pageIndex;
///数据
@property (nonatomic,strong)NSMutableArray * dataArray;
@end
@implementation PlanDetailsVC

#pragma mark -  视图将出现在屏幕之前
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma mark - 视图已在屏幕上渲染完成
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
#pragma mark -  载入完成
- (void)viewDidLoad {
    [super viewDidLoad];
    //关于UI
    [self SET_UI];
    //关于数据
    [self  SET_DATA];
}
#pragma mark - 关于UI
-(void)SET_UI{
    self.title = @"计划详情";
    [self showBackBtn];
    __weak typeof(self) weakSelf = self;
    [self.segmented titleArr:[@[@"还款记录",@"消费记录"]mutableCopy]];
    self.segmented.SegmentedViewBlock = ^(NSInteger tag){
        weakSelf.pageIndex = 1;
        weakSelf.type = tag == 0 ?  @"1":@"2";
        //tableView赋值
        [weakSelf tableViewAssignment];
    };
    [self setUpTableView];
//    self.heightConstraint.constant = 0.01;
//    [self.submitBtn removeFromSuperview];
}
#pragma mark - 控件赋值
-(void)ControlsAssignment{
    self.plan_no.text = self.cardModel.plan_no;
    self.beginAndend.text = [NSString stringWithFormat:@"%@~%@", [self.cardModel.begin_time timeStampString],[self.cardModel.end_time timeStampString]];
    self.total_money.text = self.cardModel.total_money;
    self.bond.text = self.cardModel.bond;
    self.fee.text = self.cardModel.fee;
}
#pragma mark -tableView赋值
-(void)tableViewAssignment{
    [self.dataArray removeAllObjects];
        for (NSDictionary *dic  in [self.type isEqualToString:@"1"] ? self.cardModel.repayModel :self.cardModel.consumeModel) {
            CardSubModel * model = [CardSubModel yy_modelWithJSON:dic];
            model.type =self.type;
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    
    
}
#pragma mark - 关于tableView
-(void)setUpTableView{
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    [_tableView tableViewregisterClassArray:@[@"UITableViewCell"]];
    [_tableView tableViewregisterNibArray:@[@"PlanDetailsOneCell"]];
}
#pragma mark - 关于数据
-(void)SET_DATA{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.type = @"1";
    self.pageIndex =1;
    //[self requestAction];
    //上拉刷新下拉加载
    //[self Refresh];
    [self ControlsAssignment];
    [self tableViewAssignment];
}
-(void)Refresh{
    //下拉刷新
    __weak typeof(self) weakself = self;
    [ThirdPartyTool MJRefreshView:self.tableView Header:YES Footer:NO HeaderBlock:^{
        weakself.pageIndex =1 ;
        [weakself requestAction];
    } FooterBlock:^{
        weakself.pageIndex ++ ;
        NSLog(@"%ld",(long)weakself.pageIndex);
        [weakself requestAction];
    }];
}

#pragma mark - 网络请求
-(void)requestAction{
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestBankCardListWithParm:@{@"pageIndex":@(self.pageIndex),@"pageCount":@"10",@"type":self.type} active:YES success :^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            if (weakSelf.pageIndex == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dic in baseRes.data) {
                CardModel * model = [CardModel yy_modelWithJSON:dic];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
        }else{
            weakSelf.pageIndex > 1 ? weakSelf.pageIndex -- : weakSelf.pageIndex;
        }
        [ThirdPartyTool MJRefreshEndRefreView:weakSelf.tableView];
    } faild:^(NSError * _Nullable error) {
        [ThirdPartyTool MJRefreshEndRefreView:weakSelf.tableView];
    }];
    if (task) {
        [self.sessionArray addObject:task];
    }
}
#pragma tableView 代理方法
//tab分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //分区个数
    return 1;
}
///tab个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [tableView tableViewDisplayWitimage:nil ifNecessaryForRowCount:self.dataArray.count];
    return self.dataArray.count ;
}
//tab设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //分割线
    //tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row>self.dataArray.count-1||self.dataArray.count==0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        //cell赋值
        return cell;
    }else{
        
        PlanDetailsOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PlanDetailsOneCell" forIndexPath:indexPath];
        //cell赋值
        cell.model = indexPath.row >= self.dataArray.count ? nil :self.dataArray[indexPath.row];
        //cell其他配置
        return cell;
    }
}
#pragma mark - Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self) weakSelf = self;
}
#pragma mark - Cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Width * 0.18;
}
#pragma mark - 提交
- (IBAction)submitAction:(SubmitBtn *)sender {
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestReplacePlanWithParm:self.cardModel active:YES success :^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
        
            NSDictionary * dic =baseRes.data;
            weakSelf.cardModel.repayModel = dic[@"repay"];
            weakSelf.cardModel.consumeModel = dic[@"consume"];
            [weakSelf tableViewAssignment];
        }else{
            weakSelf.pageIndex > 1 ? weakSelf.pageIndex -- : weakSelf.pageIndex;
        }
        [ThirdPartyTool MJRefreshEndRefreView:weakSelf.tableView];
        
    } faild:^(NSError * _Nullable error) {
        [ThirdPartyTool MJRefreshEndRefreView:weakSelf.tableView];
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

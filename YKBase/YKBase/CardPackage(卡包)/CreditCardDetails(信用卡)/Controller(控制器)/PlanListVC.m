//
//  PlanListVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/17.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "PlanListVC.h"
#import "PlanListOneCell.h"
#import "PlanDetailsVC.h"
@interface PlanListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
///分页参数
@property (nonatomic, assign) NSInteger pageIndex;
///数据
@property (nonatomic,strong)NSMutableArray * dataArray;
@end
@implementation PlanListVC
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
    self.title = @"计划";
    [self showBackBtn];
    [self setUpTableView];
}
#pragma mark - 关于tableView
-(void)setUpTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height-64) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = [UIView new];
    [self.view addSubview:_tableView];
    [_tableView tableViewregisterClassArray:@[@"UITableViewCell"]];
    [_tableView tableViewregisterNibArray:@[@"PlanListOneCell"]];
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"UITableViewHeaderFooterView"];
}
#pragma mark - 关于数据
-(void)SET_DATA{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.pageIndex =1;
    [self requestAction];
    //上拉刷新下拉加载
    [self Refresh];
}
-(void)Refresh{
    //下拉刷新
    __weak typeof(self) weakself = self;
    [ThirdPartyTool MJRefreshView:self.tableView Header:YES Footer:YES HeaderBlock:^{
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
    NSLog(@"%@",self.cardModel.bank_id);
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestPlanListWithParm:@{@"pageIndex":@(self.pageIndex),@"pageCount":@"10",@"bank_id":self.cardModel.bank_id} active:YES success :^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            if (weakSelf.pageIndex == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dic in baseRes.data) {
                CardModel * model = [CardModel yy_modelWithJSON:dic];
                model.repayModel = dic[@"repay"];
                model.consumeModel = dic[@"consume"];
                [weakSelf.dataArray addObject:model];
            }
            //刷新
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
    [tableView tableViewDisplayWitimage:nil ifNecessaryForRowCount:self.dataArray.count];
    ;
    return self.dataArray.count;
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
        PlanListOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PlanListOneCell" forIndexPath:indexPath];
        //cell赋值
        cell.model = indexPath.section >= self.dataArray.count ? nil :self.dataArray[indexPath.section];
        //cell其他配置
        return cell;
    }
}
#pragma mark - Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self) weakSelf = self;
    CardModel*  model = indexPath.section >= self.dataArray.count ? nil :self.dataArray[indexPath.section];
    //跳转
    PlanDetailsVC * VC =  GetVC(PlanDetailsVC);
    VC.PlanDetailsVCBlock = ^(){
        weakSelf.pageIndex = 1;
        [weakSelf requestAction];
    };
    VC.cardModel = model;
    PushVC(VC);
}
#pragma mark - Cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Width * 0.21 ;
}
#pragma mark - 分区页眉
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView" ];
    header.contentView.backgroundColor = [UIColor colorWithHexString:kViewBackgroundColor];
    return header;
}
#pragma mark - 页眉的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    CardModel*  model = indexPath.section >= self.dataArray.count ? nil :self.dataArray[indexPath.section];
    return [model.status isEqualToString:@"1"]? YES :NO ;
}
//iOS 8.0 后才有的方法
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardModel *model= self.dataArray[indexPath.section];
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [DWAlertTool alertWithTitle:@"是否删除?" message:nil OKWithTitle:@"删除" CancelWithTitle:@"取消" withOKDefault:^(UIAlertAction *defaultaction) {
            NSURLSessionDataTask * task =  [HTTPTool  requestDeletePlanWithParm:model active:YES success :^(BaseResponse * _Nullable baseRes) {
                if (baseRes.resultCode ==1) {
                    [weakSelf.dataArray removeObjectAtIndex:indexPath.section];
                    [weakSelf.tableView reloadData];
                }else{
                    [weakSelf.tableView reloadData];
                }
            } faild:^(NSError * _Nullable error) {
            }];
            if (task) {
                [weakSelf.sessionArray addObject:task];
            }
            
        } withCancel:^(UIAlertAction *cancelaction) {
        }];
    }];
    return @[delete];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - dealloc
- (void)dealloc
{
    NSLog(@"%@销毁了", [self class]);
}

@end

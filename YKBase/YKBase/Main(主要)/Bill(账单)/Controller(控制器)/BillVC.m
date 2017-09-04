//
//  BillVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/7.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BillVC.h"
#import "BillOneCell.h"
#import "BillHeaderView.h"
#import "BillSubModel.h"
#import "BillModel.h"
@interface BillVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BillHeaderView * header;
}
@property (strong, nonatomic)  UITableView *tableView;

///分页参数
@property (nonatomic, assign) NSInteger pageIndex;
///数据
@property (nonatomic,strong)NSMutableArray * dataArray;
@end
@implementation BillVC
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
    [YKNotification addObserver:self selector:@selector(refreshMyBill) name:@"刷新我的账单" object:nil];
    //关于UI
    [self SET_UI];
    //关于数据
    [self  SET_DATA];
    
}
#pragma mark - 关于UI
-(void)SET_UI{
    self.title = @"账单";
    [self setUpTableView];
    
}
#pragma mark - 关于tableView
-(void)setUpTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height-64) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    [_tableView tableViewregisterClassArray:@[@"UITableViewCell"]];
     [_tableView tableViewregisterNibArray:@[@"BillOneCell"]];
    [self.tableView registerClass:[BillHeaderView class] forHeaderFooterViewReuseIdentifier:@"BillHeaderView"];

    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.pageIndex =1;
    [self requestAction];
//    //上拉刷新下拉加载
    [self Refresh];
    [self  dataProcessing];
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
#pragma mark - 刷新我的账单
-(void)refreshMyBill{
    self.pageIndex =1 ;
    [self requestAction];
}
#pragma mark - 网络请求
-(void)requestAction{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestHomePageWithParm:@{@"pageIndex":@(self.pageIndex),@"pageCount":@"10"} active:YES success :^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            if (weakSelf.pageIndex == 1) {
                [YKDataTool saveObject:baseRes.data byFileName:@"我的账单"];
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dic in baseRes.data) {
                BillModel * model = [BillModel yy_modelWithJSON:dic];
                // [weakSelf.dataArray addObject:model];
            }
            //刷新
            [weakSelf.tableView reloadData];
        }else{
            weakSelf.pageIndex > 1 ? weakSelf.pageIndex-- : weakSelf.pageIndex;
        }
        [ThirdPartyTool MJRefreshEndRefreView:weakSelf.tableView];
        
    } faild:^(NSError * _Nullable error) {
        [ThirdPartyTool MJRefreshEndRefreView:weakSelf.tableView];
        
    }];
    if (task) {
        [self.sessionArray addObject:task];
    }
    
}
#pragma mark - 数据处理
-(void)dataProcessing{
    NSMutableArray * Info = [YKDataTool getObjectByFileName:@"我的账单"];
    if (Info.count!=0) {
        for (NSDictionary * dic in Info) {
            BillModel * model = [BillModel yy_modelWithJSON:dic];
             //[self.dataArray addObject:model];
        }
        //刷新
        [self.tableView reloadData];
    }
}
#pragma tableView 代理方法
//tab分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //分区个数
     [tableView tableViewDisplayWitimage:nil ifNecessaryForRowCount:self.dataArray.count];
    return self.dataArray.count;
}
///tab个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    BillModel *model=self.dataArray[section];
    return ((NSMutableArray*)model.billSubModel).count;
}
//tab设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //分割线
    //tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section>self.dataArray.count-1||self.dataArray.count==0) {
        return [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    }else{
    
        BillOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BillOneCell" forIndexPath:indexPath];
        //cell 赋值
         BillModel *model=self.dataArray[indexPath. section];
        cell.model = indexPath.section >= self.dataArray.count ? nil : model.billSubModel[indexPath.row];
        // cell 其他配置
        return cell;
        
    }
}
#pragma mark - 分区页眉
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //if (!header) {
    header= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BillHeaderView" ];
    
    // }
    if (header) {
         header.model = section >= self.dataArray.count ? nil : self.dataArray[section];
    }
    return header;
    
}


#pragma mark - Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
#pragma mark - 页眉的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Width*0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}
#pragma mark - Cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Width*0.16;
    
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

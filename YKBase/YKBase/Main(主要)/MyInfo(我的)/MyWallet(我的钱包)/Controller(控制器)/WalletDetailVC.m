//
//  WalletDetailVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/9/7.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "WalletDetailVC.h"

#import "BillOneCell.h"
#import "BillHeaderView.h"
#import "BillModel.h"
@interface WalletDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BillHeaderView * header;
}
@property (strong, nonatomic)  UITableView *tableView;
///分页参数
@property (nonatomic, assign) NSInteger pageIndex;
///数据
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet SegmentedView *segmented;
@property (nonatomic,strong) NSString * type;

@end
@implementation WalletDetailVC
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
    self.title = @"交易明细";
    [self.segmented titleArr:[@[@"收入",@"支出"]mutableCopy]];
    __weak typeof(self) weakSelf = self;
    self.segmented.SegmentedViewBlock = ^(NSInteger tag){
        [weakSelf.view endEditing:YES];
        if (tag==0) {
            weakSelf.type = @"1";
            weakSelf.pageIndex = 1;
            [weakSelf requestAction];
        }
        if (tag==1) {
            weakSelf.type = @"2";
            weakSelf.pageIndex = 1;
            [weakSelf requestAction];
        }
    };
    [self showBackBtn];
    [self setUpTableView];
}
#pragma mark - 关于tableView
-(void)setUpTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20+40*SizeScale, Width, Height-64-20-40*SizeScale) style:(UITableViewStylePlain)];
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
    self.type = @"1";
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
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestBillListWithParm:@{@"pageIndex":@(self.pageIndex),@"pageCount":@"10"} active:YES success :^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            if (weakSelf.pageIndex == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dic in baseRes.data) {
                BillModel * model = [BillModel yy_modelWithJSON:dic];
                [weakSelf.dataArray addObject:model];
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

#pragma tableView 代理方法
//tab分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //分区个数
    [tableView tableViewDisplayWitimage:nil ifNecessaryForRowCount:self.dataArray.count];
    return self.dataArray.count;
}
///tab个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
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
        cell.model =indexPath.section >= self.dataArray.count ? nil :self.dataArray[indexPath.section];
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
    if (section>0) {
        BillModel* beforeModel= self.dataArray[section-1];
        BillModel* afterModel= self.dataArray[section];
        if (![beforeModel.create_time isEqualToString: afterModel.create_time]) {
            return Width*0.1;
        }else{
            return 0;
        }
    }else{
        BillModel* OneModel= self.dataArray[section];
        if (OneModel) {
            return Width*0.1;
        }else{
            return 0;
        }
    }
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



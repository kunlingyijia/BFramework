//
//  TopUpVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/11.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "TopUpVC.h"
#import "CardPackageTwoCell.h"

@interface TopUpVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *OneView;
@property (weak, nonatomic) IBOutlet SegmentedView *segmented;
///分页参数
@property (nonatomic, assign) NSInteger pageIndex;
///数据
@property (nonatomic,strong)NSMutableArray * dataArray;
@end
@implementation TopUpVC
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
    self.title = @"快速充值";
    [self showBackBtn];
    [self.OneView.layer setLaberMasksToBounds:YES cornerRadius:cutRadius*SizeScale borderWidth:borderW*SizeScale borderColor:[UIColor colorWithHexString:kLineColor]];
    [self.segmented titleArr:[@[@"我的信用卡(1)",@"我的借记卡(2)"]mutableCopy]];
    __weak typeof(self) weakSelf = self;
    self.segmented.SegmentedViewBlock = ^(NSInteger tag){
        [weakSelf.view endEditing:YES];
        
        if (tag==0) {
            
        }
        if (tag==1) {
            
        }
    };
    [self setUpTableView];
    
}
#pragma mark - 关于tableView
-(void)setUpTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20+40*SizeScale+0.225*Width+10+20, Width, Height-64-20-40*SizeScale-0.225*Width-10-20-40-40*SizeScale) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    [_tableView tableViewregisterClassArray:@[@"UITableViewCell"]];
    [_tableView tableViewregisterNibArray:@[@"CardPackageTwoCell"]];
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self.dataArray addObject:@"1"];
    [self.dataArray addObject:@"1"];
    [self.dataArray addObject:@"1"];
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
    //    NSString *Token =[AuthenticationModel getLoginToken];
    //    NSMutableDictionary *dic  =[ @{@"pageIndex":@(self.pageIndex),@"pageCount":@(10)}mutableCopy];
    //    __weak typeof(self) weakself = self;
    //    if (Token.length!= 0) {
    //        /*
    //         BaseRequest *baseReq = [[BaseRequest alloc] init];
    //         baseReq.encryptionType = RequestMD5;
    //         baseReq.data =dic;
    //         [[DWHelper shareHelper] requestDataWithParm:[baseReq yy_modelToJSONString] act:@"<#act=Api/Homepage/requestHomepage#>" sign:[[baseReq.data yy_modelToJSONString] MD5Hash] requestMethod:GET PushVC:self success:^(id response) {
    //         */
    //
    //        BaseRequest *baseReq = [[BaseRequest alloc] init];
    //        baseReq.token = [AuthenticationModel getLoginToken];
    //        baseReq.encryptionType = AES;
    //        baseReq.data = [AESCrypt encrypt:[dic yy_modelToJSONString] password:[AuthenticationModel getLoginKey]];
    //        [[DWHelper shareHelper] requestDataWithParm:[baseReq yy_modelToJSONString] act:@"<#act=Api/Score/requestScoreList#>" sign:[baseReq.data MD5Hash] requestMethod:GET PushVC:self success:^(id response) {
    //            BaseResponse *baseRes = [BaseResponse yy_modelWithJSON:response];            if (weakself.pageIndex == 1) {
    //                [weakself.dataArray removeAllObjects];
    //            }
    //            if (baseRes.resultCode ==1) {
    //                NSMutableArray *arr = baseRes.data;
    //                for (NSDictionary *dicData in arr) {
    //                    <#ScoreRecordModel#> *model = [<#ScoreRecordModel#> yy_modelWithJSON:dicData];
    //                    [weakself.dataArray addObject:model];
    //                }
    //                //刷新
    //                [weakself.tableView reloadData];
    //            }else{
    //                [weakself showToast:baseRes.msg];
    //                weakself.pageIndex > 1 ? weakself.pageIndex-- : weakself.pageIndex;
    //
    //            }
    //
    //            // 进入刷新状态后会自动调用这个block
    //            [weakself.tableView.mj_header endRefreshing];
    //            [weakself.tableView.mj_footer endRefreshing];
    //        } faild:^(id error) {
    //            NSLog(@"%@", error);
    //            // 进入刷新状态后会自动调用这个block
    //            [weakself.tableView.mj_header endRefreshing];
    //            [weakself.tableView.mj_footer endRefreshing];
    //            weakself.pageIndex > 1 ? weakself.pageIndex-- : weakself.pageIndex;
    //
    //        }];
    //    }else {
    //
    //    }
    
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
    return self.dataArray.count;
}
//tab设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //分割线
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) weakSelf = self;
    if (indexPath.row>self.dataArray.count-1||self.dataArray.count==0) {
        return [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    }else{
        CardPackageTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CardPackageTwoCell" forIndexPath:indexPath];
        //cell 赋值
        // cell.model = indexPath.row >= self.dataArray.count ? nil :self.dataArray[indexPath.row];
        // cell 其他配置
        return cell;
    }
}
#pragma mark - Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - Cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Width * 0.35;
}
#pragma mark - 立即支付
- (IBAction)submitAction:(SubmitBtn *)sender {
    if ([self IF]) {
           }
}
#pragma mark - 判断条件
-(BOOL)IF{
    [self.view endEditing:YES];
    BOOL  Y = YES;
    
    return Y;
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

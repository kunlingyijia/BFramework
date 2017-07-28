//
//  HomePageVC.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/20.
//  Copyright © 2017年 bianming. All rights reserved.
//
//设置APP引导页
//[(AppDelegate *)[UIApplication sharedApplication].delegate initUserGuidePage];

#import "HomePageVC.h"
#import "AppDelegate.h"
#import "AdModel.h"
@interface HomePageVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
///分页参数
@property (nonatomic, assign) NSInteger pageIndex;
///数据
@property (nonatomic,strong)NSMutableArray * dataArray;
@end
@implementation HomePageVC
#pragma mark -  视图将出现在屏幕之前
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // [ThirdPartyTool MJRefreshBeginRefreView:self.tableView];

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
    self.title = @"首页";
    [(AppDelegate*)[UIApplication sharedApplication].delegate initUserGuidePage];
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
    [self.view addSubview:_tableView];
    [_tableView tableViewregisterClassArray:@[@"UITableViewCell"]];
   
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.pageIndex =1;
//    [self requestAction];
    //上拉刷新下拉加载
    [self Refresh];
}
-(void)Refresh{
    __weak typeof(self) weakSelf = self;
    [ThirdPartyTool MJRefreshView:self.tableView Header:YES Footer:YES HeaderBlock:^{
        weakSelf.pageIndex =1 ;
        [weakSelf requestAction];
    } FooterBlock:^{
        weakSelf.pageIndex++ ;
        [weakSelf requestAction];
    }];

    
}
#pragma mark - 网络请求
-(void)requestAction{
//    //        // 在主线程中延迟执行某动作，不会卡主主线程，不影响后面的东做执行
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [ThirdPartyTool MJRefreshEndRefreView:self.tableView];
//                
//});
    AdModel *model = [[AdModel alloc]init];
    model.region_id = 1;
    model.position = 1;
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestAdWithParm:model  active:YES success:^(BaseResponse * _Nullable baseRes) {
        //NSLog(@"%@", [baseRes yy_modelToJSONObject]);
        if (baseRes.resultCode == 1) {
        
        [ThirdPartyTool MJRefreshEndRefreView:weakSelf.tableView];

        }else {
                   }
    } faild:^(NSError * _Nonnull error) {
        [ThirdPartyTool MJRefreshEndRefreView:weakSelf.tableView];

        } ];
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
    return 15;
}
//tab设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //分割线
    //tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
}
#pragma mark - Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
#pragma mark - Cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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

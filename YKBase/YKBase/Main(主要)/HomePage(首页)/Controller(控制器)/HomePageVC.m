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
#import "TouchTool.h"
#import "HomePageOneCell.h"
#import "HomePageTwoCell.h"
#import "HomePageThreeCell.h"
#import "MessageVC.h"
#import "DebitCardDetailsVC.h"
#import "HomePageModel.h"
#import "BillVC.h"
#import "CardPackageVC.h"
#import "TopUpVC.h"
#import "JQScanViewController.h"
#import "SXHeadLine.h"
@interface HomePageVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
///分页参数
@property (nonatomic, assign) NSInteger pageIndex;
///轮播图
@property (nonatomic,strong)NSMutableArray * imageArray;
///声明消息
@property (nonatomic,strong)NSMutableArray * messageArray;
///数据
@property (nonatomic,strong)NSMutableArray * dataArray;
@end
@implementation HomePageVC
#pragma mark -  视图将出现在屏幕之前
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //更新版本
    [ThirdPartyTool updateVerison];
}
#pragma mark - 视图已在屏幕上渲染完成
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
#pragma mark -  载入完成
- (void)viewDidLoad {
    [super viewDidLoad];
    //用户信息赋值
    [YKNotification addObserver:self selector:@selector(requestAction) name:@"刷新一级界面" object:nil];
    //关于UI
    [self SET_UI];
    //关于数据
    [self  SET_DATA];
}
#pragma mark - 关于UI
-(void)SET_UI{
    [self ShowRightBtnImage:@"消息" Back:^{
        //跳转
        if ([HTTPTool isLogin]) {
            return ;
        }
        MessageVC * VC =  GetVC(MessageVC);
        PushVC(VC);
    }];
    [self showLeftBtnImage:@"扫一扫" Back:^{
        JQScanViewController *VC = [JQScanViewController new];
        VC.JQScanVCBlock = ^(JQScanResult* strResult){
            
        };
         PushVC(VC)
          }];
    self.title = @"首页";
    [(AppDelegate*)[UIApplication sharedApplication].delegate initUserGuidePage];
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
    [_tableView tableViewregisterNibArray:@[@"HomePageOneCell",@"HomePageTwoCell",@"HomePageThreeCell"]];
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    self.imageArray = [NSMutableArray arrayWithCapacity:0];
    self.messageArray = [NSMutableArray arrayWithCapacity:0];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.pageIndex =1;
    [self requestAction];
    //上拉刷新下拉加载
    [self Refresh];
}
-(void)Refresh{
      __weak typeof(self) weakSelf = self;
    [ThirdPartyTool MJRefreshView:self.tableView Header:YES Footer:NO HeaderBlock:^{
        weakSelf.pageIndex =1 ;
        [weakSelf requestAction];
    } FooterBlock:^{
        weakSelf.pageIndex++ ;
        [weakSelf requestAction];
    }];
}
#pragma mark - 网络请求
-(void)requestAction{
    [self  dataProcessing];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestHomePageWithParm:@{@"pageIndex":@(self.pageIndex),@"pageCount":@"10"} active:YES success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            if (weakSelf.pageIndex == 1) {
                [YKDataTool setValue:baseRes forkey:@"首页"];
                [weakSelf.imageArray removeAllObjects];
                [weakSelf.messageArray removeAllObjects];
                [weakSelf.dataArray removeAllObjects];
            }
           [weakSelf  dataProcessing ];
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
     NSMutableDictionary * Info = [YKDataTool objectForKey:@"首页"];
     if (Info.count!=0) {
    for (NSDictionary * dic in Info[@"ad"]) {
        HomePageModel * model = [HomePageModel yy_modelWithJSON:dic];
        [self.imageArray addObject:model];
    }
    for (NSDictionary * dic in Info[@"notice"]) {
        HomePageModel * model = [HomePageModel yy_modelWithJSON:dic];
        [self.messageArray addObject:model];
    }
    for (NSDictionary * dic in Info[@"bank_card"]) {
        HomePageModel * model = [HomePageModel yy_modelWithJSON:dic];
        [self.dataArray addObject:model];
    }
    //刷新
    [self.tableView reloadData];
   }
}
#pragma tableView 代理方法
//tab分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //分区个数
    return 2;
}
///tab个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [tableView tableViewDisplayWitimage:nil ifNecessaryForRowCount:1];
    if (section ==0) {
        return 2;
    }else{
        return 1;
    }
}
//tab设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) weakSelf = self;
        switch (indexPath.section) {
            case 0:
            {
                if (indexPath.row ==0) {
                    HomePageOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageOneCell" forIndexPath:indexPath];
                    //轮播图
                    cell.HomePageOneCellImgBlock = ^(NSInteger tag){
                        
                    };
                    //消息
                    cell.HomePageOneCellLabelBlock = ^(NSInteger tag){
                        HomePageModel * model = weakSelf.messageArray[tag];
                        NSLog(@"tag---%ld---%@",tag,model.title);
                        //跳转
                        DebitCardDetailsVC * VC =  GetVC(DebitCardDetailsVC);
                        PushVC(VC);
                    };
                    //cell 赋值
                    [cell cellGetDataWithBanner:self.imageArray];
                    //cell 赋值
                    if (self.messageArray.count>0) {
                    [cell cellGetDataWithWin:self.messageArray];
                    }
                    // cell 其他配置
                    return cell;
                }else{
                    HomePageTwoCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageTwoCell" forIndexPath:indexPath];
                    //选项点击
                    cell.HomePageTwoCellBlock = ^(NSInteger tag){
                    [weakSelf HomePageTwoCellBlockAction:tag];
                    };
                    return cell;
                }
                break;
            }
            case 1:
            {
                HomePageThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageThreeCell" forIndexPath:indexPath];
                //cell 赋值
                cell.model = indexPath.row >= self.dataArray.count ? nil :self.dataArray[indexPath.row];
                // cell 其他配置
                return cell;
                break;
            }
            default:{
                return [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
                break;
            }
        }
}
#pragma mark - 点击事件
-(void)HomePageTwoCellBlockAction:( NSInteger )tag{
    
    if (tag<4) {
        ///是否实名认证
        if ([HTTPTool isCertification]) {
            return;
        }
        switch (tag) {
            case 1:
            {
                ///我的卡包
                CardPackageVC * VC =  GetVC(CardPackageVC);
                [VC showBackBtn];
                PushVC(VC);
                
                break;
            }
            case 2:
            {
                //我的账单
                BillVC * VC =  GetVC(BillVC);
                [VC showBackBtn];
                PushVC(VC);
                break;
            }
            case 3:
            {
                //快速充值
                TopUpVC * VC =  GetVC(TopUpVC);
                PushVC(VC);
                break;
            }
            default:{
                break;
            }
        }
    }else{
        [DWAlertTool showToast:@"开发中,敬请期待..."];
    }
}

#pragma mark - Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        //跳转
        DebitCardDetailsVC * VC =  GetVC(DebitCardDetailsVC);
        //PushVC(VC);
    }
}
#pragma mark - Cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row==0) {
                return 0.40*Width +0.125*Width;
            }else{
                return 0.40*Width;
            }
               break;
        }
        case 1:
        {
            return Width *0.35;
            break;
        }
        default:{
            return 0.0;
            break;
        }
    }
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

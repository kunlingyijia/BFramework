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
// [TouchTool FingerprintUnlock:^(BOOL success) {
//     
// } Faild:^(NSError * _Nonnull error) {
//     
// }];
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
    [self ShowRightBtnImage:@"消息" Back:^{
        //跳转
        MessageVC * VC =  GetVC(MessageVC);
        PushVC(VC);
    }];
    [self showLeftBtnImage:@"扫一扫" Back:^{
        //跳转
        MessageVC * VC =  GetVC(MessageVC);
        PushVC(VC);
    }];
   
    self.title = @"首页";
    //[(AppDelegate*)[UIApplication sharedApplication].delegate initUserGuidePage];
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

    AdModel *model = [[AdModel alloc]init];
    model.region_id = 1;
    model.position = 1;
    __weak typeof(self) weakSelf = self;
//    NSURLSessionDataTask * task =  [HTTPTool  requestAdWithParm:model  active:YES success:^(BaseResponse * _Nullable baseRes) {
//        //NSLog(@"%@", [baseRes yy_modelToJSONObject]);
//        if (baseRes.resultCode == 1) {
//        
//        [ThirdPartyTool MJRefreshEndRefreView:weakSelf.tableView];
//
//        }else {
//                   }
//    } faild:^(NSError * _Nonnull error) {
//        [ThirdPartyTool MJRefreshEndRefreView:weakSelf.tableView];
//
//        } ];
//    if (task) {
//        [self.sessionArray addObject:task];
//    }
}
#pragma tableView 代理方法
//tab分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //分区个数
    return 2;
}
///tab个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [tableView tableViewDisplayWitimage:nil ifNecessaryForRowCount:self.dataArray.count];
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
                    
                    
                    
                    //cell 赋值
                    //cell.model = indexPath.row >= self.dataArray.count ? nil :self.dataArray[indexPath.row];
                    // cell 其他配置
                    return cell;

                }else{
                    HomePageTwoCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageTwoCell" forIndexPath:indexPath];
                    //选项点击
                    cell.HomePageTwoCellBlock = ^(NSInteger tag){
                        //跳转
                        MessageVC * VC =  GetVC(MessageVC);
                        PushVC(VC);
                    };
                    //cell 赋值
                    //cell.model = indexPath.row >= self.dataArray.count ? nil :self.dataArray[indexPath.row];
                    // cell 其他配置
                    return cell;

                }
                break;
            }
            case 1:
            {
                HomePageThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageThreeCell" forIndexPath:indexPath];
                //cell 赋值
                //cell.model = indexPath.row >= self.dataArray.count ? nil :self.dataArray[indexPath.row];
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
#pragma mark - Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        
        //跳转
        DebitCardDetailsVC * VC =  GetVC(DebitCardDetailsVC);
        
        PushVC(VC);
        
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







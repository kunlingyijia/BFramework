//
//  BankCardListVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/30.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BankCardListVC.h"
#import "BankCardListOneCell.h"



@interface BankCardListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

///数据
@property (nonatomic,strong)NSMutableArray * dataArray;
@end
@implementation BankCardListVC
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
    self.title = @"银行列表";
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
    [_tableView tableViewregisterNibArray:@[@"BankCardListOneCell"]];
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self.dataArray addObject:@"招商银行"];
    [self.dataArray addObject:@"中国银行"];
    [self.dataArray addObject:@"工商银行"];
    [self.dataArray addObject:@"建设银行"];
    [self.dataArray addObject:@"中信银行"];
    [self.dataArray addObject:@"农业银行"];
    [self.dataArray addObject:@"深圳发展银行"];
    [self.dataArray addObject:@"民生银行"];
    [self.dataArray addObject:@"兴业银行"];
    [self.dataArray addObject:@"光大银行"];
    [self.dataArray addObject:@"华夏银行"];
    
    
    
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
    __weak typeof(self) weakSelf = self;
    if (indexPath.row>self.dataArray.count-1||self.dataArray.count==0) {
        return [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    }else{
        BankCardListOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BankCardListOneCell" forIndexPath:indexPath];
        cell.BankImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.dataArray[indexPath.row]]];
        cell.Bank_nameLabel.text = self.dataArray[indexPath.row];
        // cell 其他配置
        return cell;
    }
    
}
#pragma mark - Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 在主线程中延迟执行某动作，不会卡主主线程，不影响后面的东做执行
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(backTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.BankCardListVCBlock(self.dataArray[indexPath.row]);
        //返回
        [weakSelf.navigationController popViewControllerAnimated:YES] ;
    });
}
#pragma mark - Cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0.125*Width;
    
    
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

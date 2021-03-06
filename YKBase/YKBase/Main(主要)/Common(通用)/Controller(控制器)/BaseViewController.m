//
//  BaseViewController.m
//  DWduifubao
//
//  Created by kkk on 16/9/8.
//  Copyright © 2016年 bianming. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+Toast.h"
#import "LoadWaitSingle.h"
@interface BaseViewController ()<UIGestureRecognizerDelegate>


@end

@implementation BaseViewController
-(NSMutableArray *)sessionArray{
    if (!_sessionArray) {
        self.sessionArray = [NSMutableArray arrayWithCapacity:1];
    }return _sessionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:kViewBackgroundColor];

}
- (void)showBackBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
//    backBtn.backgroundColor = [UIColor redColor];
    [backBtn setImage:[UIImage imageNamed:@"夺宝-箭头-左.png"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)doBack:(id)sender{
    [self cancelRequest];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)showBackBtn:(ObjectBack)Back{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"夺宝-箭头-左.png"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(doBlockBack:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.000002 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.navigationController.interactivePopGestureRecognizer .enabled = NO;
    });
    self.Back = Back;
}
- (void)doBlockBack:(id)sender{
    self.Back();
    [self cancelRequest];
}
#pragma mark - 右侧
-(void)ShowRightBtnTitle:(NSString*)tilte Back:(ObjectBack)Back{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 80, 40);
    [backBtn setTitle:tilte forState:(UIControlStateNormal)];
    [backBtn setTitleColor:[UIColor colorWithHexString:kDarkGrey] forState:(UIControlStateNormal)];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15*SizeScale];
    [backBtn addTarget:self action:@selector(RightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = backItem;
    self.Back = Back;
}
#pragma mark - popRootdoBack点击事件
-(void)RightBtn:(UIButton*)sender{
     self.Back();
}
#pragma mark - 取消网络
-(void)cancelRequest{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (weakSelf.sessionArray.count>0) {
            for (NSURLSessionDataTask * task in weakSelf.sessionArray) {
                [task cancel];
            }
        }
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"2-------%@",[NSThread currentThread]);
            [weakSelf.sessionArray removeAllObjects];
        });
    });

}

-(void)ShowNodataView{
    if (!_baseBottomView) {
        __weak typeof(self) weakSelf = self;
        self.baseBottomView = [[UIView alloc]initWithFrame:CGRectZero];
        [UIView animateWithDuration:0.0000001 animations:^{
            weakSelf.baseBottomView.frame =  CGRectMake(0, 0, Width, Height);
            self.baseBottomView.backgroundColor = [UIColor colorWithHexString:kViewBackgroundColor];
            [self.view addSubview:_baseBottomView];
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
            imageView.image = [UIImage imageNamed:@"暂无数据"];
            imageView.contentMode =  UIViewContentModeCenter;
            imageView.clipsToBounds  = YES;
            [_baseBottomView addSubview:imageView];
        } ];
           }
}
-(void)HiddenNodataView{
    if (_baseBottomView) {
 __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.1 animations:^{
            [_baseBottomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            weakSelf.baseBottomView.alpha = 0.0;
        } completion:^(BOOL finished) {
             [weakSelf.baseBottomView removeFromSuperview];
            weakSelf.baseBottomView = nil;
        }];
       }
}
- (void)popRootshowBackBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn setImage:[UIImage imageNamed:@"夺宝-箭头-左"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(popRootdoBack:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.navigationBar.translucent = NO;
}
- (void)popRootdoBack:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//回收键盘
- (void)endEditingAction:(UIView *)endView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endtapAction:)];
    [endView addGestureRecognizer:tap];
}
- (void)endtapAction:(UITapGestureRecognizer *)sender {
    UIView *endV = sender.view;
    [endV endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [YKHTTPSession shareSession].BaseVC = self;
    [MobClick beginLogPageView:@"PageOne"];//("PageOne"为页面名称，可自定义)
    self.view.userInteractionEnabled = YES;
    self.navigationController.interactivePopGestureRecognizer .enabled = YES;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [MobClick endLogPageView:@"PageOne"];
    [SVProgressHUD dismiss];
    [[LoadWaitSingle shareManager] hideLoadWaitView];
    [self HiddenNodataView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

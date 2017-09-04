//
//  MyInfoVC.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/20.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "MyInfoVC.h"
#import "MySettingVC.h"
#import "MyWalletVC.h"
#import "MessageVC.h"
#import "BillVC.h"
#import "RegionViewController.h"
@interface MyInfoVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHight;
@end

@implementation MyInfoVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //用户信息赋值
    [YKNotification addObserver:self selector:@selector(UserInfoForControls:) name:@"获取个人信息" object:nil];
    //UI
    [self SET_UI];
    //数据
    [self  SET_DATA];
}
#pragma mark - 关于UI
-(void)SET_UI{
    self.title = @"我的";
    _bottomView.backgroundColor = [UIColor colorWithHexString:kBlueColor];
    self.imageHight.constant = 80*SizeScale;
    [self.avatar_url.layer setLaberMasksToBounds:YES cornerRadius:80*SizeScale/2 borderWidth:2.0*SizeScale borderColor:[UIColor whiteColor]];
    [self ShowRightBtnImage:@"消息" Back:^{
        //判断登录
        if ([HTTPTool isLogin]) {
            return ;
        }
        //跳转
        MessageVC * VC =  GetVC(MessageVC);
        PushVC(VC);
    }];
}
#pragma mark - 关于数据
-(void)SET_DATA{
    [self requestUserInfo];
    //上拉刷新下拉加载
    [self Refresh];
}
-(void)Refresh{
    __weak typeof(self) weakSelf = self;
    [ThirdPartyTool MJRefreshView:self.scrollView Header:YES Footer:NO HeaderBlock:^{
        [weakSelf requestUserInfo];
    } FooterBlock:^{
        
    }];
}
#pragma mark - 请求个人信息
-(void)requestUserInfo{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestUserInfoWithParm:@{} active:YES success:^(BaseResponse * _Nullable baseRes) {
        [ThirdPartyTool MJRefreshEndRefreView:weakSelf.scrollView];
    } faild:^(NSError * _Nullable error) {
        [ThirdPartyTool MJRefreshEndRefreView:weakSelf.scrollView];
    }];
    if (task) {
        [self.sessionArray addObject:task];
    }
}
#pragma mark - 用户赋值
-(void)UserInfoForControls:(NSNotification*)sender{
    YKHTTPSession * helper = [YKHTTPSession shareSession];
    [self.avatar_url SD_WebimageUrlStr:helper.userinfo.avatar_url placeholderImage:@"60"];
    self.mobile.text = [NSString stringWithFormat:@"账号:  %@",helper.userinfo.mobile];
    self.amount.text =helper.userinfo.amount;
    self.frozen_amount.text = helper.userinfo.frozen_amount;
    self.bank_card_num.text = [NSString stringWithFormat:@"%@",helper.userinfo.bank_card_num];
    ///0-未认证 1-认证中2-认证成功3-认证失败
    _certificationStatus.text = [[YKHTTPSession shareSession].userinfo.certify_status isEqualToString:@"2"] ? @"已认证":@"";
}
#pragma mark - 点击事件
- (IBAction)BtnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 101:
        {
            ///是否实名认证
            if ([HTTPTool isCertification]) {
                return ;
            }
            //我的钱包
            MyWalletVC * VC = GetVC(MyWalletVC);
            VC.MyWalletVCBlock = ^(){
//                //我的账单
//                BillVC * VC =  GetVC(BillVC);
//                [VC showBackBtn];
//                PushVC(VC);
                
            self. tabBarController.selectedIndex = 2;
            };
            PushVC(VC)
            break;
        }
        case 102:
        {
            ///是否实名认证
            if ([HTTPTool isCertification]) {
                return ;
            }
//            //我的账单
//            BillVC * VC =  GetVC(BillVC);
//            [VC showBackBtn];
//            PushVC(VC);
            self. tabBarController.selectedIndex = 2;
            break ;
        }
        case 103:
        {
            ///是否实名认证
            if ([HTTPTool isCertification]) {
                return ;
            }
            break;
        }
        case 104:
        {
            
            
            
            [DWAlertTool showToast:@"敬请期待..."];
//            NSMutableArray * marr =[@[@"1",@"2",@"3",@"4"]mutableCopy];
//            NSMutableArray * AfterMArray = [NSMutableArray arrayWithArray:marr];
//            //插入数据到第二位
//            [AfterMArray insertObject:@"3" atIndex:0];
//            //去重
//            NSMutableArray *listAry = [[NSMutableArray alloc]init];
//            for (NSString *str in AfterMArray) {
//                if (![listAry containsObject:str]) {
//                    [listAry addObject:str];
//                }
//            }
//            [YKDataTool saveUserData:[NSArray arrayWithArray:listAry] forKey:@"信用卡信息"];
//            NSArray * arr =[YKDataTool readUserDataForKey:@"信用卡信息"];
//            NSMutableArray * Marr =    [NSMutableArray arrayWithArray:arr];
//            for (int i=0; i<Marr.count; i++) {
//                NSLog(@"Marr----%@",Marr[i]);
//
//            }
            
            //ShareModel *model =[ShareModel new];
            //model.title = @"韩一帆❤️魏威 单身狗们,出来吃狗粮了";
            //model.text = @"韩一帆❤️魏威 单身狗们,出来吃狗粮了";
            //[ThirdPartyTool UShareType:ShareTypeText LayoutType:LayoutType_Draw ShareModel:model];
            break;
        }
        case 105:
        {
            //判断登录
            if ([HTTPTool isLogin]) {
                return ;
            }
            //设置
            MySettingVC * VC = GetVC(MySettingVC);
            PushVC(VC)
            break;
        }
        default:{
            break;
        }
    }
}
//只要拖拽就会触发(scrollView 的偏移量发生改变)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.view.backgroundColor = [UIColor colorWithHexString:scrollView.contentOffset.y> 0 ? kViewBackgroundColor:kBlueColor];
}
#pragma mark - dealloc
- (void)dealloc
{
    NSLog(@"%@销毁了", [self class]);
}
@end

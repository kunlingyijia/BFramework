//
//  MySettingVC.m
//  ManagementOfMoney
//
//  Created by 亚坤 席 on 17/7/20.
//  Copyright © 2017年 亚坤 席. All rights reserved.
//

#import "MySettingVC.h"
#import "BusinessCooperationVC.h"
#import "AboutUsVC.h"
#import "SuggestFeedbackVC.h"
#import "UpdatePasswordVC.h"
#import "AdModel.h"
#import "CurrentVersionVC.h"
#import "PasswordVC.h"
#import "MyInfoVC.h"
@interface MySettingVC ()

@end

@implementation MySettingVC
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
    self.title = @"我的设置";
  [self showBackBtn];
  }
#pragma mark - 关于数据
-(void)SET_DATA{
    YKHTTPSession * helper = [YKHTTPSession shareSession];
    [self.avatar_url SD_WebimageUrlStr:helper.userinfo.avatar_url placeholderImage:@"60"];
    self.mobile.text = [NSString stringWithFormat:@"%@",helper.userinfo.mobile];
    [self.avatar_url.layer setLaberMasksToBounds:YES cornerRadius:(Width/8-10)/2 borderWidth:1.0*SizeScale borderColor:[UIColor whiteColor]];
}
#pragma mark - 用户赋值
-(void)UserInfoForControls:(NSNotification*)sender{
    YKHTTPSession * helper = [YKHTTPSession shareSession];
    [self.avatar_url SD_WebimageUrlStr:helper.userinfo.avatar_url placeholderImage:@"60"];
    self.mobile.text = [NSString stringWithFormat:@"%@",helper.userinfo.mobile];
}
#pragma - 按钮事件
- (IBAction)ButtonAction:(UIButton *)sender {
    switch (sender.tag) {
            //个人头像
        case 101: {
            __weak typeof(self) weakSelf = self;
            ImageChooseVC* VC = [[ImageChooseVC alloc]initWithNibName:@"ImageChooseVC" bundle:nil];
            VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            VC.imageType = EditedImage;
            VC.zoom= 1.0;
            VC.ImageChooseVCBlock =^(UIImage *image){
                NSLog(@"%@",image);
              [[YKHTTPSession shareSession]UPImageToServer:@[image] toKb:50 success:^(NSArray *urlArr) {
                    NSDictionary * dic = urlArr[0];
                    Userinfo * model = [Userinfo new];
                    model.avatar_url =dic[@"url"];
                    NSURLSessionDataTask * task =    [HTTPTool requestUpdateUserInfoWithParm:model active:NO success:^(BaseResponse * _Nullable baseRes) {
                            weakSelf.avatar_url.image = image;
                            [YKHTTPSession shareSession].userinfo.avatar_url =dic[@"url"];
                            //设置别名
                            [YKNotification postNotificationName:@"获取个人信息" object:nil userInfo:nil];
                     } faild:^(NSError * _Nullable error) {
                         
                     }];
                  if (task) {
                      [weakSelf.sessionArray addObject:task];
                  }
                } faild:^(id error) {
                    
                }];
                
            };
            [self presentViewController:VC animated:NO completion:nil];
        }
            break;
            //个人账号
        case 102: {
//            AboutUsVC *VC = GetVC(AboutUsVC);
//            PushVC(VC)
        }
            break;
            //当前版本
        case 103: {
            CurrentVersionVC *VC = GetVC(CurrentVersionVC);
            PushVC(VC)
            }
            break;
            //修改密码
        case 104: {
            //Push 跳转
            PasswordVC * VC = GetVC(PasswordVC)
            VC.title = @"修改密码";
            __weak typeof(self) weakSelf = self;
            VC.PasswordVCBlock = ^(NSString  *account ,NSString  *password){
                //退出登录
                [weakSelf logout];
            };
            PushVC(VC)
        }
            break;
            //修改密码
        case 108: {
            //退出登录
            [self logout];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 退出登录
-(void)logout{
    //设置别名
    [YKNotification postNotificationName:@"设置别名" object:nil userInfo:[NSDictionary dictionaryWithObject:@"" forKey:@"pushAlias"]];
    //退出登录
    [YKNotification postNotificationName:@"退出账号" object:nil userInfo:nil];
    //            if ([HTTPTool isLogin]){
    //                return;
    //            }

}



#pragma mark - dealloc
- (void)dealloc
{   

    NSLog(@"%@销毁了", [self class]);
}
@end

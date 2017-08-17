//
//  MySettingVC.m
//  ManagementOfMoney
//
//  Created by 月美 刘 on 17/7/20.
//  Copyright © 2017年 月美 刘. All rights reserved.
//

#import "MySettingVC.h"
#import "BusinessCooperationVC.h"
#import "AboutUsVC.h"
#import "SuggestFeedbackVC.h"
#import "UpdatePasswordVC.h"
#import "AdModel.h"
#import "CurrentVersionVC.h"
@interface MySettingVC ()

@end

@implementation MySettingVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
    [self SET_UI];
    //数据
    [self  SET_DATA];
}
#pragma mark - 关于UI
-(void)SET_UI{
    self.title = @"我的设置";
    [self showBackBtn];
//    __block int A6 =1;
//    __block int A3 =1;
//    __block int A7 =1;
//    for (int i=0; i<100; i++) {
//        AdModel *model = [[AdModel alloc]init];
//        model.region_id = 1;
//        model.position = 1;
//        NSURLSessionDataTask * task =  [HTTPTool  requestAdWithParm:model  active:YES success:^(BaseResponse * _Nullable baseRes) {
//            //NSLog(@"%@", [baseRes yy_modelToJSONObject]);
//            if (baseRes.resultCode == 1) {
//                NSLog(@"6-----%d",A6++);
//            }else {
//                NSLog(@"7-----%d",A7++);
//            }
//        } faild:^(NSError * _Nonnull error) {
//            NSLog(@"3-----%d",A3++);
//        } ];
//       if (task) {
//            [self.sessionArray addObject:task];
//        }
//    }
}
#pragma mark - 关于数据
-(void)SET_DATA{
    YKHTTPSession * helper = [YKHTTPSession shareSession];
    [self.avatar_url SD_WebimageUrlStr:helper.userinfo.avatar_url placeholderImage:nil];
    self.mobile.text = [NSString stringWithFormat:@"%@",helper.userinfo.mobile];
    [self.avatar_url.layer setLaberMasksToBounds:YES cornerRadius:(Width/8-10)/2 borderWidth:1.0*SizeScale borderColor:[UIColor whiteColor]];
}

#pragma - 按钮事件
- (IBAction)ButtonAction:(UIButton *)sender {
    switch (sender.tag) {
            //个人头像
        case 101: {
//            BusinessCooperationVC *VC = GetVC(BusinessCooperationVC);
//                   PushVC(VC)
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
            UpdatePasswordVC *VC = GetVC(UpdatePasswordVC);
            PushVC(VC)
    
        }
            break;
            //修改密码
        case 108: {
            //设置别名
            [YKNotification postNotificationName:@"设置别名" object:nil userInfo:[NSDictionary dictionaryWithObject:@"" forKey:@"pushAlias"]];
            //退出登录
            [YKNotification postNotificationName:@"退出账号" object:nil userInfo:nil];
//            if ([HTTPTool isLogin]){
//                return;
//            }
            
        }
            break;
        default:
            break;
    }
}
#pragma mark - dealloc
- (void)dealloc
{   

    NSLog(@"%@销毁了", [self class]);
}
@end

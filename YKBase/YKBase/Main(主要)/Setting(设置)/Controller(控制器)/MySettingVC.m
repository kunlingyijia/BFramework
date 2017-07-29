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
    __block int A6 =1;
    __block int A3 =1;
    __block int A7 =1;
    for (int i=0; i<100; i++) {
        AdModel *model = [[AdModel alloc]init];
        model.region_id = 1;
        model.position = 1;
        NSURLSessionDataTask * task =  [HTTPTool  requestAdWithParm:model  active:YES success:^(BaseResponse * _Nullable baseRes) {
            //NSLog(@"%@", [baseRes yy_modelToJSONObject]);
            if (baseRes.resultCode == 1) {
                NSLog(@"6-----%d",A6++);
            }else {
                NSLog(@"7-----%d",A7++);
            }
        } faild:^(NSError * _Nonnull error) {
            NSLog(@"3-----%d",A3++);
        } ];
       if (task) {
            [self.sessionArray addObject:task];
        }
    }
}
#pragma mark - 关于数据
-(void)SET_DATA{

}

#pragma - 按钮事件
- (IBAction)ButtonAction:(UIButton *)sender {
    switch (sender.tag) {
            //商务合作
        case 101: {
            BusinessCooperationVC *VC = GetVC(BusinessCooperationVC);
            
            
            
            
            PushVC(VC)
        }
            break;
            //关于我们
        case 102: {
            AboutUsVC *VC = GetVC(AboutUsVC);
            PushVC(VC)
        }
            break;
            //反馈与建议
        case 103: {
            SuggestFeedbackVC *VC = GetVC(SuggestFeedbackVC);
            PushVC(VC)
            

        }
            break;
            //修改密码
        case 104: {
            UpdatePasswordVC *VC = GetVC(UpdatePasswordVC);
            PushVC(VC)
    
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

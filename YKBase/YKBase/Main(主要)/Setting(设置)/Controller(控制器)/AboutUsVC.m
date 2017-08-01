//
//  AboutUsVC.m
//  ManagementOfMoney
//
//  Created by 月美 刘 on 17/7/20.
//  Copyright © 2017年 月美 刘. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
    [self SET_UI];
    //数据
    [self  SET_DATA];
    
}
#pragma mark - 关于UI
-(void)SET_UI{
    [self showBackBtn];
     self.title = @"关于我们";
 
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
    
    
}
#pragma - 按钮事件
- (IBAction)ButtonAction:(UIButton *)sender {
    switch (sender.tag) {
            //喜欢我们,打分鼓励
        case 101: {
            
            [DWAlertTool showToast:@"喜欢我们,打分鼓励,喜欢我们,打分鼓励,喜欢我们,打分鼓励,喜欢我们,打分鼓励,喜欢我们,打分鼓励,喜欢我们,打分鼓励"];
            [ThirdPartyTool ULoginType:UMSocialPlatformType_WechatSession];
            
        }
            break;
            //分享给朋友
        case 102: {
            [DWAlertTool showToast:@"分享给朋友"];
            ShareModel * model = [ShareModel new];
            model.text = @"哎呀我去" ;
            [ThirdPartyTool UShareType:ShareTypeText LayoutType:LayoutType_Draw ShareModel:model ];
        }
            break;
            //联系客服
        case 103: {
            [[YKHTTPSession shareSession]CallPhoneNumber:@"18937640206" inView:self.view];
            [DWAlertTool showToast:@"联系客服"];

        }
            break;
        default:
            break;
    }
}
@end

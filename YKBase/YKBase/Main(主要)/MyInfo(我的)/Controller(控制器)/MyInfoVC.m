//
//  MyInfoVC.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/20.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "MyInfoVC.h"
#import "MySettingVC.h"
#import "AdModel.h"
#import "AppDelegate.h"
#import "SharePanelVC.h"
#import "BaseWKWebviewVC.h"
#import "MyWalletVC.h"
#import "MessageVC.h"

@interface MyInfoVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation MyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
    [self SET_UI];
    //数据
    [self  SET_DATA];
    
}
#pragma mark - 关于UI
-(void)SET_UI{
    self.title = @"我的";
    [self ShowRightBtnImage:@"消息" Back:^{
        //跳转
        MessageVC * VC =  GetVC(MessageVC);
        PushVC(VC);
        
    }];
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    _bottomView.backgroundColor = [UIColor colorWithHexString:kBlueColor];
    
    
}





- (IBAction)xx:(id)sender {
   
    if ([HTTPTool isLogin]){
        return;
    }
   // Push 跳转
    MySettingVC * VC = GetVC(MySettingVC);
    VC.name = @"";
    PushVC(VC)
//    BaseWKWebviewVC *webView = [[BaseWKWebviewVC alloc] initWithUrl:@"https://www.baidu.com"];
//    
//    [self.navigationController pushViewController:webView animated:YES];
        
}

#pragma mark - 点击事件


- (IBAction)BtnAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 101:
        {
//            ///是否实名认证
//            if ([HTTPTool isCertification]) {
//                return;
//            }
            //Push 跳转
            MyWalletVC * VC = GetVC(MyWalletVC);
            PushVC(VC)
           

            
            
            break;
        }
            
        case 102:
        {
            ///是否实名认证
            if ([HTTPTool isCertification]) {
                return;
            }

            
            break;
        }
            
        case 103:
        {
            ///是否实名认证
            if ([HTTPTool isCertification]) {
                return;
            }
            
            break;
        }
            
            
        case 104:
        {
            ///是否实名认证
            if ([HTTPTool isCertification]) {
                return;
            }

            
            break;
        }
        case 105:
        {
            MySettingVC * VC = GetVC(MySettingVC);
            
            
            
            PushVC(VC)
            
            break;
        }
            
        default:{
            
            break;
            
        }
    }

    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


//只要拖拽就会触发(scrollView 的偏移量发生改变)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (scrollView.contentOffset.y>0) {
        self.view.backgroundColor = [UIColor colorWithHexString:kViewBackgroundColor
                                     ];
    }else{
        self.view.backgroundColor = [UIColor colorWithHexString:kBlueColor];
    }
    NSLog(@"%f",scrollView.contentOffset.y);
   
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

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
#import "BaseSendTextView.h"
@interface MyInfoVC ()
@property(nonatomic,strong)BaseSendTextView*textView;
@end

@implementation MyInfoVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (IBAction)xx:(id)sender {
   
//    if ([HTTPTool isLogin]){
//        return;
//    }
   // Push 跳转
    MySettingVC * VC = GetVC(MySettingVC);
    VC.name = @"";
    PushVC(VC)
//    BaseWKWebviewVC *webView = [[BaseWKWebviewVC alloc] initWithUrl:@"https://www.baidu.com"];
//    
//    [self.navigationController pushViewController:webView animated:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

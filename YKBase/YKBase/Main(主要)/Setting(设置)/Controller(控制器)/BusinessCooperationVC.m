//
//  BusinessCooperationVC.m
//  ManagementOfMoney
//
//  Created by 月美 刘 on 17/7/20.
//  Copyright © 2017年 月美 刘. All rights reserved.
//

#import "BusinessCooperationVC.h"
#import "AdModel.h"
@interface BusinessCooperationVC ()

@end

@implementation BusinessCooperationVC


- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
    [self SET_UI];
    //数据
    [self  SET_DATA];
    NSLog(@"%@",self.name);
}
#pragma mark - 关于UI
-(void)SET_UI{
    __weak typeof(self) weakSelf = self;
    [self showBackBtn:^{
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
     self.title = @"商务合作";
    __block int A8 =1;
    __block int A9 =1;
    __block int A10 =1;
    for (int i=0; i<2; i++) {
        AdModel *model = [[AdModel alloc]init];
        model.region_id = 1;
        model.position = 1;
        NSURLSessionDataTask * task =  [HTTPTool  requestAdWithParm:model  active:NO success:^(BaseResponse * _Nullable baseRes) {
            //NSLog(@"%@", [baseRes yy_modelToJSONObject]);
            if (baseRes.resultCode == 1) {
                NSLog(@"8-----%d",A8++);
                
            }else {
                NSLog(@"9-----%d",A9++);
            }
            
        } faild:^(NSError * _Nonnull error) {
            NSLog(@"*******%@",[error yy_modelToJSONObject]);
            NSLog(@"10-----%d",A10++);
            
            //             NSLog(@"3-------%@",[NSThread currentThread]);
        } ];
        if (task) {
            [self.sessionArray addObject:task];
        }
}
    //NSLog(@"++++++++++=%@",self.sessionArray);
    

}
#pragma mark - 关于数据
-(void)SET_DATA{
    
    
    
}
#pragma mark - dealloc
- (void)dealloc
{
    NSLog(@"%@销毁了", [self class]);
}
@end

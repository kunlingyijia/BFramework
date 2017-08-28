//
//  SuggestFeedbackVC.m
//  ManagementOfMoney
//
//  Created by 亚坤 席 on 17/7/20.
//  Copyright © 2017年 亚坤 席. All rights reserved.
//

#import "SuggestFeedbackVC.h"

@interface SuggestFeedbackVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet DarkGreyTV *textView;


@end

@implementation SuggestFeedbackVC
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
    self.title = @"意见反馈";
    self.textView.placeholder = @"哎呀我去";
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
    
    
}




#pragma - 提交
- (IBAction)submitBtnAction:(UIButton *)sender {
}

@end

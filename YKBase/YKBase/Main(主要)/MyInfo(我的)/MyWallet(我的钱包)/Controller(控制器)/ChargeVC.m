//
//  ChargeVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/29.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "ChargeVC.h"

@interface ChargeVC ()
@property (weak, nonatomic) IBOutlet SegmentedView *segmented;

@end

@implementation ChargeVC

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
    self.title = @"快速充值";
    [self.segmented titleArr:[@[@"信用卡",@"借记卡"]mutableCopy]];
    __weak typeof(self) weakSelf = self;
    self.segmented.SegmentedViewBlock = ^(NSInteger tag){
        [weakSelf.view endEditing:YES];
        
        if (tag==0) {
            
        }
        if (tag==1) {
            
        }
    };

    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
    
    
}

#pragma mark - 立即支付
- (IBAction)submitAction:(SubmitBtn *)sender {
    if ([self IF]) {
        
    }
}
#pragma mark - 判断条件
-(BOOL)IF{
    [self.view endEditing:YES];
    BOOL  Y = YES;
    
    
    return Y;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    if (textField ==self.credit_line) {
//        NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//        return  [RegularTool checkAmount:toString];
//    }
   
    
    return YES;
    
}

#pragma mark - dealloc
- (void)dealloc
{
    
    NSLog(@"%@销毁了", [self class]);
}
@end

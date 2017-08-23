//
//  MyWalletVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "MyWalletVC.h"
#import "ChooseDebitCardVC.h"

@interface MyWalletVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *OneView;
@property (weak, nonatomic) IBOutlet UIView *TwoView;


@end

@implementation MyWalletVC

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
     _bottomView.backgroundColor = [UIColor colorWithHexString:kBlueColor];
    [self.OneView.layer setLaberMasksToBounds:YES cornerRadius:cutRadius*SizeScale borderWidth:borderW*SizeScale borderColor:[UIColor colorWithHexString:kLineColor]];
     [self.TwoView.layer setLaberMasksToBounds:YES cornerRadius:cutRadius*SizeScale borderWidth:borderW*SizeScale borderColor:[UIColor colorWithHexString:kLineColor]];
    self.title = @"我的钱包";
    
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
    
    
}

#pragma mark - 选择储蓄卡
- (IBAction)ChooseDebitCardAction:(UIButton *)sender {
    //跳转
    ChooseDebitCardVC * VC =  GetVC(ChooseDebitCardVC);
    
    PushVC(VC);
    
}
#pragma mark - 确认支付
- (IBAction)BtnAction:(SubmitBtn *)sender {
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
@end

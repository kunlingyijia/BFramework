//
//  DebitCardDetailsVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/10.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "DebitCardDetailsVC.h"
#import "BillVC.h"
#import "ChangeDebitCardVC.h"
#import "MakePlanVC.h"
@interface DebitCardDetailsVC ()
@property (weak, nonatomic) IBOutlet CutView *bottomView;

@end

@implementation DebitCardDetailsVC

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
    self.title = @"招商银行";
    self.bottomView.backgroundColor = [UIColor colorWithHexString:kBlueColor];
    
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
    
    
}
#pragma mark - 点击事件
- (IBAction)BtnAction:(PublicBtn *)sender {
    
    switch (sender.tag-100) {
        case 1:
        {
            //查看流水
            BillVC * VC =  GetVC(BillVC);
            
            PushVC(VC);
            break;
        }
        case 2:
        {
            //查看计划
            
            break;
        }
        case 3:
        {
            //定制计划
            //跳转
            MakePlanVC * VC =  GetVC(MakePlanVC);
            
            PushVC(VC);
            
            
            break;
        }
        case 4:
        {
            //卡片充值
            
            break;
        }
        case 5:
        {
            //修改资料
            ChangeDebitCardVC * VC =  GetVC(ChangeDebitCardVC);
            
            PushVC(VC);
            break;
        }
        case 6:
        {
            //卡片解绑
            
            break;
        }
        default:{
            
            break;
            
        }
    }

    
    
    
    
}



#pragma mark - dealloc
- (void)dealloc
{
    
    NSLog(@"%@销毁了", [self class]);
}

@end

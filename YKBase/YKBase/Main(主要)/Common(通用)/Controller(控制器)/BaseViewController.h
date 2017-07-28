//
//  BaseViewController.h
//  DWduifubao
//
//  Created by kkk on 16/9/8.
//  Copyright © 2016年 bianming. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ObjectBack)();
@interface BaseViewController : UIViewController
///数据
@property (nonatomic,strong)NSMutableArray * sessionArray;
///ObjectBack
@property (nonatomic, copy) ObjectBack  Back ;
@property(nonatomic,strong)UIView * baseBottomView;
- (void)showBackBtn;
- (void)showBackBtn:(ObjectBack)Back;
- (void)popRootshowBackBtn;
#pragma mark - 右侧
-(void)ShowRightBtnTitle:(NSString*)tilte Back:(ObjectBack)Back;
-(void)ShowNodataView;
-(void)HiddenNodataView;
//回收键盘
- (void)endEditingAction:(UIView *)endView;
@end

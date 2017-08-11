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
typedef void(^OKDefault)(UIAlertAction*defaultaction);
typedef void(^Cancel)(UIAlertAction *cancelaction);
///ObjectBack
@property (nonatomic, copy) ObjectBack  LeftBack ;
@property (nonatomic, copy) ObjectBack  RightBack ;
@property(nonatomic,strong)UIView * baseBottomView;
- (void)showBackBtn;
- (void)showBackBtn:(ObjectBack)Back;
- (void)showLeftBtnImage:(NSString*)image Back:(ObjectBack)Back;
- (void)popRootshowBackBtn;
#pragma mark - 右侧title
-(void)ShowRightBtnTitle:(NSString*)tilte Back:(ObjectBack)Back;
#pragma mark - 右侧title
-(void)ShowRightBtnImage:(NSString*)image Back:(ObjectBack)Back;
-(void)ShowNodataView;
-(void)HiddenNodataView;
//回收键盘
- (void)endEditingAction:(UIView *)endView;
#pragma mark - 取消-确定-确定 --居下
-(void)alertActionSheetWithTitle:(NSString*)title message:(NSString*)message OKWithTitleOne:(NSString*)OKtitleOne OKWithTitleTwo:(NSString*)OKtitleTwo  CancelWithTitle:(NSString*)Canceltitle withOKDefaultOne:(OKDefault)defaultactionOne withOKDefaultTwo:(OKDefault)defaultactionTwo withCancel:(Cancel)cancelaction;
@end

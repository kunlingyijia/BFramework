//
//  PopupVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/8.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "PopupVC.h"
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
@interface PopupVC ()

@property (weak, nonatomic) IBOutlet UIButton *OneBtn;
@property (weak, nonatomic) IBOutlet UIButton *TwoBtn;

@property (weak, nonatomic) IBOutlet UIButton *ThreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *FourBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PopupVC
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    [UIView animateWithDuration:0.3 animations:^{
       _imageView.transform = CGAffineTransformRotate(_imageView.transform, DEGREES_TO_RADIANS(180));
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _bottomView.alpha =1.0;
        }];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
    [self SET_UI];
    //数据
    [self  SET_DATA];
    
}
#pragma mark - 关于UI
-(void)SET_UI{
    _bottomView.alpha =0.0;
    self.modalPresentationStyle =UIModalPresentationCustom;
     [self.OneBtn setImagePosition:LXMImagePositionTop spacing:5];
     [self.TwoBtn setImagePosition:LXMImagePositionTop spacing:5];
     [self.ThreeBtn setImagePosition:LXMImagePositionTop spacing:5];
     [self.FourBtn setImagePosition:LXMImagePositionTop spacing:5];
    
}
#pragma mark - 关于数据
-(void)SET_DATA{
    
    

    
}

- (IBAction)BackAction:(UIButton *)sender {
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
       _imageView.transform = CGAffineTransformRotate(_imageView.transform, DEGREES_TO_RADIANS(180));
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _imageView.alpha = 0.0;
             _bottomView.alpha =0.0;
//            _imageView.alpha = 0.2;
        }completion:^(BOOL finished) {
            self.PopupVCBlock(sender.tag-100);
            [self dismissViewControllerAnimated:NO completion:^{}];
        }];
    }];

         //
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

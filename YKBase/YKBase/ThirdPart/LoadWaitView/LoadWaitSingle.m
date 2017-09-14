//
//  LoadWaitSingle.m
//  自定义加载等待图
//
//  Created by 席亚坤 on 17/1/18.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "LoadWaitSingle.h"
#import "LoadWaitView.h"
#import "AppDelegate.h"
@interface LoadWaitSingle ()
@property (nonatomic, strong) LoadWaitView* LWView;
    

@end
@implementation LoadWaitSingle
+(LoadWaitSingle*)shareManager{
    static LoadWaitSingle *_LoadWaitSingle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _LoadWaitSingle = [[LoadWaitSingle alloc]init];
    });
    return _LoadWaitSingle;
}


- (void) showLoadWaitViewImage:(NSString*)image{
    
   
    __weak typeof(self) weakSelf = self;

    dispatch_queue_t queue2 = dispatch_queue_create("巧巧科技加载灰", DISPATCH_QUEUE_CONCURRENT); //字符串是指定唯一指示 ,DISPATCH_QUEUE_CONCURRENT 是指定为并发队列
    //往队列添加任务
    dispatch_async(queue2, ^{
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            if (weakSelf.LWView != nil) {
                //[self hideLoadWaitView];
            }else{
                AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                
                weakSelf.LWView =
                [[LoadWaitView alloc]initWithimage:image];
                [delegate.window addSubview:_LWView];
               
            }

        });
       
        
    });
    

}
- (void) hideLoadWaitView {
    
    if (_LWView != nil) {
        [_LWView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_LWView removeFromSuperview];
        _LWView = nil;
        _LWView.bottomView = nil;
        _LWView.imageView = nil;
    }
}

@end

//
//  SegmentedView.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentedView : UIView
@property (nonatomic, copy) void(^ SegmentedViewBlock)(NSInteger tag);
///左侧
@property (nonatomic, strong) PublicBtn *leftBtn;
///右侧
@property (nonatomic, strong) PublicBtn *rightBtn;

-(void)titleArr:(NSMutableArray * )array;

@end

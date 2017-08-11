//
//  MCDatePickerView.h
//  MFCDatePackerView
//
//  Created by machao on 2017/5/23.
//  Copyright © 2017年 machao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,XMGStyleType) {
    XMGStyleTypeDay = 0,//年
    XMGStyleTypeYearAndMonth,//年月
    // XMGStyleTypeDay ,//日
    
};




@interface MCDatePickerView : UIView

typedef void(^MCDateSuccessBack)(NSString *resultstr);

///
@property (nonatomic, copy) MCDateSuccessBack  SuccessBack ;
- (instancetype)initWithFrame:(CGRect)frame type:(XMGStyleType)type MCDateSuccessBack:(MCDateSuccessBack)successBack;

/**
 显示PickerView
 */
- (void)show;

///**
// 移除PickerView
// */
//- (void)remove;

@end



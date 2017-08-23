//
//  PublicSize.h
//  字体大小比例适配
//
//  Created by 席亚坤 on 17/3/1.
//  Copyright © 2017年 席亚坤. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PublicSize : NSObject

@end
/**
 深灰标签
 */
@interface DarkGreyLabel : UILabel
///indexPath
@property (nonatomic, strong) NSIndexPath  *indexPath ;
@end
/**
 浅灰标签
 */
@interface LightGreyLabel : UILabel
///indexPath
@property (nonatomic, strong) NSIndexPath  *indexPath ;

@end
/**
 白色标签
 */
@interface WhiteLabel : UILabel
///indexPath
@property (nonatomic, strong) NSIndexPath  *indexPath ;

@end
/**
 蓝色标签
 */
@interface BlueLabel : UILabel
///indexPath
@property (nonatomic, strong) NSIndexPath  *indexPath ;
@end
/**
 公共标签
 */
@interface PublicLabel : UILabel
///indexPath
@property (nonatomic, strong) NSIndexPath  *indexPath ;

@end
/**
 公共按钮
 */
@interface PublicBtn : UIButton
///indexPath
@property (nonatomic, strong) NSIndexPath *indexPath ;

@end
/**
 提交按钮
 */
@interface SubmitBtn : PublicBtn
@end
/**
 提交按钮
 */
@interface BlueBtn : PublicBtn
@end
/**
 深灰输入框
 */
@interface DarkGreyTF : UITextField
///indexPath
@property (nonatomic, strong) NSIndexPath  *indexPath ;
@end
/**
 浅灰输入框
 */
@interface LightGreyTF : UITextField
///indexPath
@property (nonatomic, strong) NSIndexPath  *indexPath ;
@end
/**
 深灰输入栏
 */
@interface DarkGreyTV : EZTextView

@end
/**
 浅灰输入栏
 */
@interface LightGreyTV : EZTextView

@end
/**
 线视图
 */
@interface LineView : UIView

@end
/**
 圆角视图
 */
@interface CutView : UIView

@end



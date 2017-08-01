//
//  SharePanelModel.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/26.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharePanelModel : NSObject
///标题
@property (nonatomic, strong) NSString  *title ;
///图片
@property (nonatomic, strong) NSString  *image ;
///分享类型
@property (nonatomic, assign) UMSocialPlatformType  platformType ;





@end

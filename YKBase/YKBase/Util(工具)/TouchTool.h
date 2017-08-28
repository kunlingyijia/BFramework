//
//  TouchTool.h
//  YKBase
//
//  Created by 席亚坤 on 2017/7/28.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TouchTool : NSObject
//设置网络请求成功 失败的bolck
typedef void(^Success)(BOOL  success);
typedef void(^Faild)(NSError * error);
///指纹解锁
+(void)FingerprintUnlock:(Success)Success Faild:(Faild)Faild;

@end

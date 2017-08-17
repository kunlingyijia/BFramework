//
//  SystemModel.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/16.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemModel : NSObject
///图片上传地址
@property (nonatomic, strong) NSString  *image_hostname ;
///图片上传账号
@property (nonatomic, strong) NSString  *image_account ;
///图片上传密码
@property (nonatomic, strong) NSString  *image_password ;

@end

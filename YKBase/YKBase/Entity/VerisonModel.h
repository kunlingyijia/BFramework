//
//  VerisonModel.h
//  DWduifubao
//
//  Created by 席亚坤 on 16/11/7.
//  Copyright © 2016年 bianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerisonModel : NSObject
///os
@property (nonatomic, assign) int os;
///版本名称
@property (nonatomic, strong) NSString *version_name ;
///版本号
@property (nonatomic, strong) NSString  *version_code ;
///下载链接
@property (nonatomic, strong) NSString *download_url ;
///安装包大小
@property (nonatomic, strong) NSString *size ;
///更新时间
@property (nonatomic, strong) NSString *create_time	 ;
///版本更新 内容
@property (nonatomic, strong) NSString *content ;
///是否强制更新：1-否，2-是
@property (nonatomic, strong) NSString *forced_update ;








@end

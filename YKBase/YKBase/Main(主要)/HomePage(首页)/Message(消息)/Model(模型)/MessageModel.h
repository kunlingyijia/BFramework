//
//  MessageModel.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/17.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
///消息id
@property (nonatomic, strong) NSString  *message_id ;
///标题
@property (nonatomic, strong) NSString  *title ;
///创建时间
@property (nonatomic, strong) NSString  *create_time ;
///内容
@property (nonatomic, strong) NSString  *content ;
///通知 1-系统公告   2-个人通知
@property (nonatomic, strong) NSString  *type ;
///select
@property (nonatomic, assign) BOOL  selected ;

///Cell高度
@property (nonatomic, assign) float CellHeight;



@end

//
//  MessageOneCell.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageModel;
@interface MessageOneCell : UITableViewCell
///model
@property (nonatomic, strong) MessageModel *model ;
@property (weak, nonatomic) IBOutlet DarkGreyLabel *type;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet LightGreyLabel *create_time;
@property (weak, nonatomic) IBOutlet LightGreyLabel *title;


@end

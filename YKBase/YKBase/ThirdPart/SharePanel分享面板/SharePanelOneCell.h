//
//  SharePanelOneCell.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/26.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SharePanelModel;
@interface SharePanelOneCell : UICollectionViewCell
///model
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic, strong) SharePanelModel *model;
@end

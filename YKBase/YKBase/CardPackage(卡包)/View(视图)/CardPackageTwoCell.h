//
//  CardPackageTwoCell.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/10.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardModel;
@interface CardPackageTwoCell : UITableViewCell
///model
@property (nonatomic, strong) CardModel *model ;
@property (weak, nonatomic) IBOutlet UIImageView *BankImageView;
@property (weak, nonatomic) IBOutlet UIImageView *BagImageView;
@property (weak, nonatomic) IBOutlet WhiteLabel *bank_name;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;


@end

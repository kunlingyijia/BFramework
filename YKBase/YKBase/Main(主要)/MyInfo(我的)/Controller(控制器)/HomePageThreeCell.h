//
//  HomePageThreeCell.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageModel;
@interface HomePageThreeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet CutView *bottomView;

@property (weak, nonatomic) IBOutlet PublicBtn *OneBtn;
///model
@property (nonatomic, strong) HomePageModel *model ;
@end

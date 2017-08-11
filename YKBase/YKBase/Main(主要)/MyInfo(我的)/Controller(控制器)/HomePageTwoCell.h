//
//  HomePageTwoCell.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageTwoCell : UITableViewCell
@property (nonatomic, copy) void(^ HomePageTwoCellBlock)(NSInteger tag);

@property (weak, nonatomic) IBOutlet PublicBtn *OneBtn;
@property (weak, nonatomic) IBOutlet PublicBtn *TwoBtn;
@property (weak, nonatomic) IBOutlet PublicBtn *ThreeBtn;
@property (weak, nonatomic) IBOutlet PublicBtn *FourBtn;
@property (weak, nonatomic) IBOutlet PublicBtn *FiveBtn;  //我要办卡
@property (weak, nonatomic) IBOutlet PublicBtn *SixBtn;  //我要贷款
@property (weak, nonatomic) IBOutlet PublicBtn *SevenBtn;  //我要推荐
@property (weak, nonatomic) IBOutlet PublicBtn *EightBtn;  //我要财富


@end

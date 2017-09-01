//
//  ChooseDebitCardVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/10.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface ChooseDebitCardVC : BaseViewController
///银行卡id
@property (nonatomic, strong) NSString  *bank_id ;
@property (nonatomic, copy) void(^ ChooseDebitCardVCBlock)(NSString * bankName,NSString * bank_card_no,NSString  *bank_id );

@end

//
//  CertificationVC.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BaseViewController.h"

@interface CertificationVC : BaseViewController


@property (weak, nonatomic) IBOutlet DarkGreyTF *real_name;
@property (weak, nonatomic) IBOutlet DarkGreyTF *id_card;
@property (weak, nonatomic) IBOutlet DarkGreyTF *bank_card_no;
@property (weak, nonatomic) IBOutlet DarkGreyTF *bank_name;
@property (weak, nonatomic) IBOutlet DarkGreyTF *bind_mobile;
@property (weak, nonatomic) IBOutlet DarkGreyTF *verify_code;
@property (weak, nonatomic) IBOutlet UIImageView *id_card_photo;
@property (weak, nonatomic) IBOutlet UIImageView *id_card_back_photo;
@property (weak, nonatomic) IBOutlet UIImageView *hand_id_card_photo;
@property (weak, nonatomic) IBOutlet UIImageView *bank_card_photo;

@property (weak, nonatomic) IBOutlet SubmitBtn *submitBtn;



@end

//
//  CertificationModel.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/16.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CertificationModel : NSObject

///真实姓名
@property (nonatomic, strong) NSString  *real_name ;
///身份证号码
@property (nonatomic, strong) NSString  *id_card ;
///银行卡号 
@property (nonatomic, strong) NSString  *bank_card_no;
///开户银行
@property (nonatomic, strong) NSString  *bank_name ;
///预留手机号
@property (nonatomic, strong) NSString  *bind_mobile ;
///银行下发的验证码
@property (nonatomic, strong) NSString  *verify_code ;
///身份证正面
@property (nonatomic, strong) NSString  *id_card_photo ;
///身份证背面
@property (nonatomic, strong) NSString  *id_card_back_photo ;
///手持身份证照片
@property (nonatomic, strong) NSString  *hand_id_card_photo ;
///银行卡正面url
@property (nonatomic, strong) NSString  *bank_card_photo ;
///错误信息
@property (nonatomic, strong) NSString  *remark ;
///认证id
@property (nonatomic, strong) NSString  *certify_id ;




@end

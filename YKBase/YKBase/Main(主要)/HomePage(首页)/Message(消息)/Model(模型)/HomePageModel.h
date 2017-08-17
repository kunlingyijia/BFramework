//
//  HomePageModel.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/17.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageModel : NSObject

///外部链接
@property (nonatomic, strong) NSString  *link_url ;
///原图
@property (nonatomic, strong) NSString  *image_url ;

///文章ID
@property (nonatomic, strong) NSString  *article_id ;
///文章标题
@property (nonatomic, strong) NSString  *title ;

///开户银行
@property (nonatomic, strong) NSString  *bank_name ;
///银行卡号
@property (nonatomic, strong) NSString  *bank_card_no ;
///信用额度
@property (nonatomic, strong) NSString  *credit_line ;
///账单日
@property (nonatomic, strong) NSString  *state_date ;
///还款日
@property (nonatomic, strong) NSString  *repay_date ;




@end

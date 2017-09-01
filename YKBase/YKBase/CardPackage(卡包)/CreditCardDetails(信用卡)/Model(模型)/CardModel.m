//
//  CardModel.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/11.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "CardModel.h"

@implementation CardModel
//#把数组里面带有对象的类型专门按照这个方法，这个格式写出来
-(nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"repay" : CardSubModel.class,
             @"consume" : CardSubModel.class
             };
}
@end

@implementation CardSubModel


@end

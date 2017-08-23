//
//  BillModel.h
//  YKBase
//
//  Created by 席亚坤 on 2017/8/21.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BillSubModel;
@interface BillModel : NSObject

///账单model数组
@property (nonatomic, strong) NSArray <BillSubModel *> *billSubModel;
@end

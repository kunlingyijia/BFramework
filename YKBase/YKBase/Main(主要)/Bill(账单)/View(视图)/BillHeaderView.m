//
//  BillHeaderView.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "BillHeaderView.h"

@implementation BillHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self=  [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

-(void)addSubviews{
    self.title = [[DarkGreyLabel alloc]initWithFrame:CGRectMake(15, 0, Width-15, Width*0.1)];
    self.title .text = @"1991-02-06";
    self.title.backgroundColor = [UIColor clearColor];
    self.title.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:_title];
    
}


@end

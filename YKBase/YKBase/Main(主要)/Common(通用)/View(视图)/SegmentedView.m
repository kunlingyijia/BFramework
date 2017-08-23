//
//  SegmentedView.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "SegmentedView.h"

@interface SegmentedView (){
    
}




@end

@implementation SegmentedView

#pragma mark - 圆角视图
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubview];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview];
    }
    return self;
}
-(void)addSubview{
    
    [self.layer setLaberMasksToBounds:YES cornerRadius:self.bounds.size.height/2 borderWidth:0.0 borderColor:nil];
    //self.backgroundColor = [UIColor colorWithHexString:kLineColor];
    self.leftBtn = [[PublicBtn alloc]initWithFrame:CGRectMake(0, 0, Width/2-15, self.bounds.size.height)];
    self.leftBtn.tag = 7500;
    [self.leftBtn addTarget:self action:@selector(BtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:15*SizeScale];
    self.leftBtn.backgroundColor =[UIColor colorWithHexString:kBlueColor];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:self.leftBtn];
    
    self. rightBtn = [[PublicBtn alloc]initWithFrame:CGRectMake(Width/2-15, 0, Width/2-15, self.bounds.size.height)];
    self. rightBtn.tag = 7501;
    [self.rightBtn addTarget:self action:@selector(BtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15*SizeScale];
    self.rightBtn.backgroundColor =[UIColor whiteColor];
    [self.rightBtn setTitleColor:[UIColor colorWithHexString:kDarkGrey] forState:(UIControlStateNormal)];
    [self addSubview:self.rightBtn];
}
-(void)BtnAction:(PublicBtn*)sender{
    if (self.leftBtn ==sender) {
        self.leftBtn.backgroundColor =[UIColor colorWithHexString:kBlueColor];
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.rightBtn.backgroundColor =[UIColor whiteColor];
        [self.rightBtn setTitleColor:[UIColor colorWithHexString:kDarkGrey] forState:(UIControlStateNormal)];
    }
    if (self.rightBtn ==sender) {
        self.rightBtn.backgroundColor =[UIColor colorWithHexString:kBlueColor];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.leftBtn.backgroundColor =[UIColor whiteColor];
        [self.leftBtn setTitleColor:[UIColor colorWithHexString:kDarkGrey] forState:(UIControlStateNormal)];
    }
    self.SegmentedViewBlock(sender.tag-7500);
    
}



-(void)titleArr:(NSMutableArray * )array{
    [self.leftBtn setTitle:[NSString stringWithFormat:@"%@",array[0]] forState:(UIControlStateNormal)];
    [self.rightBtn setTitle:[NSString stringWithFormat:@"%@",array[1]] forState:(UIControlStateNormal)];
}
@end

//
//  PublicSize.m
//  字体大小比例适配
//
//  Created by 席亚坤 on 17/3/1.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "PublicSize.h"

@implementation PublicSize

@end

/////***********************************************************标签***************************************////

@implementation DarkGreyLabel
#pragma mark - 深灰标签
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self SetUpSize];
        
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self SetUpSize];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpSize];
    }
    return self;
}


-(void)SetUpSize {
    self.textColor = [UIColor colorWithHexString:kDarkGrey];
    self.font = [UIFont systemFontOfSize:self.font.pointSize* SizeScale];
}

@end

@implementation LightGreyLabel
#pragma mark - 浅灰标签
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self SetUpSize];
        
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
-(void)SetUpSize {
    self.textColor = [UIColor colorWithHexString:kLightGrey];
    self.font = [UIFont systemFontOfSize:self.font.pointSize* SizeScale];
}

@end

@implementation WhiteLabel
#pragma mark - 白色标签
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self SetUpSize];
        
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
-(void)SetUpSize {
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:self.font.pointSize* SizeScale];
}

@end



@implementation BlueLabel
#pragma mark - 蓝色标签
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self SetUpSize];
        
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
-(void)SetUpSize {
    self.textColor = [UIColor colorWithHexString:kBlueColor];
    self.font = [UIFont systemFontOfSize:self.font.pointSize* SizeScale];
}

@end
@implementation PublicLabel
#pragma mark - 公共标签
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self SetUpSize];
        
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
-(void)SetUpSize {
    //    self.textColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:self.font.pointSize* SizeScale];
}

@end


@implementation PublicBtn
#pragma mark - 按钮
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self SetUpSize];
        
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self SetUpSize];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
-(void)SetUpSize {
    // self.titleLabel. textColor = [UIColor colorWithHexString:kDarkGrey];
    self.titleLabel.font = [UIFont systemFontOfSize:self.titleLabel.font.pointSize* SizeScale];
}
@end

@implementation SubmitBtn
#pragma mark - 提交按钮
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithHexString:kBlueColor];
    [self.layer setLaberMasksToBounds:YES cornerRadius:5*SizeScale borderWidth:0.0*SizeScale borderColor:[UIColor colorWithHexString:kBlueColor]];
    [self setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
}

- (void)setNeedsLayout{
    CGRect frame = self.frame;
    frame.size.height = 40*SizeScale;
    self.frame = frame;
    
}


@end



@implementation BlueBtn
#pragma mark - 蓝色按钮
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self SetUpSize];
        
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
-(void)SetUpSize {
    self.titleLabel. textColor = [UIColor colorWithHexString:kBlueColor];
    //self.font = [UIFont systemFontOfSize:self.font.pointSize* SizeScale];
}

@end
@implementation DarkGreyTF

#pragma mark - 深灰输入框
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self SetUpSize];
    }
    
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self SetUpSize];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
-(void)SetUpSize {
    self. textColor = [UIColor colorWithHexString:kDarkGrey];
    // self.tintColor = [UIColor redColor];
    self.font = [UIFont systemFontOfSize:self.font.pointSize* SizeScale];
}

@end

@implementation LightGreyTF
#pragma mark - 浅灰
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
-(void)SetUpSize {
    self. textColor = [UIColor colorWithHexString:kLightGrey];
//    self.tintColor = [UIColor redColor];
    self.font = [UIFont systemFontOfSize:self.font.pointSize* SizeScale];
}

@end
/////              ************************************************* 输入栏**********************************************************************************************////
@implementation DarkGreyTV
#pragma mark - 深灰输入栏
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
-(void)SetUpSize {
    self. textColor = [UIColor colorWithHexString:kDarkGrey];
    self.font = [UIFont systemFontOfSize:self.font.pointSize* SizeScale];
//    self.tintColor = [UIColor redColor];
}
@end

@implementation LightGreyTV
#pragma mark - 浅灰输入栏
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpSize];
    }
    return self;
}
-(void)SetUpSize{
    self. textColor = [UIColor colorWithHexString:kLightGrey];
    self.font = [UIFont systemFontOfSize:self.font.pointSize* SizeScale];
//    self.tintColor = [UIColor redColor];
}
@end
@implementation LineView
#pragma mark - 线视图
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
    self.backgroundColor = [UIColor colorWithHexString:kLineColor];
}
-(void)layoutSubviews{
    CGRect  Frame= self.frame;
    Frame.size.height =0.4*SizeScale;
    self.frame= Frame;
}
@end

@implementation CutView
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
    [self.layer setLaberMasksToBounds:YES cornerRadius:cutRadius*SizeScale borderWidth:0.0 borderColor:nil];
}
@end



//
//  MCDatePickerView.m
//  MFCDatePackerView
//
//  Created by machao on 2017/5/23.
//  Copyright © 2017年 machao. All rights reserved.
//

static float ToolbarH  = 50;
static float PickerViewH  = 200;
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#import "MCDatePickerView.h"

@interface MCDatePickerView() <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic ,strong) UIPickerView *datePickerView;
@property (nonatomic ,strong) UIToolbar *toolBar;
@property (nonatomic ,strong) NSMutableArray *month;
@property (nonatomic ,strong) NSMutableArray *year;
@property (nonatomic ,strong) NSMutableArray *day;
@property (nonatomic ,assign) NSInteger selectYearRow;
@property (nonatomic ,assign) NSInteger selectMonthRow;
@property (nonatomic ,assign) NSInteger selectDayRow;
@property (nonatomic, assign) CGFloat toolViewY;//self的Y值
@property (nonatomic, assign ) XMGStyleType type;
//当前时间
@property (nonatomic ,strong)   NSString *currentDate;
@end
@implementation MCDatePickerView
- (instancetype)initWithFrame:(CGRect)frame type:(XMGStyleType)type MCDateSuccessBack:(MCDateSuccessBack)successBack{
    self.type = type;
    self.SuccessBack = successBack;
    return  [self initWithFrame:frame];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupView];
    }
    return self;
}

#pragma mark - Delegate
 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.type == XMGStyleTypeDay) {
        return 1;
    }
    return 2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if (self.type ==XMGStyleTypeDay) {
        self.selectDayRow  = row;
    }else{
        if (component == 0)
        {
            self.selectYearRow  = row;
        }
        else
        {
            self.selectMonthRow = row;
        }
        NSString * str = [NSString stringWithFormat:@"%@-%@",self.year[self.selectYearRow],self.month[self.selectMonthRow]];
        if ([self.currentDate compare:str ]==NSOrderedAscending ) {
            //NSOrderedAscending (降序)
            if (component == 0)
            {
                self.selectYearRow  = row;
            }
            else
            {
                self.selectMonthRow = row;
            }
        }else{
            int year  = [[_currentDate componentsSeparatedByString:@"-"][0] intValue];
            int month = [[_currentDate componentsSeparatedByString:@"-"][1] intValue];
            
            NSInteger currentRow = year - [self.year[0] integerValue];
            
            [self.datePickerView selectRow:currentRow inComponent:0 animated:NO];
            [self.datePickerView selectRow:month-1 inComponent:1 animated:YES];
            self.selectYearRow = currentRow;
            self.selectMonthRow = month-1;
        }
  }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.type ==XMGStyleTypeDay) {
        return self.day.count;
    }else{
        return component == 0 ? self.year.count : self.month.count;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView
                      titleForRow:(NSInteger)row
                     forComponent:(NSInteger)component
{
    
    if (self.type ==XMGStyleTypeDay) {
        return [NSString stringWithFormat:@"%@日",self.day[row]];
    }else{
        if (component == 0)
        {
            return [NSString stringWithFormat:@"%@年",self.year[row]];
        }
        else
        {
            return [NSString stringWithFormat:@"%@月",self.month[row]];
        }
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return 45;
}

/**
    界面设置
 */
- (void)setupView
{
    [self addSubview:self.toolBar];
    UIPickerView *datePickerView = [[UIPickerView alloc] init];
    datePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ToolbarH, SCREEN_W, PickerViewH)];
    datePickerView.backgroundColor = [UIColor whiteColor];
    datePickerView.delegate   = self;
    datePickerView.dataSource = self;
    self.datePickerView = datePickerView;
    [self addSubview:datePickerView];
    self.toolViewY = SCREEN_H - (ToolbarH + PickerViewH);
    self.frame     = CGRectMake(0, SCREEN_H, SCREEN_W, (ToolbarH + PickerViewH));
    [self setCurrentDate];
}
/**
    设置默认时间->当前年月
 */
- (void)setCurrentDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    self. currentDate = [formatter stringFromDate:date];
    int year  = [[_currentDate componentsSeparatedByString:@"-"][0] intValue];
    int month = [[_currentDate componentsSeparatedByString:@"-"][1] intValue];
    NSInteger currentRow = year - [self.year[0] integerValue];
    [self.datePickerView selectRow:currentRow inComponent:0 animated:NO];
    if (self.type == XMGStyleTypeYearAndMonth) {
        [self.datePickerView selectRow:month-1 inComponent:1 animated:NO];
    }else{
        [self.datePickerView selectRow:14 inComponent:0 animated:NO];
    }
    self.selectYearRow = currentRow;
    self.selectMonthRow = month-1;
    self.selectDayRow = 14;
}
/**
    工具栏
 */
- (UIToolbar *)toolBar
{
    if (!_toolBar)
    {
        _toolBar = [[UIToolbar alloc] init];
        _toolBar.frame = CGRectMake(0, 0, SCREEN_W, ToolbarH);
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"   取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确认   " style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];

        _toolBar.items = @[cancelItem, flexSpace, doneItem];
    }
    return _toolBar;
}

/**
    确定
 */
- (void)doneClick
{
    NSString *year  = self.year[self.selectYearRow];
    NSString *month = self.month[self.selectMonthRow];
    NSString *day = self.day[self.selectDayRow];
    NSString *resultDate;
    if (self.type == XMGStyleTypeDay) {
        resultDate = [NSString stringWithFormat:@"%@",day];
    }else{
        resultDate = [NSString stringWithFormat:@"%@/%@",month, [year substringToIndex:2]];
    }
    
    self.SuccessBack(resultDate);
    [self remove];
}


/**
    移除PickerView
 */
- (void)remove
{
    
    [UIView animateWithDuration:0.35 animations:^
     {
         self.frame = CGRectMake(0, SCREEN_H, SCREEN_W, PickerViewH + ToolbarH);
         
     } completion:^(BOOL finished)
     {
         for (UIView *view in [[UIApplication sharedApplication].keyWindow subviews])
         {
             if (view.tag == 10101)
             {
                 [view removeFromSuperview];
             }
         }
     }];
    
}

/**
    显示PickerView
 */
- (void)show
{
    UIView *screenView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    screenView.backgroundColor = [UIColor colorWithRed:0/255.0
                                                 green:0/255.0
                                                  blue:0/255.0
                                                 alpha:0.3];
    screenView.tag             = 10101;
    [screenView addSubview:self];
    
    [[UIApplication sharedApplication].keyWindow addSubview: screenView];
    
    [UIView animateWithDuration:0.35 animations:^
     {
         screenView.alpha = 1.0;
         self.frame = CGRectMake(0, self.toolViewY, SCREEN_W, PickerViewH + ToolbarH);
         
     } completion:^(BOOL finished)
     {
         
     }];
}

/**
    获取年份数据
 */
- (NSMutableArray *)year
{
    if (!_year)
    {
        _year = [NSMutableArray array];
        
        for (int i = 1900; i < 2100; i++)
        {
            NSString *yearStr = [NSString stringWithFormat:@"%d",i];
            [_year addObject:yearStr];
        }
        
    }
    return _year;
}

/**
    获取月份数据
 */
- (NSMutableArray *)month
{
    if (!_month)
    {
        _month = [NSMutableArray array];
        
        for (int i = 1; i < 13; i++)
        {
            NSString *monthStr;
            if (i<10) {
                monthStr = [NSString stringWithFormat:@"0%d",i];
            }else{
           monthStr = [NSString stringWithFormat:@"%d",i];
          }
            [_month addObject:monthStr];
        }
    }
    
    return _month;
}

- (NSMutableArray *)day
{
    if (!_day)
    {
        _day = [NSMutableArray array];
        
        for (int i = 1; i < 32; i++)
        {
            NSString *dayStr;
            if (i<10) {
                dayStr = [NSString stringWithFormat:@"0%d",i];
            }else{
                dayStr = [NSString stringWithFormat:@"%d",i];
            }
           
            [_day addObject:dayStr];
        }
    }
    
    return _day;
}



@end




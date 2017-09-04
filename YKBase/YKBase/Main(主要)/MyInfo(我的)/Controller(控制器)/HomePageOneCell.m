//
//  HomePageOneCell.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "HomePageOneCell.h"
#import "SXHeadLine.h"
@interface HomePageOneCell ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)    SDCycleScrollView *cycleScrollViewImage;
///数据
@property (nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)DarkGreyLabel *label;
@property(nonatomic,strong)SXHeadLine *headLine3;
@end

@implementation HomePageOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor colorWithHexString:kViewBackgroundColor];
    //cell选中时的颜色 无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //Cell右侧箭头
    //self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    self.separatorInset = UIEdgeInsetsMake(0, Width, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self createView];
}
- (void)createView {
    // 网络加载图片的轮播器
    if (!_cycleScrollViewImage) {
        self. cycleScrollViewImage = [SDCycleScrollView   cycleScrollViewWithFrame:CGRectMake(0, 0, Width, Width*0.4) delegate:self placeholderImage:[UIImage imageNamed:@"敬请期待long"]];
        self. cycleScrollViewImage.autoScrollTimeInterval =3.0;
        [self.ShufflingImgView addSubview:  _cycleScrollViewImage];
    }
    
//    // 轮播文字-- 副文本式
//    if (!_label) {
//        self. label = [[DarkGreyLabel alloc] initWithFrame:CGRectMake(Width*0.125, 0, Width-Width*0.125, Width*0.125)];
//        __block   NSInteger  count = 0;
////        self.label.font = [UIFont systemFontOfSize:12];
////        self.label.tintColor = [UIColor lightGrayColor];
//        self.label.numberOfLines = 0 ;
//        self.label.userInteractionEnabled = YES;
//        self.label.tag =count;
//        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
//        
//        [self.label addGestureRecognizer:labelTapGestureRecognizer];
//        [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer*_Nonnulltimer) {
//            CATransition*tran = [CATransition animation];
//            //tran.type=kCATransitionFade;
//            //配置过度动画类型
//            tran.type = @"cube";
//            tran.subtype=kCATransitionFromTop;
//            [self.label.layer addAnimation:tran forKey:@"trans"];
//            if (self.dataArray.count==0) {
//                return;
//            }
//            self.label.attributedText= self.dataArray[count];
//            if(count == self.dataArray.count-1) {
//                count=0;
//            }else{
//                count=count+1;
//            }
//            self.label.tag =count-1;
//            
//        }];
//        [self.ShufflingLabelView addSubview:_label];
//    }

}
-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    self.HomePageOneCellLabelBlock(self.label.tag !=-1 ?self.label.tag :self.dataArray.count-1);
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    cycleScrollView =_cycleScrollViewImage;
    self.HomePageOneCellImgBlock(index);
}



///轮播图赋值
-(void)cellGetDataWithBanner:(NSMutableArray*)arr{
    NSLog(@"%@",arr);
    // 网络加载图片的轮播器
    if (_cycleScrollViewImage) {
        NSMutableArray *banner_imageArr = [NSMutableArray arrayWithCapacity:0];
        for ( CardModel* model in arr) {
            [banner_imageArr addObject:model.image_url];
        }
        _cycleScrollViewImage.imageURLStringsGroup =   banner_imageArr;
    }
}
///喇叭赋值
-(void)cellGetDataWithWin:(NSMutableArray*)arr{
//    [self.dataArray removeAllObjects];
//    for (HomePageModel * model in arr) {
//        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.title]];
//        [AttributedStr addAttribute:NSFontAttributeName
//         
//                              value:[UIFont systemFontOfSize:13*SizeScale]
//         
//                              range:NSMakeRange(0, model.title.length)];
//        
//       // [AttributedStr addAttribute:NSForegroundColorAttributeName
//         
////                              value:[UIColor colorWithHexString:@"#1757ae"]
////         
////                              range:NSMakeRange(0, model.title.length)];
//        
//        
//        [self.dataArray addObject:AttributedStr];
//    }
//    if (self.dataArray.count==0) {
//        return;
//    }
//    self.label.attributedText= self.dataArray[self.dataArray.count-1];
//
       if (!_headLine3) {
        self.headLine3 = [[SXHeadLine alloc]initWithFrame:CGRectMake(0.125*Width , 0,0.875*Width, 0.125*Width)];
        [self.headLine3 setBgColor:[UIColor whiteColor] textColor:[UIColor colorWithHexString:kDarkGrey] textFont:[UIFont systemFontOfSize:15*SizeScale]];
           NSMutableArray *messageArray = [NSMutableArray arrayWithCapacity:0];
           for (CardModel * model in arr) {
               [messageArray addObject:model.title];
           }
            if (messageArray.count>0) {
            self.headLine3.messageArray = messageArray;
           }
        [self.headLine3 setScrollDuration:1.0 stayDuration:3.0];
        self.headLine3.hasGradient = YES;
        [self.headLine3 start];
        [self.headLine3 changeTapMarqueeAction:^(NSInteger index) {
            self.HomePageOneCellLabelBlock(index);
        }];
        [self.ShufflingLabelView addSubview:self.headLine3];
    }
    if (_headLine3) {
        NSMutableArray *messageArray = [NSMutableArray arrayWithCapacity:0];
        for (CardModel * model in arr) {
            [messageArray addObject:model.title];
        }
        if (messageArray.count>0) {
            self.headLine3.messageArray = messageArray;
        }
    }
}

@end

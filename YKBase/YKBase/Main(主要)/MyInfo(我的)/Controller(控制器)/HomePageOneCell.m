//
//  HomePageOneCell.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "HomePageOneCell.h"
@interface HomePageOneCell ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)    SDCycleScrollView *cycleScrollViewImage;


///数据
@property (nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UILabel *label;
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
    
    // 轮播文字-- 副文本式
    if (!_label) {
        self. label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, Width-40, Width*0.1-5)];
        __block   NSInteger  count = 0;
        self.label.font = [UIFont systemFontOfSize:12];
        self.label.tintColor = [UIColor lightGrayColor];
        self.label.numberOfLines = 1 ;
        [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer*_Nonnulltimer) {
            CATransition*tran = [CATransition animation];
            //tran.type=kCATransitionFade;
            //配置过度动画类型
            tran.type = @"cube";
            tran.subtype=kCATransitionFromTop;
            [self.label.layer addAnimation:tran forKey:@"trans"];
            if (self.dataArray.count==0) {
                return;
            }
            self.label.attributedText= self.dataArray[count];
            if(count== self.dataArray.count-1) {
                
                count=0;
                
            }else{
                
                count=count+1;
            }
            
        }];
        [self.ShufflingLabelView addSubview:  _label];
    }
    
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    cycleScrollView =_cycleScrollViewImage;
    self.HomePageOneCellImgBlock(index);
    
}



///轮播图赋值
-(void)cellGetDataWithBanner:(NSMutableArray*)arr{
    
//    // 网络加载图片的轮播器
//    if (_cycleScrollViewImage) {
//        NSMutableArray *banner_imageArr = [NSMutableArray arrayWithCapacity:0];
//        for (IndianaHomeModel * model in arr) {
//            [banner_imageArr addObject:model.banner_image];
//        }
//        _cycleScrollViewImage.imageURLStringsGroup =   banner_imageArr;
//        
//    }
//    
    
    
    
    
}
///喇叭赋值
-(void)cellGetDataWithWin:(NSMutableArray*)arr{
    [self.dataArray removeAllObjects];
//    for (IndianaHomeModel * model in arr) {
//        
//        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"恭喜 %@ %@获得%@",model.name,model.time_before,model.goods_name]];
//        [AttributedStr addAttribute:NSFontAttributeName
//         
//                              value:[UIFont systemFontOfSize:12]
//         
//                              range:NSMakeRange(3, model.name.length+1)];
//        
//        [AttributedStr addAttribute:NSForegroundColorAttributeName
//         
//                              value:[UIColor colorWithHexString:@"#1757ae"]
//         
//                              range:NSMakeRange(3, model.name.length+1)];
//        
//        
//        [self.dataArray addObject:AttributedStr];
//        
//        
//        // [banner_imageArr addObject:[NSString stringWithFormat:@"恭喜 ""%@"" %@获得%@",model.name,model.time_before,model.goods_name]];
//        
//        
//    }
//    if (self.dataArray.count==0) {
//        return;
//    }
//    self.label.attributedText= self.dataArray[self.dataArray.count-1];
//    
    
}







@end

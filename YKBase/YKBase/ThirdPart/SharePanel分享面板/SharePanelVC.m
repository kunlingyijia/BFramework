//
//  SharePanelVC.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/26.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "SharePanelVC.h"
#import "SharePanelOneCell.h"
#import "SharePanelModel.h"
@interface SharePanelVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SharePanelVC
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //控制器通明的关键代码
    self.modalPresentationStyle =UIModalPresentationCustom;
//    // blur效果
//    UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//    visualEfView.frame = CGRectMake(0, 0, Width, Height);
//    visualEfView.alpha = 0.7;
//    [self.view addSubview:visualEfView];
    //UI
    [self SET_UI];
    //数据
    [self  SET_DATA];
    
}
#pragma mark - 关于UI
-(void)SET_UI{
    [self showBackBtn];
    [self.collectionView collectionViewregisterClassArray:@[@"UICollectionViewCell"]];
    [self.collectionView collectionViewregisterNibArray:@[@"SharePanelOneCell"]];
}
#pragma mark - 关于数据
-(void)SET_DATA{
    NSLog(@"----%lu",(unsigned long)self.dataArray.count);
}

#pragma mark --集合视图代理方法
//集合视图分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//集合视图分区内item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
//item 配置
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    if (indexPath.row>self.dataArray.count-1||self.dataArray.count==0) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        
    }else{
    SharePanelOneCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SharePanelOneCell" forIndexPath:indexPath];
    //cell 赋值
    cell.model = indexPath.row >= self.dataArray.count ? nil :self.dataArray[indexPath.row];
    // cell 其他配置
        return cell;
    }

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SharePanelModel * model= self.dataArray[indexPath.row];
    self.SharePanelVCBlock(model.platformType);
    DismissVC

}
#pragma mark -设置页眉和页脚

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *reusableview = nil;
//    
//    
//    if (kind == UICollectionElementKindSectionHeader){
//        UICollectionReusableView *headerView= [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header111" forIndexPath:indexPath];
//        
//        reusableview = headerView;
//        
//    }
//    
//    if (kind == UICollectionElementKindSectionFooter){
//        
//        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footder111" forIndexPath:indexPath];
//        
//        reusableview = footerview;
//        
//    }
//    
//    return reusableview;
//    
//    
//}

#pragma 集合视图 --约束代理方法
//item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(Width/4, Width/4/4*5);
    
}
//设置每个cell上下左右相距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}
//设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0 ;
    
}
//// 设置最小列间距，也就是左行与右一行的中间最小间隔
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    
//    return 0;
//}
////灵活的设置每个分区的页眉的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    
//    return  CGSizeMake(0, 0);
//    
//}
////灵活的设置每个分区的页脚的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    
//    return CGSizeMake( 0 ,0);
//    
//    
//}
#pragma mark - 取消分享
- (IBAction)cancelShareAction:(UIButton *)sender {
    DismissVC
}




@end

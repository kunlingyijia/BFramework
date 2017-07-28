//
//  BaseWKWebviewVC.h
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/27.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWKWebviewVC : BaseViewController
////声明一个方法，外接调用时，只需要传递一个URL即可
//- (void)loadHTML:(NSString *)htmlString;
@property(nonatomic,copy)NSString *urlStr;
- (instancetype)initWithUrl:(NSString *)url;

@end

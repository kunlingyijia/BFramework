//
//  ThirdPartyTool.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/21.
//  Copyright © 2017年 bianming. All rights reserved.
//

#import "ThirdPartyTool.h"
#import <MapKit/MapKit.h>
#import "SharePanelVC.h"
#import "SharePanelModel.h"
#import "BaseSendTextView.h"

@implementation MapModel
@end
@implementation PayModel
@end
@implementation ShareModel
@end

@implementation ThirdPartyTool
#pragma mark -  跳转到第三方地图
+(void)PushThrdPatyMapWithStart:(MapModel*)startModel End:(MapModel*)endModel{
    NSString *startname =startModel.address;//我的位置
    double startlng = [startModel.lng doubleValue];//经度
    double startlat = [startModel.lat doubleValue];//纬度
    NSString *Endname =endModel.address;//目的地
    double Endlng = [endModel.lng doubleValue];//经度
    double Endlat = [endModel.lat doubleValue];//纬度
    [DWAlertTool alertActionSheetWithTitle:nil message:nil OKWithTitleOne:@"苹果地图" OKWithTitleTwo:@"百度地图" OKWithTitleThree:@"高德地图" CancelWithTitle:@"取消" withOKDefaultOne:^(UIAlertAction *defaultaction) {
        //苹果地图
        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(Endlat , Endlng );
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        currentLocation.name =@"我的位置";
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil]];
        toLocation.name =Endname;
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    } withOKDefaultTwo:^(UIAlertAction *defaultaction) {
        //百度地图
        NSString *name = Endname;
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]) {
            CLLocationCoordinate2D Coordinate ;
            Coordinate.latitude = Endlat;
            Coordinate.longitude = Endlng;
            CLLocationCoordinate2D Coordinate2D = [self BD09FromGCJ02:Coordinate];
            NSString *urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:%@&mode=transit",startlat, startlng,  Coordinate2D.latitude, Coordinate2D.longitude, name];
            [self openMap:urlString];
        }else {
            [self sheetAction:@"百度地图"];
        }
    } withOKDefaultThree:^(UIAlertAction *defaultaction) {
        //高德
        NSString *name = Endname;
        CLLocationCoordinate2D Coordinate ;
        Coordinate.latitude = Endlat;
        Coordinate.longitude = Endlng;
        //style  导航方式(0 速度快; 1 费用少; 2 路程短; 3 不走高速；4 躲避拥堵；5 不走高速且避免收费；6 不走高速且躲避拥堵；7 躲避收费和拥堵；8 不走高速躲避收费和拥堵)
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]){
            NSString *urlString = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=applicationScheme&poiname=fangheng&poiid=BGVIS&lat=%f&lon=%f&dev=0&style=2",name, Coordinate.latitude , Coordinate.longitude ];
            [self openMap:urlString];
        }else {
            [self sheetAction:@"高德地图"];
        }
    } withCancel:^(UIAlertAction *cancelaction) {
        
    }];

}
+ (void)openMap:(NSString *)urlString {
    NSString *string = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:string];
    [[UIApplication sharedApplication] openURL:url];
}

// 高德坐标转百度坐标
+ (CLLocationCoordinate2D)BD09FromGCJ02:(CLLocationCoordinate2D)coor
{
    CLLocationDegrees x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    CLLocationDegrees x = coor.longitude, y = coor.latitude;
    CLLocationDegrees z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    CLLocationDegrees theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    CLLocationDegrees bd_lon = z * cos(theta) + 0.0065;
    CLLocationDegrees bd_lat = z * sin(theta) + 0.006;
    return CLLocationCoordinate2DMake(bd_lat, bd_lon);
}
+ (void)sheetAction:(NSString *)title {
    [DWAlertTool alertWithTitle:[NSString stringWithFormat:@"您还未安装%@客户端,请安装", title] message:nil OKWithTitle:@"确定" withOKDefault:^(UIAlertAction *defaultaction) {
        
    }];
    
}
#pragma mark - 更新版本
+(void)updateVerison{
    VerisonModel *model = [[VerisonModel alloc]init];
    model.os = 1;
    //代码实现获得应用的Verison号：
    NSString *oldVerison = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    __weak typeof(self) weakSelf = self;
    [HTTPTool requestVersionUWithParm:model active:YES success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode == 1) {
        VerisonModel* model =[VerisonModel yy_modelWithDictionary:((NSDictionary*)baseRes.data)];
        if ([oldVerison compare:model.versionCode]==NSOrderedAscending) {
        //NSOrderedAscending (升序)
        [weakSelf addMandatoryAlertAction:model];
        }
    }
    } faild:^(id  _Nullable error) {
        
    }];
}
#pragma mark - 强制更新
+(void)addMandatoryAlertAction:(VerisonModel*)model{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"发现新版本\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(30, 65, 210, 180)];
    textView.font = [UIFont systemFontOfSize:15];
    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    textView.text = model.content;
    [alertC.view addSubview:textView];
    __weak typeof(self) weakSelf = self;
    UIAlertAction * cancel= [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction * OK = [UIAlertAction actionWithTitle:@"我要去升级" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://fir.im/l874"]];
        [weakSelf addMandatoryAlertAction:model];
        
    }];
    if (![model.is_update isEqualToString:@"1"]) {
        [alertC addAction:cancel];
    }
    [alertC addAction:OK];
    [[DWAlertTool getCurrentUIVC] presentViewController:alertC animated:YES completion:nil];
    
}
#pragma mark - 刷新加载
+(void)MJRefreshView:(id)view  Header:(BOOL)header Footer:(BOOL)footer  HeaderBlock:(MJRefreshBlock)headerBlock FooterBlock:(MJRefreshBlock)footerBlock{
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView * tableView = view;
     //下拉刷新
     header ==YES ? tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        headerBlock();
     }]:nil;
        //上拉加载
     footer == YES ?   tableView. mj_footer=
        [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            footerBlock();
        }] : nil;

    }
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView * scrollView = view;
        //下拉刷新
        header ==YES ?   scrollView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            headerBlock();
        }]:nil;
        //上拉加载
        footer == YES ?   scrollView. mj_footer=
        [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            footerBlock();
        }] : nil;
        
    }
    if ([view isKindOfClass:[UICollectionView class]]) {
        UICollectionView * collectionView = view;
        //下拉刷新
        header ==YES ?   collectionView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            headerBlock();
        }]:nil;
        //上拉加载
        footer == YES ?   collectionView. mj_footer=
        [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            footerBlock();
        }] : nil;
    }
    
    if ([view isKindOfClass:[WKWebView class]]) {
        WKWebView * webView = view;
        //下拉刷新
        header ==YES ?   webView.scrollView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            headerBlock();
        }]:nil;
        //上拉加载
        footer == YES ?   webView.scrollView. mj_footer=
        [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            footerBlock();
        }] : nil;
    }

    
    
}
#pragma mark - 开始加载
+(void)MJRefreshBeginRefreView:(id)view{
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView * tableView = view;
        [tableView.mj_header beginRefreshing];
    }
    if ([view isKindOfClass:[UITableView class]]) {
        UIScrollView * scrollView = view;
        [scrollView.mj_header beginRefreshing];
    }
    if ([view isKindOfClass:[UITableView class]]) {
        UICollectionView * collectionView = view;
        [collectionView.mj_header beginRefreshing];
    }
    if ([view isKindOfClass:[WKWebView class]]) {
         WKWebView * webView = view;
         [webView.scrollView.mj_header beginRefreshing];
    }
}
#pragma mark - 结束加载
+(void)MJRefreshEndRefreView:(id)view{
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView * tableView = view;
        [tableView.mj_header endRefreshing];
        [tableView.mj_footer endRefreshing];
    }
    if ([view isKindOfClass:[UITableView class]]) {
        UIScrollView * scrollView = view;
        [scrollView.mj_header endRefreshing];
        [scrollView.mj_footer endRefreshing];
    }
    if ([view isKindOfClass:[UITableView class]]) {
        UICollectionView * collectionView = view;
        [collectionView.mj_header endRefreshing];
        [collectionView.mj_footer endRefreshing];
    }
    if ([view isKindOfClass:[WKWebView class]]) {
        WKWebView * webView = view;
        [webView.scrollView.mj_header endRefreshing];
        [webView.scrollView.mj_footer endRefreshing];

    }

    
}


#pragma mark - 微信 支付宝-支付
+(void)PayType:(YKPayType)Type PayModel:(PayModel*)model{
    if (Type==PayTypeZFB) {
        NSURL * myURL_APP_A = [NSURL URLWithString:@"alipay:"];
        if (![[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
            [DWAlertTool showToast:@"尚未安装支付宝"];
            
        }else{
            //          /*
            //         *商户的唯一的parnter和seller。
            //         *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
            //         */
            //        /*============================================================================*/
            //        /*=======================需要填写商户app申请的===================================*/
            //        /*============================================================================*/
            //        //表示商户id 支付宝签订协议后分配的id 需要公司营业执照(公司弄)
            //        NSString *partner = @"2088321000596152";
            //        //邮箱地址 绑定总账号(公司弄) 绑定公司账号, 用于客户交易资金转账
            //        NSString *seller = @"fzyimin@sina.com";
            //        //私钥:是用来加密用的 公钥:是用来解密用的(我们用不上)  (后台弄的)
            //    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALys+oYaxqv4FYju8C1poM6qmHLjWPnXzqEJT0NxyFXgdaK/Qe9DcpcASod9mIAdlLIxJEyYNlWeonAJVYW8pQ+pTVGwI9n0iaT71ldWQzcMN3Dvi/+zpgw3HxxO7HJtEIlR84pvILv1yceCZCqqQ4O/4SemsG00oTiTyD3SM2ZvAgMBAAECgYBLToeX6ywNC7Icu7Hljll+45yBjri+0CJLKFoYw1uA21xYnxoEE9my54zX04uA502oafDhGYfmWLDhIvidrpP6oaluURb/gbV5Bdcm98gGGVgm6lpK+G5N/eawXDjP0ZjxXb114Y/Hn/oVFVM9OqcujFSV+Wg4JgJ4Mmtdr35gYQJBAPbhx030xPcep8/dL5QQMc7ddoOrfxXewKcpDmZJi2ey381X+DhuphQ5gSVBbbunRiDCEcuXFY+R7xrgnP+viWcCQQDDpN8DfqRRl+cUhc0z/TbnSPJkMT/IQoFeFOE7wMBcDIBoQePEDsr56mtc/trIUh/L6evP9bkjLzWJs/kb/i25AkEAtoOf1k/4NUEiipdYjzuRtv8emKT2ZPKytmGx1YjVWKpyrdo1FXMnsJf6k9JVD3/QZnNSuJJPTD506AfZyWS6TQJANdeF2Hxd1GatnaRFGO2y0mvs6U30c7R5zd6JLdyaE7sNC6Q2fppjmeu9qFYq975CKegykYTacqhnX4I8KEwHYQJAby60iHMAYfSUpu//f5LMMRFK2sVif9aqlYbepJcAzJ6zbiSG5E+0xg/MjEj/Blg9rNsqDG4RECGJG2nPR72O8g==";
            //    /*============================================================================*/
            //        /*============================================================================*/
            //        /*============================================================================*/
            //
            //        //partner和seller获取失败,提示
            //        if ([partner length] == 0 ||
            //            [seller length] == 0 ||
            //            [privateKey length] == 0)
            //        {
            //            NSLog(@"缺少partner或者seller或者私钥");
            //            return;
            //        }
            //
            //        /*
            //         *生成订单信息及签名
            //         */
            //        //将商品信息赋予AlixPayOrder的成员变量 ( 以下网络请求来的数据)
            //        Order *order = [[Order alloc] init];
            //        order.partner = partner;
            //        order.seller = seller;
            //        order.tradeNO = orderID; //订单ID（由商家自行制定）
            //        order.productName = name; //商品标题
            //        order.productDescription = explain; //商品描述
            //        order.amount = [NSString stringWithFormat:@"%.2f",price]; //商品价格.2f 其他值不行 会失败
            //        order.notifyURL =  url; //回调URL
            //
            //        //以下信息是默认信息 不需要更改
            //        order.service = @"mobile.securitypay.pay";
            //        order.paymentType = @"1";
            //        order.inputCharset = @"utf-8";
            //        order.itBPay = @"30m";
            //        order.showUrl = @"m.alipay.com";
            //
            //        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
            //        //标识 支付后根据这个值跳转到这个App (要在info中设置 见图片http://blog.sina.com.cn/s/blog_6f72ff900102v4vp.html)
         
            [[AlipaySDK defaultService] payOrder:model.prealipay fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                NSInteger orderState=[resultDic[@"resultStatus"]integerValue];
                if (orderState==9000) {
                [YKNotification postNotificationName:@"支付成功" object:@"支付成功" userInfo:@{}];
                }else{
                switch (orderState) {
                    case 8000:{
                        [DWAlertTool showToast:@"支付宝-订单正在处理中"];
                        break;
                    }
                    case 4000:{
                        [DWAlertTool showToast:@"支付宝-订单支付失败"];
                        break;
                    }
                    case 6001:{
                        [DWAlertTool showToast:@"支付宝-订单取消"];
                        break;
                    }
                    case 6002:{
                        [DWAlertTool showToast:@"支付宝-网络连接出错"];
                        break;
                    }
                    default:{
                        break;
                    }
                }
            }
            }];
        }
    }
    if (Type==PayTypeWX) {
        if ([WXApi isWXAppInstalled]) {
            PayReq *request = [[PayReq alloc] init];
            //商家向财付通申请的商家id
            request.partnerId = model.partnerid;
            //预支付订单:绑定了我的商品的基本信息 (后台生成的id)
            request.prepayId= model.prepayid;
            //商家根据财付通文档填写的数据和签名 : 微信的标识 意味着是微信支付 不是别的服务
            request.package = model.package;
            //随机串，防重发
            request.nonceStr= model.noncestr;
            //时间戳，防重发
            request.timeStamp= model.timestamp;
            //商家根据微信开放平台文档对数据做的签名: 是一种加密方式 所有的支付都需要加密
            request.sign= model.sign;
            [WXApi sendReq:request];
           }else{
            [DWAlertTool showToast:@"尚未安装微信"];
        }

    }

}
#pragma mark - 友盟分享
///友盟 分享
+(void)UShareType:(YKShareType)shareType LayoutType:(YKLayoutType)layoutType ShareModel:(ShareModel*)model;{
   NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:0];
   if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
        SharePanelModel *WechatSession =[SharePanelModel new];
        WechatSession.title = @"微信好友";
        WechatSession.image = @"微信";
        WechatSession.platformType = UMSocialPlatformType_WechatSession;
        SharePanelModel *WechatTimeLine =[SharePanelModel new];
        WechatTimeLine.title = @"朋友圈";
        WechatTimeLine.image = @"朋友圈";
        WechatTimeLine.platformType = UMSocialPlatformType_WechatTimeLine;
        SharePanelModel *WechatFavorite =[SharePanelModel new];
        WechatFavorite.title = @"微信收藏";
        WechatFavorite.image = @"WeiBo";
        WechatFavorite.platformType = UMSocialPlatformType_WechatFavorite;
        [dataArray addObject:WechatSession];
        [dataArray addObject:WechatTimeLine];
        [dataArray addObject:WechatFavorite];
       }
     if ([QQApiInterface isQQInstalled]&&[QQApiInterface isQQSupportApi]) {
    SharePanelModel *QQ =[SharePanelModel new];
    QQ.title = @"QQ好友";
    QQ.image = @"QQ好友";
    QQ.platformType = UMSocialPlatformType_QQ;
    SharePanelModel *Qzone =[SharePanelModel new];
    Qzone.title = @"QQ空间";
    Qzone.image = @"QQ空间";
    Qzone.platformType = UMSocialPlatformType_Qzone;
    
    [dataArray addObject:QQ];
    [dataArray addObject:Qzone];
    }
    //新浪微博
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibo://"]]) {
        SharePanelModel *Sina =[SharePanelModel new];
        Sina.title = @"微博";
        Sina.image = @"微博";
        Sina.platformType = UMSocialPlatformType_Sina;
        [dataArray addObject:Sina];
    }
  
  
    if (layoutType ==LayoutType_Pop_up) {
           BaseSendTextView* textView = [[BaseSendTextView alloc]initWithFrame:[DWAlertTool getCurrentUIVC].view.bounds andButtonTitleAndImages:dataArray withColumnNums:3 withBlock:^(id btnInfo, NSInteger index) {
                [UIView animateWithDuration:0.7 * (dataArray.count+1) animations:^{
                } completion:^(BOOL finished) {
                    [textView  removeFromSuperview];
                    if (index>-1) {
                        SharePanelModel * panelModel = dataArray[index];
                        [self ShareType:shareType formType:panelModel.platformType ShareModel:model];
                    }
                }];
            }];
            [[DWAlertTool getCurrentUIVC].view addSubview:textView];
            [textView showSendTextView];
    }
    if (layoutType ==LayoutType_Draw) {
    SharePanelVC *VC = GetVC(SharePanelVC);
    VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    VC.dataArray = dataArray;
    __weak typeof(self) weakSelf = self;
    VC.SharePanelVCBlock =^(UMSocialPlatformType platformType){
         [weakSelf ShareType:shareType formType:platformType ShareModel:model];
    };
    [[DWAlertTool getCurrentUIVC] presentViewController:VC animated:YES completion:^{}];
    }

}

+(void)ShareType:(YKShareType)Type formType:(UMSocialPlatformType)platformType ShareModel:(ShareModel*)model{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    if (Type ==ShareTypeText) {
        //设置文本
        messageObject.text = model.text ? model.text :nil;
    }else
    if (Type ==ShareTypeImageAndText) {
        //设置文本
        messageObject.text = model.text ? model.text :nil;
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage = model.thumbImage ? [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.thumbImage]]:nil;
        [shareObject setShareImage:model.shareImage];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }else
    if (Type ==ShareTypeUrl) {
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:model.text descr:model.descr thumImage:model.thumImage];
        //设置网页地址
        shareObject.webpageUrl =model.webpageUrl;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }else{
        
    }
     //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[DWAlertTool getCurrentUIVC] completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
            NSDictionary *userInfo=            error.userInfo;
            [DWAlertTool showToast:userInfo[@"message"]];
        }else{
//            NSLog(@"response data is %@",data);
//            UMSocialShareResponse *response = data;
        }
    }];
}
#pragma mark - 第三方登录
+(void)ULoginType:(UMSocialPlatformType)platformType{
     [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:[DWAlertTool getCurrentUIVC] completion:^(id result, NSError *error) {
      
         if (error) {
             NSDictionary *userInfo=            error.userInfo;
             [DWAlertTool showToast:userInfo[@"message"]];

         }else {
             
             UMSocialUserInfoResponse *resp = result;
             // 第三方登录数据(为空表示平台未提供)
             // 授权数据
             NSLog(@" uid: %@", resp.uid);
             NSLog(@" openid: %@", resp.openid);
             NSLog(@" accessToken: %@", resp.accessToken);
             NSLog(@" refreshToken: %@", resp.refreshToken);
             NSLog(@" expiration: %@", resp.expiration);
             // 用户数据
             NSLog(@" name: %@", resp.name);
             NSLog(@" iconurl: %@", resp.iconurl);
             NSLog(@" gender: %@", resp.gender);
             // 第三方平台SDK原始数据
             NSLog(@" originalResponse: %@", resp.originalResponse);
       
         }
     
     
     }];
    
}

@end

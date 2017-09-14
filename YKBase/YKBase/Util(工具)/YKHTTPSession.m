//
//  YKHTTPSession.m
//  DWduifubao
//
//  Created by 席亚坤 on 2017/7/12.
//  Copyright © 2017年 bianming. All rights reserved.
//
#import "YKHTTPSession.h"
#import "YKAppClient.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>
@implementation YKHTTPSession{
    UIWebView *callPhoneWebview;
}
+ (YKHTTPSession *)shareSession; {
    static YKHTTPSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[YKHTTPSession alloc] init];
    });
    return session;
}
//网络请求
- (nullable NSURLSessionDataTask *)requestDataWithParm:(nullable id)parm act:( nonnull NSString *)actName sign:(nullable id)sign method:(YKRequestMethod)method  showHUD:(BOOL)showHUD active:(BOOL)active success:(nullable YKSuccessCallback)success faild:(nullable YKFaildCallback)faild {
    //showHUD ==YES ?[[LoadWaitSingle shareManager]showLoadWaitViewImage:@"巧巧科技加载灰"] :nil;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:  SVProgressHUDStyleCustom];
    //设置背景颜色为透明色
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    //[SVProgressHUD  setMinimumDismissTimeInterval:40];
    //利用SVP提供类方法设置 通过UIImage分类方法返回的动态UIImage对象
    NSData* data =[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"巧巧科技加载灰" ofType:@"gif"]];
    showHUD == YES ?  [SVProgressHUD showImage: [UIImage sd_animatedGIFWithData:data] status:@""] : nil;
    [SVProgressHUD setForegroundColor :[UIColor colorWithHexString:kDarkGrey]];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:10.0*SizeScale]];
    NSString *url = [NSString stringWithFormat:@"%@%@%@&sign=%@",kServerUrl,ACT_API,actName,sign];
    YKAppClient*  manager = [YKAppClient sharedClient];
    _BaseVC.view.userInteractionEnabled = active;
//    [DWAlertTool getCurrentUIVC].view.userInteractionEnabled = active;
    NSLog(@"断点***********\n\n%@&request=%@\n\n***********",url,parm);
    if (method == HTTPSRequestTypeGET) {
        return   [manager GET:url parameters:[NSDictionary dictionaryWithObject:parm forKey:@"request"] progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (![responseObject[@"resultCode"]isEqualToString:@"1"]) {
                _BaseVC.view.userInteractionEnabled =YES;
//                [DWAlertTool getCurrentUIVC].view.userInteractionEnabled = YES;
                NSLog(@"错误码:--:%@\n错信息---:%@",responseObject[@"resultCode"],responseObject[@"msg"]);
            }
            [SVProgressHUD dismiss];
            //[[LoadWaitSingle shareManager] hideLoadWaitView];
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            _BaseVC.view.userInteractionEnabled =YES;
//            [DWAlertTool getCurrentUIVC].view.userInteractionEnabled = YES;
            faild(error);
            NSLog(@"error--%@",error);
            [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
            [self showError:error];
            //[[LoadWaitSingle shareManager] hideLoadWaitView];
        }];
    }
    return  nil;
}

#pragma mark - 网络监测者
+(void)AFNetworkStatus
{
    //1.创建网络监测者
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                networkReachabilityStatusUnknown();
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                //networkReachabilityStatusReachableViaWWAN();
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            default:
                break;
        }
    }] ;
}
void networkReachabilityStatusUnknown()
{
    [DWAlertTool alertWithTitle:[NSString stringWithFormat:@"\"%@\" 已关闭无线数据",appName] message:@"您可以在”设置“中为此应用程序打开无线数据" OKWithTitle:@"设置" CancelWithTitle:@"取消" withOKDefault:^(UIAlertAction *defaultaction) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
    } withCancel:^(UIAlertAction *cancelaction) {
    }];
}
void networkReachabilityStatusReachableViaWWAN()
{
    [DWAlertTool showToast:@"蜂窝数据网"];
    //    [DWAlertTool alertWithTitle:@"“VRMAX”正在使用流量，确定要如此土豪吗？" message:@"建议开启WIFI后观看视频。" OKWithTitle:@"设置" CancelWithTitle:@"取消" withOKDefault:^(UIAlertAction *defaultaction) {
    //        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    //        if([[UIApplication sharedApplication] canOpenURL:url]) {
    //            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
    //            [[UIApplication sharedApplication] openURL:url];
    //        }
    //    } withCancel:^(UIAlertAction *cancelaction) {
    //    }];
}
///上传图片
-(void)UPImageToServer:(NSArray*)imageArr toKb:(NSInteger)kb success:(YKSuccessImageArr)success faild:(YKFaildCallback)faild{
    NSString *password = [NSString stringWithFormat:@"%@%@%@",[YKDataTool getimage_account],[YKDataTool getimage_hostname],[[YKDataTool getimage_password]MD5Hash] ];
    NSDictionary * dic = @{@"image_account":[YKDataTool getimage_account],@"image_password":[password MD5Hash]};
    AFHTTPSessionManager *UPmanager = [AFHTTPSessionManager manager];
    UPmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                           @"text/html",
                                                           @"image/jpeg",
                                                           @"image/png",
                                                           @"application/octet-stream",
                                                           @"text/json",
                                                           nil];
    [[LoadWaitSingle shareManager]showLoadWaitViewImage:@"巧巧科技加载灰"];
    [UPmanager POST:[YKDataTool getimage_hostname] parameters:[dic yy_modelToJSONObject] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i= 0; i< imageArr.count; i++) {
            UIImage * image =  [UIImage scaleImageAtPixel:imageArr [i] pixel:1024];
            //1.把图片转换成二进制流
            NSData *imageData= [ UIImage scaleImage:image toKb:kb];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat =@"yyyy-MM-dd-HH-mm-ss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            //2.上传图片
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file%d",i]fileName:[NSString stringWithFormat:@"%@%d.jpg",fileName, i] mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //[SVProgressHUD showProgress:uploadProgress.fractionCompleted status:@"上传中"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject[@"data"]);
        [[LoadWaitSingle shareManager] hideLoadWaitView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error);
        [[LoadWaitSingle shareManager] hideLoadWaitView];
        [self showError:error];
        
    }];
}

//显示错误信息
-(void)showError:(NSError *)error{
    NSString * errorStr =error.localizedDescription;
    if (errorStr.length>1) {
        [SVProgressHUD showErrorWithStatus:  [error.localizedDescription   substringToIndex:error.localizedDescription.length-1]];
    }else{
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
    }
    
}

/**
 *  拨打电话
 *
 *  @param phoneNumber 要拨打的号码
 *  @param selfView        拨号所在的页面
 */
- (void)CallPhoneNumber:(NSString *)phoneNumber inView:(UIView *)selfView
{
    if (!callPhoneWebview) {
        callPhoneWebview = [[UIWebView alloc] init];
    }
    if (![callPhoneWebview isDescendantOfView:selfView]) {
        [selfView addSubview:callPhoneWebview];
    }
    NSString *urlString = [NSString stringWithFormat:@"tel://%@", phoneNumber];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [callPhoneWebview loadRequest:request];
}
///获取城市列表
+ (nullable NSMutableArray *)getCityData
{
    NSArray *jsonArray = [[NSArray alloc]init];
    NSData *fileData = [[NSData alloc]init];
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    if ([UD objectForKey:@"city"] == nil) {
        NSString *path;
        path = [[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"];
        fileData = [NSData dataWithContentsOfFile:path];
        [UD setObject:fileData forKey:@"city"];
        [UD synchronize];
    }else {
        fileData = [UD objectForKey:@"city"];
    }
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
    jsonArray = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
    for (NSDictionary *dict in jsonArray) {
        [array addObject:dict];
    }
    return array;
}


@end

//
//  CertificationVC.m
//  YKBase
//
//  Created by 席亚坤 on 2017/8/9.
//  Copyright © 2017年 席亚坤. All rights reserved.
//

#import "CertificationVC.h"
#import "DWBankViewController.h"
#import "Bank_Region_Bank_Branch.h"
#import "CertificationModel.h"
#import "BankCardListVC.h"
#import "RegionViewController.h"
@interface CertificationVC ()
@property(nonatomic,strong) NSString *id_card_photoUrl;
@property(nonatomic,strong)NSString * id_card_back_photoUrl;
@property(nonatomic,strong)NSString * hand_id_card_photoUrl;
@property(nonatomic,strong)NSString * bank_card_photoUrl;
@end
@implementation CertificationVC
- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
    [self SET_UI];
    //数据
    [self  SET_DATA];
    //创建观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Bank_Region_Bank_BranchAction:) name:@"Bank_Region_Bank_Branch" object:nil];
}
#pragma mark - 创建观察者返回数据
-(void)Bank_Region_Bank_BranchAction:(NSNotification*)sender{
    NSDictionary * dic = [sender.userInfo objectForKey:@"Bank_Region_Bank_Branch"];
    Bank_Region_Bank_BranchModel * model = [Bank_Region_Bank_BranchModel yy_modelWithJSON:dic];
    self.bank_name.text = model.bank_name;
}

#pragma mark - 关于UI
-(void)SET_UI{
    [self showBackBtn];
    self.title = @"实名认证";
    self.address.placeholder = @"请输入详细地址(包括省市区/县)";
}
#pragma mark - 关于数据
-(void)SET_DATA{
    //0-未认证 1-认证中2-认证成功3-认证失败
    if ([[YKHTTPSession shareSession].userinfo.certify_status isEqualToString:@"3"]) {
        __weak typeof(self) weakSelf = self;
        self.submitBtn.titleLabel.text = @"重新验证";
        NSURLSessionDataTask * task =  [HTTPTool requestCertifyInfoWithParm:@{} active:YES success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode==1) {
                CertificationModel *model = [CertificationModel yy_modelWithJSON:baseRes.data];
                [DWAlertTool alertWithTitle:@"拒绝原因" message:model.remark OKWithTitle:@"确定" withOKDefault:^(UIAlertAction *defaultaction) {
                }];
                weakSelf.real_name.text = model.real_name;
                weakSelf.id_card.text = model.id_card;
                weakSelf.bank_card_no.text = model.bank_card_no;
                weakSelf.bank_name.text = model.bank_name;
                weakSelf.bind_mobile.text = model.bind_mobile;
                weakSelf.address.text = model.address;
                [_id_card_photo SD_WebimageUrlStr:model.id_card_photo placeholderImage:nil];
                _id_card_photoUrl =model.id_card_photo;
                [_id_card_back_photo SD_WebimageUrlStr:model.id_card_back_photo placeholderImage:nil];
                _id_card_back_photoUrl =model.id_card_back_photo;
                [_hand_id_card_photo SD_WebimageUrlStr:model.hand_id_card_photo placeholderImage:nil];
                _hand_id_card_photoUrl =model.hand_id_card_photo;
                [_bank_card_photo SD_WebimageUrlStr:model.bank_card_photo placeholderImage:nil];
                _bank_card_photoUrl =model.bank_card_photo;
            }
        } faild:^(NSError * _Nullable error) {
        }];
        if (task) {
            [self.sessionArray addObject:task];
        }
    }
}

#pragma mark - 选择图片
- (IBAction)bankAction:(UIButton *)sender {
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    ImageChooseVC* VC = [[ImageChooseVC alloc]initWithNibName:@"ImageChooseVC" bundle:nil];
    VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    VC.imageType = EditedImage;
    VC.zoom= 0.6;
    VC.ImageChooseVCBlock =^(UIImage *image){
            [[YKHTTPSession shareSession]UPImageToServer:@[image] toKb:100 success:^(NSArray *urlArr) {
            NSDictionary * dic = urlArr[0];
            switch (sender.tag) {
                case 401:
                {
                    weakSelf.id_card_photoUrl = dic[@"url"];
                    weakSelf.id_card_photo.image = image;
                    break;
                }
                case 402:
                {
                    weakSelf.id_card_back_photoUrl = dic[@"url"];
                    weakSelf.id_card_back_photo.image = image;
                    break;
                }
                case 403:
                {
                    weakSelf.hand_id_card_photoUrl = dic[@"url"];
                    weakSelf.hand_id_card_photo.image = image;
                    break;
                }
                case 404:
                {
                    weakSelf.bank_card_photoUrl = dic[@"url"];
                    weakSelf.bank_card_photo.image = image;
                    break;
                }
                default:{
                    break;
                }
            }
            
        } faild:^(id error) {
            
        }];
    };
    [self presentViewController:VC animated:NO completion:nil];
    
}
#pragma mark - 选择银行卡
- (IBAction)BankNameAction:(UIButton *)sender {
    [self.view endEditing:YES];
    //跳转
    BankCardListVC * VC =  GetVC(BankCardListVC);
    __weak typeof(self) weakSelf = self;
    VC.BankCardListVCBlock =^(NSString * bankName){
        weakSelf.bank_name.text = bankName;
    };
    PushVC(VC);
}
#pragma mark - 选择地区
- (IBAction)ChooseZoneAction:(UIButton *)sender {
    [self.view endEditing:YES];
    //跳转
    RegionViewController * VC =  GetVC(RegionViewController);
    VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [VC ReqionReturn:^(NSDictionary *reqionDic) {
        NSLog(@"---------------------%@",reqionDic);
        //        [self.zone setTitle:reqionDic[@"name"] forState:(UIControlStateNormal)];
        //        self.MCModel.zone =reqionDic[@"name"];
        //        self.MCModel. province_id = reqionDic[@"province_id"];
        //        self.MCModel.city_id = reqionDic[@"city_id"];
        //        self.MCModel.region_id = reqionDic[@"region_id"];
        
    }];
    PresentVC(VC)
}


#pragma mark - 提交
- (IBAction)submitBtn:(SubmitBtn *)sender {
    if ([self IF]) {
        CertificationModel *model =[CertificationModel new];
        model.real_name = self.real_name.text;
        model.id_card= self.id_card.text ;
        model.bank_card_no= self.bank_card_no.text;
        model.bank_name = self.bank_name.text;
        model.bind_mobile= self.bind_mobile.text ;
        model.address = self.address.text;
        model.id_card_photo=_id_card_photoUrl ;
        model.id_card_back_photo=_id_card_back_photoUrl ;
        model.hand_id_card_photo=_hand_id_card_photoUrl ;
        model.bank_card_photo= _bank_card_photoUrl ;
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask * task =  [HTTPTool requestCertifyWithParm:model active:NO success:^(BaseResponse * _Nullable baseRes) {
            if (baseRes.resultCode==1) {
                [DWAlertTool showToast:@"提交成功"];
                [weakSelf  requestUserInfo];
            }
        } faild:^(NSError * _Nullable error) {
            
        }];
        if (task) {
            [self.sessionArray addObject:task];
        }
    }
}
#pragma mark - 请求个人信息
-(void)requestUserInfo{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * task =  [HTTPTool  requestUserInfoWithParm:@{} active:NO success:^(BaseResponse * _Nullable baseRes) {
        if (baseRes.resultCode ==1) {
            // 在主线程中延迟执行某动作，不会卡主主线程，不影响后面的东做执行
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(backTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //返回
                [weakSelf.navigationController popViewControllerAnimated:YES] ;
            });
        }
    } faild:^(NSError * _Nullable error) {
        
    }];
    if (task) {
        [self.sessionArray addObject:task];
    }
}
#pragma mark - 判断条件
-(BOOL)IF{
    [self.view endEditing:YES];
    BOOL  Y = YES;
    if (self.real_name.text.length==0) {
        [DWAlertTool showToast:@"请输入真实姓名"];
        return NO;
    }
    if (![RegularTool checkUserIdCard:self.id_card.text]) {
        [DWAlertTool showToast:@"身份证号码输入有误"];
        return NO;
    }
    if (![RegularTool checkBankNumber:_bank_card_no.text]) {
        [DWAlertTool showToast:@"借记卡号输入有误"];
        return NO;
    }
    if (self.bank_name.text.length==0) {
        [DWAlertTool showToast:@"请选择发卡银行"];
        return NO;
    }
    if (![RegularTool checkTelNumber:self.bind_mobile.text]) {
        [DWAlertTool showToast:@"手机号码输入有误"];
        return NO;
    }
    if (self.address.text.length==0) {
        [DWAlertTool showToast:@"请输入详细地址"];
        return NO;
    }
    if (self.id_card_photoUrl.length==0) {
        [DWAlertTool showToast:@"请选择身份证正面照片"];
        return NO;
    }
    if (self.id_card_back_photoUrl.length==0) {
        [DWAlertTool showToast:@"请选择身份证背面照片"];
        return NO;
    }
    if (self.hand_id_card_photoUrl.length==0) {
        [DWAlertTool showToast:@"请选择手持身份证照片"];
        return NO;
    }
    if (self.bank_card_photoUrl.length==0) {
        [DWAlertTool showToast:@"请选择储蓄卡正面照片"];
        return NO;
    }
    
    return Y;
}
#pragma mark - dealloc
- (void)dealloc
{
    
    NSLog(@"%@销毁了", [self class]);
}
@end

